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
@synthesize tour = _tour;

@synthesize mapView = _mapView;
@synthesize activityIndicator = _activityIndicator;
@synthesize userTrackingButton = _userTrackingButton;
@synthesize mapTypeControl = _mapTypeControl;

- (id)init
{
    self = [super init];
    if (self)
    {
        [self initIVars];
    }
    return self;
}

// This is what's used I think...
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self initIVars];
    }
    return self;
}
 
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        [self initIVars];
    }
    return self;
}
         
- (void) initIVars
{
    _tour = [[Tour alloc] init];
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

    // setup map view
    [self moveMapToPredefinedRegion];
    self.userTrackingMode = MKUserTrackingModeNone;
    [self.mapView setUserTrackingMode:MKUserTrackingModeNone animated:YES];
    
    // setup tracking mode button
    self.userTrackingButton.target = self;
    self.userTrackingButton.action = @selector(changeUserTrackingMode);
    
    // setup segmented control programatically because we can't do it in IB
    NSArray *controlItems= [[NSArray alloc] initWithObjects:@"Map", @"Satellite", @"Hybrid", nil];
    _mapTypeControl = [[UISegmentedControl alloc] initWithItems:controlItems];
    [self.mapTypeControl addTarget:self action:@selector(changeMapType)forControlEvents:UIControlEventValueChanged];
    self.mapTypeControl.segmentedControlStyle = UISegmentedControlStyleBar;
    self.mapTypeControl.tintColor = [UIColor darkGrayColor];
    self.mapTypeControl.selectedSegmentIndex = 0;

    // add objects to toolbar
    UIBarButtonItem *flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                              target:nil action:nil];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:self.mapTypeControl];
    NSMutableArray *toolItems = [[NSMutableArray alloc] initWithArray:self.toolbarItems];
    [toolItems insertObject:flexible atIndex:1];
    [toolItems insertObject:item atIndex:2];
    [toolItems insertObject:flexible atIndex:3];   // trick to center segmented control
    self.toolbarItems = toolItems;
  
  //add annotations
  if (self.mapView.annotations) {
    id <MKAnnotation> building;
    NSEnumerator *buildingEnum = [self.tour.campus.buildings objectEnumerator];
    
    //add each building, one at a time
    while (building = [buildingEnum nextObject])
      [self.mapView addAnnotation:building];
    
    /*instead of adding each building with addAnnotation, we might also convert
     *the buildings dictionary to an array and use addAnotations, like this:
    
    NSArray *buildings = [self.tour.campus.buildings allValues];
    [self.mapView addAnnotations:buildings];
     
     */
  }
}

- (void)viewDidUnload
{
    [self setMapView:nil];
    [self setActivityIndicator:nil];
    [self setUserTrackingButton:nil];
    [self setMapTypeControl:nil];
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender
{
  if ([[segue identifier] isEqualToString:@"showBuilding"])
  {
    BuildingViewController *bvc = [segue destinationViewController];
    MKAnnotationView *annotView = (MKAnnotationView *)sender;
    Building *building = (Building *)annotView.annotation;
    bvc.title = building.title;it
  }
}

#pragma mark - MKMapViewDelegate Protocol

- (void) mapView:(MKMapView *)mapView
  annotationView:(MKAnnotationView *)annotation
  calloutAccessoryControlTapped:(UIControl *)control
{
  [self performSegueWithIdentifier:BUILDING_SEGUE
                            sender:annotation];
}

/*
 */
- (MKAnnotationView *)mapView:(MKMapView *)mapView
            viewForAnnotation:(id <MKAnnotation>)annotation
{
  //get ourselves an annotation view
  //us MKAnnotationView instead to use a custom annotation
  MKPinAnnotationView *pinAView =
    [[MKPinAnnotationView alloc] initWithAnnotation:annotation
                                    reuseIdentifier:REUSE_ID];
  
  //create media button and thumbnail
  pinAView.rightCalloutAccessoryView =
    [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
  pinAView.leftCalloutAccessoryView =
    [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
  pinAView.canShowCallout = YES;
  
  pinAView.annotation = annotation;

	return pinAView;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
  Building *building = (Building *)view.annotation;
  UIImageView *imageView = (UIImageView *)view.leftCalloutAccessoryView;
  
  if (building && imageView) {
    UIImage *thumbnail = building.thumbnail;
    if (thumbnail) {
      imageView.image = thumbnail;
    }
  }
}

- (void)mapView:(MKMapView *)mapView didChangeUserTrackingMode:(MKUserTrackingMode)mode animated:(BOOL)animated
{
    if ([mapView isEqual:self.mapView])
    {
        //Do something here?
    }
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    if ([mapView isEqual:self.mapView])
    {
        NSLog(@"%@", self.tour.campus.buildings);
        //UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Welcome!" message:@"This is Bowdoin College" delegate:self cancelButtonTitle:@"Done" otherButtonTitles:@"Yes", @"No", nil];
        //[alert show];
        //find out if we left our region or entered another one? mutually exclusive?
    }
}

- (void)mapViewWillStartLoadingMap:(MKMapView *)mapView
{
    if ([mapView isEqual:self.mapView])
    {
        [self.activityIndicator startAnimating];
    }
}

- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView
{
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
    // TODO: make more regions, allow user to zoom/pan between these regions.
    // TODO: do we want to restrict to regions at all?
    [self.mapView setRegion:self.tour.campus.region animated:YES];
}

- (void)changeUserTrackingMode
{
    // Switch on current tracking mode. For some reason the switch doesn't like
    // self.mapView.userTrackingMode so we use our own variable instead.
    switch (self.userTrackingMode)
    {
        case MKUserTrackingModeNone:
            self.userTrackingMode = MKUserTrackingModeFollow;
            self.userTrackingButton.style = UIBarButtonItemStyleDone;
            [self.mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
            break;
        case MKUserTrackingModeFollow:
            self.userTrackingMode = MKUserTrackingModeFollowWithHeading;
            self.userTrackingButton.image = [UIImage imageNamed:HEADING_TRACKING_IMAGE_NAME];
            [self.mapView setUserTrackingMode:MKUserTrackingModeFollowWithHeading animated:YES];
            break;
        case MKUserTrackingModeFollowWithHeading:
            self.userTrackingMode = MKUserTrackingModeNone;
            self.userTrackingButton.style = UIBarButtonItemStyleBordered;
            self.userTrackingButton.image = [UIImage imageNamed:NO_TRACKING_IMAGE_NAME];
            [self.mapView setUserTrackingMode:MKUserTrackingModeNone animated:YES];
            [self moveMapToPredefinedRegion];
            break;
        default:
            break;
    }
}
- (void)changeMapType
{
    switch(self.mapTypeControl.selectedSegmentIndex)
    {
        case MAP_TYPE_MAP_INDEX:
            //Map
            self.mapView.mapType = MKMapTypeStandard;
            break;
        case MAP_TYPE_SATELLITE_INDEX:
            //Satellite
            self.mapView.mapType = MKMapTypeSatellite;
            break;
        case MAP_TYPE_HYBRID_INDEX:
            //Hybrid
            self.mapView.mapType = MKMapTypeHybrid;
            break;
        default:
            break;
    }
}

@end
