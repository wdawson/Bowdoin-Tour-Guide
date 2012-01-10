//
//  Campus.m
//  Bowdoin Tour Guide
//
//  Created by Enrique Naudon on 11/21/11.
//  Copyright (c) 2011 Bowdoin College. All rights reserved.
//

#import "Campus.h"

@implementation Campus

@synthesize buildings = _buildings;
@synthesize region = _region;
@synthesize regionID = _regionType;

+ (NSDictionary *) makeDictionaryWithBuildings:(NSArray *)buildings
{
    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
    
    for (Building *building in buildings)
    {
        [result setValue:building forKey:building.title];
    }
    
    return result;
}

- (id) init
{
    if ([super init])
    {
        _region = CAMPUS_MAP_REGION;
        _regionType = CAMPUS;
    }
    return self;
}

@end
