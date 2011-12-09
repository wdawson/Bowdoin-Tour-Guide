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
         
- (void)initIVars
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
    [self moveMapToDefinedRegion];
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

    // add gesture recognizers
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    tap.numberOfTapsRequired = 2;
    [self.mapView addGestureRecognizer:tap];
    
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
    [self.mapView addGestureRecognizer:pinch];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.mapView addGestureRecognizer:pan];
    
    // add annotations
    NSArray *buildings = [self.tour.campus.buildings allValues];
    [self.mapView addAnnotations:buildings];
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
        Building *building = (Building *)((MKAnnotationView *)sender).annotation;
        bvc.title = building.title;
    }
}

#pragma mark - MKMapViewDelegate Protocol

- (void) mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)annotation
                       calloutAccessoryControlTapped:(UIControl *)control
{
    [self performSegueWithIdentifier:BUILDING_SEGUE_ID
                              sender:annotation];
}

/*
 */
- (MKAnnotationView *)mapView:(MKMapView *)mapView
            viewForAnnotation:(id <MKAnnotation>)annotation
{
    //get ourselves an annotation view
    //us MKAnnotationView instead to use a custom annotation
    
    if ([annotation isMemberOfClass:[MKUserLocation class]])
    {
        return nil;
    }
    else
    {
        MKAnnotationView *aView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation
                                            reuseIdentifier:REUSE_ID];
  
        //create media button and thumbnail
        aView.rightCalloutAccessoryView =
            [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        aView.leftCalloutAccessoryView =
            [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        aView.canShowCallout = YES;
  
        aView.annotation = annotation;
        return aView;
    }
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    if (![view.annotation isMemberOfClass:[MKUserLocation class]])
    {
        Building *building = (Building *)view.annotation;
        UIImageView *imageView = (UIImageView *)view.leftCalloutAccessoryView;
        
        if (building && imageView)
        {
            UIImage *thumbnail = building.thumbnail;
            if (thumbnail)
            {
                imageView.image = thumbnail;
            }
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

#pragma mark - Gesture Recognizers

- (void)handleTap:(UITapGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        //find coord from point tapped, zoom in if possible.
    }
}

- (void)handlePinch:(UIPinchGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateRecognized)
    {
        if (sender.scale > 1.25)
        {
            // zoom in if able
            if (self.tour.campus.regionID == CAMPUS)
            {
                if ([self coordinate:self.mapView.userLocation.coordinate inRegion:CENTRAL_MAP_REGION])
                {
                    [self moveMapToRegion:CENTRAL_MAP_REGION withID:CENTRAL];
                }
                else if ([self coordinate:self.mapView.userLocation.coordinate inRegion:FIELDS_MAP_REGION])
                {
                    [self moveMapToRegion:FIELDS_MAP_REGION withID:FIELDS];
                }
            }
            else if (self.tour.campus.regionID == CENTRAL)
            {
                if ([self coordinate:self.mapView.userLocation.coordinate inRegion:QUAD_MAP_REGION])
                {
                    [self moveMapToRegion:QUAD_MAP_REGION withID:QUAD];
                }
                else if ([self coordinate:self.mapView.userLocation.coordinate inRegion:EAST_MAP_REGION])
                {
                    [self moveMapToRegion:EAST_MAP_REGION withID:EAST];
                }
                else if ([self coordinate:self.mapView.userLocation.coordinate inRegion:SOUTH_MAP_REGION])
                {
                    [self moveMapToRegion:SOUTH_MAP_REGION withID:SOUTH];
                }
            }
        }
        else if (sender.scale < .75)
        {
            // zoom out
            if (self.tour.campus.regionID == CAMPUS)
            {
                // can't zoom out
            }
            else if (self.tour.campus.regionID == FIELDS)
            {
                [self moveMapToRegion:FIELDS_MAP_REGION withID:FIELDS];
            }
            else if (self.tour.campus.regionID == CENTRAL)
            {
                [self moveMapToRegion:CAMPUS_MAP_REGION withID:CAMPUS];
            }
            else
            {
                [self moveMapToRegion:CENTRAL_MAP_REGION withID:CENTRAL];
            }
        }
    }
}

- (void)handlePan:(UIPanGestureRecognizer *)sender
{
    
}

#pragma mark - Utility Functions

- (void)moveMapToRegion:(MKCoordinateRegion)region withID:(int)identifier
{
    self.tour.campus.region = region;
    self.tour.campus.regionID = identifier;
    [self moveMapToDefinedRegion];
    
    // set user tracking button back
    self.userTrackingMode = MKUserTrackingModeNone;
    self.userTrackingButton.style = UIBarButtonItemStyleBordered;
    self.userTrackingButton.image = [UIImage imageNamed:NO_TRACKING_IMAGE_NAME];
}

- (void)moveMapToDefinedRegion
{
    [self.mapView setRegion:self.tour.campus.region animated:YES];
}

- (BOOL)coordinate:(CLLocationCoordinate2D) coord inRegion:(MKCoordinateRegion) region
{
    CLLocationCoordinate2D tl = CLLocationCoordinate2DMake(region.center.latitude  + region.span.latitudeDelta *0.5,
                                                           region.center.longitude - region.span.longitudeDelta*0.5);
    CLLocationCoordinate2D br = CLLocationCoordinate2DMake(region.center.latitude  - region.span.latitudeDelta *0.5,
                                                           region.center.longitude + region.span.longitudeDelta*0.5);
    return (coord.latitude  < tl.latitude  && coord.latitude  > br.latitude &&
            coord.longitude > tl.longitude && coord.longitude < br.longitude);
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
            [self moveMapToDefinedRegion];
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
