//
//  RootViewController.h
//  Calagator
//
//  Created by Audrey Eschright on 12/3/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

@interface EventsViewController : UITableViewController {
	NSArray *eventList;
	NSMutableArray *eventsSeparatedByDay;
}

@property (nonatomic, retain) NSArray *eventList;

- (void) updateEventList;

@end
