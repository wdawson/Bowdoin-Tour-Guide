//
//  BuildingViewController.h
//  Bowdoin Tour Guide
//
//  Created by William Dawson on 12/5/11.
//  Copyright (c) 2011 Bowdoin College. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Building.h"
#import "WebConstants.h"
#import "WebViewController.h"

@interface BuildingViewController : UIViewController <UIWebViewDelegate>

@property (weak  , nonatomic) IBOutlet UIImageView *imgView;
@property (weak  , nonatomic) IBOutlet UIWebView   *webView;
@property (weak  , nonatomic) Building             *building;

/* WebView Delegate */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType;

- (void)setupWebView:(UIWebView *) webView;

- (void) changePhoto:(UISwipeGestureRecognizer *) sender;
- (void) changeSlideshowState:(UITapGestureRecognizer *) sender;

@end
