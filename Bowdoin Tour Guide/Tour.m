//
//  Tour.m
//  Bowdoin Tour Guide
//
//  Created by William Dawson on 11/28/11.
//  Copyright (c) 2011 Bowdoin College. All rights reserved.
//

#import "Tour.h"

@implementation Tour

@synthesize campus   = _campus;
@synthesize stops    = _stops;
@synthesize thisStop = _thisStop;

+ (NSArray *) makeTourStopsWithFile:(NSString *)file
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    // get the path to our file.
    NSString *filePath = [[NSBundle mainBundle] pathForResource:file ofType:@"txt"];
    
    // get the contents of the file.
    NSString *fileContents = [NSString stringWithContentsOfFile:filePath
                                                       encoding:NSUTF8StringEncoding
                                                          error:nil];
    // put all the lines into an array.
    NSArray *allLines = [fileContents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    
    // for each line, get the Building
    // NOTE: important that file is of this format. Subject to change.
    for (NSString *line in allLines)
    {
        NSArray *components = [line componentsSeparatedByString:@"_"];
        if ([components count] >= 4 )
        {
            //determine media directory
            NSString *buildingDir = nil;
            if ([components count] > 4)
            {
                buildingDir = [NSString stringWithFormat:@"/%@", [components objectAtIndex:4]];
            }
            
            //wrap latitude and longitude
            CLLocationCoordinate2D coord =
            CLLocationCoordinate2DMake([[components objectAtIndex:2]
                                        doubleValue],
                                       [[components objectAtIndex:3]
                                        doubleValue]);
            
            Building *building = [[Building alloc]
                                  initWithTitle:[components objectAtIndex:0]
                                  AndSubtitle:[components objectAtIndex:1]
                                  AndCoordinate:coord
                                  AndDir:buildingDir];
            [result addObject:building];
        }
    }
    return result;
}

#define FILE_NAME @"BowdoinBuildings"

- (id)init
{
    if (self = [super init])
    {
        _stops = [Tour makeTourStopsWithFile:FILE_NAME];
        _campus = [[Campus alloc] init];
        _campus.buildings = [Campus makeDictionaryWithBuildings:_stops];
        _thisStop = nil; //[_stops objectAtIndex:0]; // enable for guided tour
    }
    return self;
}


- (BOOL)canGoNext
{
    // are we on a guided tour?
    if (self.thisStop)
    {
        return ([self.stops indexOfObject:self.thisStop] != self.stops.count - 1);
    }
    return NO;
}

- (BOOL)canGoBack
{
    // are we on a guided tour?
    if (self.thisStop)
    {
        return ([self.stops indexOfObject:self.thisStop] != 0);
    }
    return NO;
}

- (void)next
{
    if ([self canGoNext])
    {
        NSUInteger index = [self.stops indexOfObject:self.thisStop] + 1;
        self.thisStop = [self.stops objectAtIndex:index];
    }
}

- (void)back
{
    if ([self canGoBack])
    {
        NSUInteger index = [self.stops indexOfObject:self.thisStop] - 1;
        self.thisStop = [self.stops objectAtIndex:index];
    }
}

@end
