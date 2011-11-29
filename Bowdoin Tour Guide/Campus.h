//
//  Campus.h
//  Bowdoin Tour Guide
//
//  Created by Enrique Naudon on 11/21/11.
//  Copyright (c) 2011 Bowdoin College. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "MapConstants.h"
#import "Building.h"

@interface Campus : NSObject
@property (nonatomic, strong) NSDictionary *buildings;
@property (readonly)          MKCoordinateRegion region;

+ (NSDictionary *) buildDictionaryWithFile:(NSString *)file;

@end
