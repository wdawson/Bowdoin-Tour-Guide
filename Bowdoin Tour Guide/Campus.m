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

+ (NSDictionary *) buildDictionaryWithFile:(NSString *)file
{
    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
    
    // get the path to our file.
    NSString *filePath = [[NSBundle mainBundle] pathForResource:file ofType:@"txt"];
    
    // get the contents of the file.
    NSString *fileContents = [NSString stringWithContentsOfFile:filePath
                                                       encoding:NSUTF8StringEncoding
                                                          error:nil];
    // put all the lines into an array.
    NSArray *allLines = [fileContents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    
    // for each line, make a building.
    // NOTE: important that file is of this format. Subject to change.
    for (NSString *line in allLines)
    {
        NSArray *components = [line componentsSeparatedByString:@"_"];
        if ([components count] == 4 || [components count] == 5 )
        {
          //determine media directory
          //of course we must use my favorite operator to obfuscate our code as
          //much as possible :-)
          NSString *mediaDir =
            [NSString stringWithFormat:@"%@/%@",
              [[NSBundle mainBundle] bundlePath],
              ([components count] > 4) ? [components objectAtIndex:4] : @""];
          
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
                                    AndMediaDir:mediaDir];
            [result setValue:building forKey:building.title];
        }
    }
    return result;
}

#define fileName @"BowdoinBuildings"

- (id) init
{
    if ([super init])
    {
        _region = CAMPUS_MAP_REGION;
        _regionType = CAMPUS;
        _buildings = [Campus buildDictionaryWithFile:fileName];
    }
    return self;
}

@end
