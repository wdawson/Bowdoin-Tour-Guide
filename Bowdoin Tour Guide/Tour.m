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
@synthesize possibleStops = _possibleStops;
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
        if ([line hasPrefix:COMMENT])
        {
            // it's a comment.
            continue;
        }
        
        NSArray *components = [line componentsSeparatedByString:SEPARATOR];
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
        _possibleStops = [Tour makeTourStopsWithFile:FILE_NAME];
        _stops = nil;
        _campus = [[Campus alloc] init];
        _campus.buildings = [Campus makeDictionaryWithBuildings:_possibleStops];
        _thisStop = nil;
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

#pragma mark - UITableViewDataSource Protocol

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
     
     static NSString *CellIdentifier = @"Cell";
     
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
     if (cell == nil) {
     cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
     }
     
     // Configure the cell...
     
     return cell;
    */
    Building *building = [self.possibleStops objectAtIndex:indexPath.row];
    
    UITableViewCell *result = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                                     reuseIdentifier:@"buildingCell"];
    UILabel *title = result.textLabel;
    title.text = building.title;
    UILabel *subtitle = result.detailTextLabel;
    subtitle.text = building.subtitle;
    
    result.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return result;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // TODO: return number of buildings in each section
    return self.possibleStops.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // TODO: return number of sections specified in text file
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    // TODO: return the title for each section in text file
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    // no footer
    return nil;
}

@end
