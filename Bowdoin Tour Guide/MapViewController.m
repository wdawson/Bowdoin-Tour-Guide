//
//  MapViewController.m
//  Bowdoin Tour Guide
//
//  Created by William Dawson on 11/15/11.
//  Copyright (c) 2011 Bowdoin College. All rights reserved.
//

#import "MapViewController.h"

@implementation MapViewController

@synthesize mapView = _mapView;
@synthesize activityIndicator = _activityIndicator;

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

    MKCoordinateRegion region = MKCoordinateRegionMake(CENTRAL_MAP_CENTER, CENTRAL_MAP_SPAN);
    [self.mapView setRegion:region animated:YES];
    [self.mapView setUserTrackingMode:MKUserTrackingModeNone animated:YES];
    
    [self.view addSubview:self.activityIndicator];
    [self.view addSubview:self.mapView];
}

- (void)viewDidUnload
{
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

//TODO is this running?

- (void)mapView:(MKMapView *)mapView didChangeUserTrackingMode:(MKUserTrackingMode)mode animated:(BOOL)animated
{
    NSLog(@"changed user tracking mode");
    if ([mapView isEqual:self.mapView])
    {
        [mapView setUserTrackingMode:MKUserTrackingModeNone animated:NO];
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

@end
