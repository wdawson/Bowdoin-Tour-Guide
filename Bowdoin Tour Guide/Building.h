//
//  Building.h
//  Bowdoin Tour Guide
//
//  Created by admin on 11/21/11.
//  Copyright (c) 2011 Bowdoin College. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Building : NSObject <MKAnnotation, NSObject>

@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, readonly, copy) NSString *subtitle;
@property (nonatomic, readonly)       CLLocationCoordinate2D coordinate;

- (id) initWithTitle:(NSString *)title
         AndSubtitle:(NSString *)subtitle
       AndCoordinate:(CLLocationCoordinate2D)coordinate;

/*  NSObject Protocol  */
- (BOOL)isEqual:(id)object;
- (NSUInteger)hash;
- (NSString *)description;

@end
