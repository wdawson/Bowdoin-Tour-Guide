//
//  MapConstants.h
//  Bowdoin Tour Guide
//
//  Created by William Dawson on 11/15/11.
//  Copyright (c) 2011 Bowdoin College. All rights reserved.
//

#ifndef Bowdoin_Tour_Guide_MapConstants_h
#define Bowdoin_Tour_Guide_MapConstants_h

/* Map Regions */
// Whole Campus
#define CAMPUS_MAP_CENTER  CLLocationCoordinate2DMake(43.9060    , -69.9603    )
#define CAMPUS_MAP_SPAN          MKCoordinateSpanMake( 0.01204460,   0.01285970)
#define CAMPUS_MAP_REGION      MKCoordinateRegionMake(CAMPUS_MAP_CENTER, CAMPUS_MAP_SPAN)
// Main Campus without fields
#define CENTRAL_MAP_CENTER CLLocationCoordinate2DMake(43.9076    , -69.9622    )
#define CENTRAL_MAP_SPAN         MKCoordinateSpanMake( 0.00643110,   0.00686646)
#define CENTRAL_MAP_REGION     MKCoordinateRegionMake(CENTRAL_MAP_CENTER, CENTRAL_MAP_SPAN)
// Quad
#define QUAD_MAP_CENTER    CLLocationCoordinate2DMake(43.9086    , -69.9628    )
#define QUAD_MAP_SPAN            MKCoordinateSpanMake( 0.00318276,   0.00339827)
#define QUAD_MAP_REGION        MKCoordinateRegionMake(QUAD_MAP_CENTER, QUAD_MAP_SPAN)
// East Campus
#define EAST_MAP_CENTER    CLLocationCoordinate2DMake(43.9090    , -69.9604    )
#define EAST_MAP_SPAN            MKCoordinateSpanMake( 0.00286258,   0.00305643)
#define EAST_MAP_REGION        MKCoordinateRegionMake(EAST_MAP_CENTER, EAST_MAP_SPAN)
// South Campus
#define SOUTH_MAP_CENTER   CLLocationCoordinate2DMake(43.9062    , -69.9637    )
#define SOUTH_MAP_SPAN           MKCoordinateSpanMake( 0.00323551,   0.00345446)
#define SOUTH_MAP_REGION       MKCoordinateRegionMake(SOUTH_MAP_CENTER, SOUTH_MAP_SPAN)
// Fields
#define FIELDS_MAP_CENTER  CLLocationCoordinate2DMake(43.9025    , -69.9598    )
#define FIELDS_MAP_SPAN          MKCoordinateSpanMake( 0.00643165,   0.00686646)
#define FIELDS_MAP_REGION      MKCoordinateRegionMake(FIELDS_MAP_CENTER, FIELDS_MAP_SPAN)

enum MAP_REGION {
    CAMPUS = 0,
    CENTRAL = 1,
    QUAD = 2,
    EAST = 3,
    SOUTH = 4,
    FIELDS = 5
    };

/* User Tracking Image names */
#define NO_TRACKING_IMAGE_NAME      @"Follow.png"
#define HEADING_TRACKING_IMAGE_NAME @"Heading.png"

/* Map Type definitions */
enum MAP_TYPE {
    MAP_TYPE_MAP_INDEX       = 0,
    MAP_TYPE_SATELLITE_INDEX = 1,
    MAP_TYPE_HYBRID_INDEX    = 2
    };

#endif
