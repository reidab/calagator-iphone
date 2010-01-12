//
//  RootViewController.m
//  Calagator
//
//  Created by Audrey Eschright on 12/3/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "EventsViewController.h"
#import "EventViewController.h"
#import "Event.h"

@implementation EventsViewController

@synthesize eventList;

- (void)dealloc {
    [eventList release];
	[super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.title = @"Events on Calagator";
//	self.view.backgroundColor = [UIColor colorWithRed:0.510f green:0.788f blue:0.340f alpha:1.00f];	
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release anything that can be recreated in viewDidLoad or on demand.
	// e.g. self.myOutlet = nil;
}

- (void) updateEventList {
	eventsSeparatedByDay = [[NSMutableArray alloc] init];
	int index = 0;
	for (Event *event in eventList) {
		if (index == 0 || ![event occursOnTheSameDayAs:[eventList objectAtIndex:index-1]]) {
			[eventsSeparatedByDay addObject:[[NSMutableArray alloc] init]];
		}
		[[eventsSeparatedByDay lastObject] addObject:event];
		index++;
	}

	[self.tableView reloadData];
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [eventsSeparatedByDay count];
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[eventsSeparatedByDay objectAtIndex:section] count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {

	// Should probably find a way to use a class-level date formatter
	// instead of just creating one every time we need it.
	NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
	[formatter setDateFormat:@"EEEE, MMMM d"];

	return [formatter stringFromDate:[[[eventsSeparatedByDay objectAtIndex:section] objectAtIndex:0] date]];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
	// Configure the cell.
	//Event *event = [eventList objectAtIndex:indexPath.row];
	Event *event = [[eventsSeparatedByDay objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
	cell.textLabel.text = event.title;
    return cell;
}

// Override to support row selection in the table view.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    // Navigation logic may go here -- for example, create and push another view controller.
	EventViewController *eventViewController = [[EventViewController alloc] initWithNibName:@"EventViewController" bundle:nil];
	eventViewController.event = [[eventsSeparatedByDay objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
	[self.navigationController pushViewController:eventViewController animated:YES];
	[eventViewController release];
}

@end

