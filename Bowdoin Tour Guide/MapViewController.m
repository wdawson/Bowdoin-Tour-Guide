//
//  MapViewController.m
//  Bowdoin Tour Guide
//
//  Created by William Dawson on 11/15/11.
//  Copyright (c) 2011 Bowdoin College. All rights reserved.
//

#import "MapViewController.h"

@implementation MapViewController

@synthesize userTrackingMode = _userTrackingMode;

@synthesize mapView = _mapView;
@synthesize activityIndicator = _activityIndicator;
@synthesize userTrackingButton = _userTrackingButton;

- (id)init
{
    self = [super init];
    if (self)
    {
        /* init ivars here */
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        /* init ivars here */
    }
    return self;
}
 
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        /* init ivars here */
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];

    [self moveMapToPredefinedRegion];
    self.userTrackingMode = MKUserTrackingModeNone;
    [self.mapView setUserTrackingMode:MKUserTrackingModeNone animated:YES];
    
    self.userTrackingButton.target = self;
    self.userTrackingButton.action = @selector(changeUserTrackingMode);
}

- (void)viewDidUnload
{
    [self setMapView:nil];
    [self setActivityIndicator:nil];
    [self setUserTrackingButton:nil];
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation == UIInterfaceOrientationPortrait);
    } else {
        return YES;
    }
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self.view setNeedsLayout];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showInfo"])
    {
        //Setup anything for the information view controller
        //(i.e. which building, etc.)
    }
}

#pragma mark - MKMapViewDelegate Protocol

- (void)mapView:(MKMapView *)mapView didChangeUserTrackingMode:(MKUserTrackingMode)mode animated:(BOOL)animated
{
    NSLog(@"changed user tracking mode");
    if ([mapView isEqual:self.mapView])
    {
        //Do something here?
    }
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    NSLog(@"updated Location");
    if ([mapView isEqual:self.mapView])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Welcome!" message:@"This is Bowdoin College" delegate:self cancelButtonTitle:@"Done" otherButtonTitles:@"Yes", @"No", nil];
        [alert show];
        //find out if we left our region or entered another one? mutually exclusive?
    }
}

- (void)mapViewWillStartLoadingMap:(MKMapView *)mapView
{
    NSLog(@"start loading map");
    if ([mapView isEqual:self.mapView])
    {
        [self.activityIndicator startAnimating];
    }
}

- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView
{
    NSLog(@"finished loading map");
    if ([mapView isEqual:self.mapView])
    {
        [self.activityIndicator stopAnimating];
    }
}

- (void)mapViewDidFailLoadingMap:(MKMapView *)mapView withError:(NSError *)error
{
    if ([mapView isEqual:self.mapView])
    {
        [self.activityIndicator stopAnimating];
        // TODO: put some sort of "Failed to contact the server. Ensure data is enabled."
    }
}

#pragma mark - Utility Functions

- (void)moveMapToPredefinedRegion
{
    NSLog(@"moving");
    // TODO: make more regions, allow user to zoom/pan between these regions.
    // TODO: do we want to restrict to regions at all?
    MKCoordinateRegion region = MKCoordinateRegionMake(CENTRAL_MAP_CENTER, CENTRAL_MAP_SPAN);
    [self.mapView setRegion:region animated:YES];
}

-(void)changeUserTrackingMode
{
    switch (self.userTrackingMode) {
        case MKUserTrackingModeNone:
            self.userTrackingMode = MKUserTrackingModeFollow;
            self.userTrackingButton.style = UIBarButtonItemStyleDone;
            [self.mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
            break;
        case MKUserTrackingModeFollow:
            /* TODO heading not work on sim?
            self.userTrackingMode = MKUserTrackingModeFollowWithHeading;
            self.userTrackingButton.image = [UIImage imageNamed:@"Heading.png"];
            [self.mapView setUserTrackingMode:MKUserTrackingModeFollowWithHeading animated:YES];
            break;
        case MKUserTrackingModeFollowWithHeading:
             */
            self.userTrackingMode = MKUserTrackingModeNone;
            self.userTrackingButton.style = UIBarButtonItemStyleBordered;
            self.userTrackingButton.image = [UIImage imageNamed:@"Follow.png"];
            [self.mapView setUserTrackingMode:MKUserTrackingModeNone animated:YES];
            [self moveMapToPredefinedRegion];
            break;
        default:
            break;
    }
}

@end
