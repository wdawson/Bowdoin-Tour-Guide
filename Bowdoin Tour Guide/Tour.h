//
//  Tour.h
//  Bowdoin Tour Guide
//
//  Created by William Dawson on 11/28/11.
//  Copyright (c) 2011 Bowdoin College. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Campus.h"

@interface Tour : NSObject

@property (nonatomic, strong) Campus   *campus;
@property (nonatomic, weak  ) CLRegion *nextStop;

@end
