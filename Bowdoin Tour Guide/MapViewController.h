//
//  MapViewController.h
//  Bowdoin Tour Guide
//
//  Created by William Dawson on 11/15/11.
//  Copyright (c) 2011 Bowdoin College. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MapConstants.h"
#import "Tour.h"
#import "BuildingViewController.h"
#import "SetupViewController.h"

#define REUSE_ID @"pinAView"
#define BUILDING_SEGUE_ID @"showBuilding"

@interface MapViewController : UIViewController <MKMapViewDelegate, UITableViewDelegate>

@property (nonatomic) MKUserTrackingMode userTrackingMode; // variable holding user tracking mode.
@property (strong, nonatomic) Tour *tour;

@property (weak  , nonatomic) IBOutlet MKMapView *mapView; // the map view. Handles itself mostly :)
@property (weak  , nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator; // activity indicator for map loading
@property (weak  , nonatomic) IBOutlet UIBarButtonItem *userTrackingButton; // button to change user tracking modes.
@property (strong, nonatomic) IBOutlet UISegmentedControl *mapTypeControl; // changes map type. Not outleted to IB now.
@property (strong, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *nextButton;

/*  MKMapViewDelegate  */
- (void)mapView:(MKMapView *)mapView didChangeUserTrackingMode:(MKUserTrackingMode)mode animated:(BOOL)animated;
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation;
- (void)mapViewWillStartLoadingMap:(MKMapView *)mapView;
- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView;
- (void)mapViewDidFailLoadingMap:(MKMapView *)mapView withError:(NSError *)error;

/* Gesture Recognizers */
- (void)handleTap:(UITapGestureRecognizer *)sender;
- (void)handlePinch:(UIPinchGestureRecognizer *)sender;
- (void)handlePan:(UIPanGestureRecognizer *)sender;

/*   Tour Functions    */
- (void)moveTourBack;
- (void)moveTourNext;

/*  Utility Functions  */
- (void)moveMapToRegion:(MKCoordinateRegion) region withID:(int) identifier;
- (void)moveMapToDefinedRegion;
- (BOOL)coordinate:(CLLocationCoordinate2D) coord inRegion:(MKCoordinateRegion) region;
- (BOOL)point:(CGPoint)p inRect:(CGRect) rect;
- (void)changeUserTrackingMode;
- (void)changeMapType;
- (void)initIVars;

@end
