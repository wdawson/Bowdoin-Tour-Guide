//
//  Building.h
//  Bowdoin Tour Guide
//
//  Created by Enrique Naudon on 11/21/11.
//  Copyright (c) 2011 Bowdoin College. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

#define THUMBNAIL_NAME @"bowdoin-building.jpg"

@interface Building : NSObject <MKAnnotation, NSObject>

@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, readonly, copy) NSString *subtitle;
@property (nonatomic, readonly)       CLLocationCoordinate2D coordinate;

@property (nonatomic, readonly, copy) NSString *mediaDir;
@property (nonatomic, readonly, weak) UIImage *thumbnail;

- (id) initWithTitle:(NSString *)title
         AndSubtitle:(NSString *)subtitle
       AndCoordinate:(CLLocationCoordinate2D)coordinate
         AndMediaDir:(NSString *)mediaDir;

/*  NSObject Protocol  */
- (BOOL)isEqual:(id)object;
- (NSUInteger)hash;
- (NSString *)description;

@end
