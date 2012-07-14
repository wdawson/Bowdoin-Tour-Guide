//
//  SetupViewController.m
//  Bowdoin Tour Guide
//
//  Created by William Dawson on 1/10/12.
//  Copyright (c) 2012 Bowdoin College. All rights reserved.
//

#import "SetupViewController.h"


@implementation SetupViewController

@synthesize tour = _tour;
@synthesize creator = _creator;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UINavigationController *nvc = [segue destinationViewController];
    TourPickerViewController *tpvc = (TourPickerViewController *)[nvc visibleViewController];
    tpvc.tour = self.tour;
    tpvc.creator = self.creator;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    if (indexPath.section == 1)
    {
        if (indexPath.row == 1)
        {
            // Help selected
            NSLog(@"Help Me!");
        }
        else {
            // Offline selected
            NSLog(@"Offline!");
        }
    }
    else if (indexPath.row == 2)
    {
        // Customize selected
        [self performSegueWithIdentifier:@"customizeTour" sender:self];
    }
    else if (indexPath.row == 1)
    {
        // Explore selected
        self.tour.stops = self.tour.possibleStops;
        self.tour.thisStop = nil;
        [self.creator dismissModalViewControllerAnimated:YES];
    }
    else
    {
        // Official selected
        self.tour.stops = self.tour.possibleStops;
        self.tour.thisStop = [self.tour.stops objectAtIndex:0];
        [self.creator dismissModalViewControllerAnimated:YES];
    }
}

@end
