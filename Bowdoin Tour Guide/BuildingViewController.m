//
//  BuildingViewController.m
//  Bowdoin Tour Guide
//
//  Created by William Dawson on 12/5/11.
//  Copyright (c) 2011 Bowdoin College. All rights reserved.
//

#import "BuildingViewController.h"

@implementation BuildingViewController

@synthesize imgView = _imgView;
@synthesize webView = _webView;
@synthesize building = _building;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupWebView:self.webView];
}

-(void) viewWillAppear:(BOOL)animated
{
    self.imgView.image = self.building.thumbnail;
    self.title = self.building.title;
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

#pragma mark - WebView Delegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType
{
    if (navigationType == UIWebViewNavigationTypeLinkClicked)
    {
        // TODO open new controller
        return NO;
    }
    return YES;
}

#pragma mark - View Setup

- (void)setupWebView:(UIWebView *)webView
{
    // get webpage into a string
    NSString *urlStr = [NSString stringWithFormat:@"%@%@%@%@", BASE_URL, TOUR_URL, self.building.dir, WEB_PAGE_SUFFIX];
    NSURL *url = [[NSURL alloc] initWithString:urlStr];
    NSString *webPage = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];

    // trim webpage
    NSRange startRange = [webPage rangeOfString:NOTE_START options:NSLiteralSearch];
    webPage = [webPage substringFromIndex:startRange.location + startRange.length];
    NSRange endRange = [webPage rangeOfString:TEXT_END options:NSLiteralSearch];
    if (!endRange.length) {
        endRange = [webPage rangeOfString:TEXT_END_ALT options:NSLiteralSearch];
    }
    webPage = [webPage substringToIndex:endRange.location];
    
    // remove intermediate stuff
    webPage = [webPage stringByReplacingOccurrencesOfString:BR_FLAG withString:BR_REPLACE];
    webPage = [webPage stringByReplacingOccurrencesOfString:HR_FLAG withString:@""];
    webPage = [webPage stringByReplacingOccurrencesOfString:DIV_FLAG withString:@""];
    
    // remove images
    NSRange imageRange = [webPage rangeOfString:IMAGE_START options:NSLiteralSearch];
    while (imageRange.length)
    {
        // temporarily extend range to include the rest of the page.
        imageRange.length = webPage.length - imageRange.location;
        NSRange r1 = [webPage rangeOfString:@">" options:NSLiteralSearch range:imageRange];
        // set correct range for image.
        imageRange.length = (r1.location + r1.length) - imageRange.location;
        // remove html image code
        webPage = [webPage stringByReplacingCharactersInRange:imageRange withString:@""];
        // get next occurance
        imageRange = [webPage rangeOfString:IMAGE_START options:NSLiteralSearch];
    }
    
    // remove illegal links
    NSRange linkRange = [webPage rangeOfString:ILLEGAL_LINK options:NSLiteralSearch];
    while (linkRange.length)
    {
        // temporarily extend range to include the rest of the page.
        linkRange.length = webPage.length - linkRange.location;
        NSRange r1 = [webPage rangeOfString:@">" options:NSLiteralSearch range:linkRange];
        // find range of link end.
        NSRange r2 = [webPage rangeOfString:END_LINK options:NSLiteralSearch range:linkRange];
        // set correct range for link.
        linkRange.length = (r1.location + r1.length) - linkRange.location;
        // remove html link code, important to remove end before beginning
        webPage = [webPage stringByReplacingCharactersInRange:r2 withString:@""];
        webPage = [webPage stringByReplacingCharactersInRange:linkRange withString:@""];
        // get next occurance
        linkRange = [webPage rangeOfString:ILLEGAL_LINK options:NSLiteralSearch];
    }
    
    // add prefix and suffix
    NSString *myPage = [[NSString alloc] initWithFormat:@"%@%@%@", MY_PREFIX, webPage, MY_SUFFIX];
    
    [webView loadHTMLString:myPage baseURL:[NSURL URLWithString:BASE_URL]];
}

@end
