//
//  Tour.h
//  Bowdoin Tour Guide
//
//  Created by William Dawson on 11/28/11.
//  Copyright (c) 2011 Bowdoin College. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Campus.h"
#import "Building.h"
#import "WebConstants.h"

@interface Tour : NSObject <UITableViewDataSource>

@property (nonatomic, strong) Campus   *campus;
@property (nonatomic, strong) NSArray  *stops;
@property (readonly , strong) NSArray  *possibleStops;
@property (nonatomic, strong) Building *thisStop;

+ (NSArray *) makeTourStopsWithFile:(NSString *)file;

- (BOOL)canGoNext;
- (BOOL)canGoBack;
- (void)next;
- (void)back;

@end
