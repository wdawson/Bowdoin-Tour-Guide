//
//  Building.m
//  Bowdoin Tour Guide
//
//  Created by Enrique Naudon on 11/21/11.
//  Copyright (c) 2011 Bowdoin College. All rights reserved.
//

#import "Building.h"

@implementation Building

@synthesize title = _title;
@synthesize subtitle = _subtitle;
@synthesize coordinate = _coordinate;

- (id) init
{
    [NSException raise:@"Wrong building initializer"
                format:@"Use initWithTitle:AndSubtitle:AndCoordinate:"];
    return nil;
}

- (id) initWithTitle:(NSString *)title
         AndSubtitle:(NSString *)subtitle
       AndCoordinate:(CLLocationCoordinate2D)coordinate
{
    if ([super init])
    {
        _title = [title copy];
        _subtitle = [subtitle copy];
        _coordinate = coordinate;
    }
    return self;
}

#pragma mark - NSObject Protocol

- (BOOL)isEqual:(id)object
{
    return ([object isKindOfClass:[Building class]] &&
            [object respondsToSelector:@selector(title)] &&
            [[object title] isEqual:self.title]);
}

- (NSUInteger)hash
{
    return [self.title hash];
}

- (NSString *)description
{
  //this is ugly, but \t (tab) isn't getting handled properly.  also, we don't
  //want to use multiple lines if we can avoid it.
  return [NSString stringWithFormat:@"%@_%@_(%g, %g)",
          self.title, self.subtitle,
          self.coordinate.latitude, self.coordinate.longitude];
}

@end
