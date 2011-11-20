//
//  MapViewController.h
//  Bowdoin Tour Guide
//
//  Created by William Dawson on 11/15/11.
//  Copyright (c) 2011 Bowdoin College. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MapConstants.h"

@interface MapViewController : UIViewController <MKMapViewDelegate>

@property (nonatomic) MKUserTrackingMode userTrackingMode; // variable holding user tracking mode.

@property (weak  , nonatomic) IBOutlet MKMapView *mapView; // the map view. Handles itself mostly :)
@property (weak  , nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator; // activity indicator for map loading
@property (weak  , nonatomic) IBOutlet UIBarButtonItem *userTrackingButton; // button to change user tracking modes.
@property (strong, nonatomic) IBOutlet UISegmentedControl *mapTypeControl; // changes map type. Not outleted to IB now.

/*  MKMapViewDelegate  */
- (void)mapView:(MKMapView *)mapView didChangeUserTrackingMode:(MKUserTrackingMode)mode animated:(BOOL)animated;
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation;
- (void)mapViewWillStartLoadingMap:(MKMapView *)mapView;
- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView;
- (void)mapViewDidFailLoadingMap:(MKMapView *)mapView withError:(NSError *)error;

/*  Utility Functions  */
- (void)moveMapToPredefinedRegion;
- (void)changeUserTrackingMode;
- (void)changeMapType;

@end
