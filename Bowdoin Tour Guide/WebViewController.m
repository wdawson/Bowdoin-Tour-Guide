//
//  WebViewController.m
//  Bowdoin Tour Guide
//
//  Created by William Dawson on 12/13/11.
//  Copyright (c) 2011 Bowdoin College. All rights reserved.
//

#import "WebViewController.h"

@implementation WebViewController

@synthesize webView = _webView;
@synthesize request = _request;

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
    self.webView.delegate = self;
    
    NSMutableArray *items = [[NSMutableArray alloc] initWithArray:self.toolbarItems];
    UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                           target:self
                                                           action:@selector(toggleRefresh:)];
    [items insertObject:refreshButton atIndex:4];
    self.toolbarItems = items;
    
    [self.webView loadRequest:self.request];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.webView = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation == UIInterfaceOrientationPortrait);
    } else {
        return YES;
    }
}

# pragma mark - Web View Delegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    UIBarButtonItem *stopButton = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemStop
                                                        target:self
                                                        action:@selector(toggleRefresh:)];
    NSMutableArray *items = [[NSMutableArray alloc] initWithArray:self.toolbarItems];
    NSLog(@"%@", [items objectAtIndex:4]);
    [items replaceObjectAtIndex:4 withObject:stopButton];
    NSLog(@"%@", [items objectAtIndex:4]);
    [self setToolbarItems:items animated:NO];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh 
                                                           target:self
                                                           action:@selector(toggleRefresh:)];
    NSMutableArray *items = [[NSMutableArray alloc] initWithArray:self.toolbarItems];
    [items replaceObjectAtIndex:4 withObject:refreshButton];
    [self setToolbarItems:items animated:NO];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}

# pragma mark - Button Presses

- (IBAction)backPressed:(id)sender
{
    [self.webView goBack];
}

- (IBAction)forwardPressed:(id)sender
{
    [self.webView goForward];
}

- (IBAction)toggleRefresh:(id)sender
{
    if (self.webView.loading)
    {
        [self.webView stopLoading];
    }
    else
    {
        [self.webView reload];
    }
}
@end
