//
//  TourPickerViewController.m
//  Bowdoin Tour Guide
//
//  Created by William Dawson on 1/11/12.
//  Copyright (c) 2012 Bowdoin College. All rights reserved.
//

#import "TourPickerViewController.h"


@implementation TourPickerViewController

@synthesize tour = _tour;
@synthesize selectedStops = _selectedStops;
@synthesize doneButton = _doneButton;
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
    
    self.selectedStops = [[NSMutableSet alloc] init];

    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
}

- (void)viewDidUnload
{
    [self setDoneButton:nil];
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.doneButton = nil;
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

#pragma mark - Table view data source
/* Pass control off to tour model */

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.tour numberOfSectionsInTableView:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tour tableView:tableView numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *result = [self.tour tableView:tableView cellForRowAtIndexPath:indexPath];

    if ([self.selectedStops containsObject:[self.tour.campus.buildings objectForKey:result.textLabel.text]])
    {
        result.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    return result;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return NO;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    // add building to selected ones
    
    [self.selectedStops addObject:[self.tour.campus.buildings objectForKey:cell.textLabel.text]];
    
    self.doneButton.enabled = YES;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    // remove building from selected ones
    [self.selectedStops removeObject:[self.tour.campus.buildings objectForKey:cell.textLabel.text]];
    
    if (self.selectedStops.count == 0)
    {
        self.doneButton.enabled = NO;
    }
}

- (IBAction)cancelPressed:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)donePressed:(id)sender
{
    // Update the tour's stops
    NSMutableArray *newStops = [[NSMutableArray alloc] initWithArray:self.tour.possibleStops];
    // ensure that admissions is always the last stop
    [self.selectedStops addObject:self.tour.possibleStops.lastObject];
    // preserve tour order
    for (Building *b in self.tour.possibleStops)
    {
        if (![self.selectedStops containsObject:b])
        {
            [newStops removeObject:b];
        }
    }
    self.tour.stops = newStops;
    self.tour.thisStop = [newStops objectAtIndex:0];
    
    [self.creator dismissModalViewControllerAnimated:YES];
}
@end
