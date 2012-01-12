//
//  TourPickerViewController.h
//  Bowdoin Tour Guide
//
//  Created by William Dawson on 1/11/12.
//  Copyright (c) 2012 Bowdoin College. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tour.h"
#import "SetupViewController.h"

@interface TourPickerViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) Tour *tour;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (strong, nonatomic) NSMutableSet *selectedStops;
@property (strong, nonatomic) UIViewController *creator;

- (IBAction)cancelPressed:(id)sender;
- (IBAction)donePressed:(id)sender;

@end
