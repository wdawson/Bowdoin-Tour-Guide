//
//  WebViewController.h
//  Bowdoin Tour Guide
//
//  Created by William Dawson on 12/13/11.
//  Copyright (c) 2011 Bowdoin College. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIToolbar *bar;
@property (weak, nonatomic) NSURLRequest       *request;

- (IBAction)backPressed:(id)sender;
- (IBAction)forwardPressed:(id)sender;
- (IBAction)toggleRefresh:(id)sender;

@end
