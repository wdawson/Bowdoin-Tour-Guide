//
//  SetupViewController.h
//  Bowdoin Tour Guide
//
//  Created by William Dawson on 1/10/12.
//  Copyright (c) 2012 Bowdoin College. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tour.h"
#import "TourPickerViewController.h"

@interface SetupViewController : UITableViewController <UITableViewDelegate>

@property (strong, nonatomic) Tour *tour;
@property (strong, nonatomic) UIViewController *creator;

@end
