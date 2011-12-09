//
//  BuildingViewController.h
//  Bowdoin Tour Guide
//
//  Created by William Dawson on 12/5/11.
//  Copyright (c) 2011 Bowdoin College. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Building.h"

@interface BuildingViewController : UIViewController

@property (weak  , nonatomic) IBOutlet UIImageView *imgView;
@property (weak  , nonatomic) IBOutlet UITextView  *txtView;
@property (weak  , nonatomic) Building             *building;

@end
