//
//  Tour.m
//  Bowdoin Tour Guide
//
//  Created by William Dawson on 11/28/11.
//  Copyright (c) 2011 Bowdoin College. All rights reserved.
//

#import "Tour.h"

@implementation Tour

@synthesize campus = _campus;
@synthesize nextStop = _nextStop;

- (id)init
{
    if (self = [super init])
    {
        _campus = [[Campus alloc] init];
        _nextStop = nil;
    }
    return self;
}

@end
