//
//  Events.m
//  Calagator
//
//  Created by Audrey Eschright on 12/3/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Event.h"

@implementation Event

@synthesize title;
@synthesize description;
@synthesize link;
@synthesize date;
@synthesize venueTitle;
@synthesize venueAddress;
@synthesize latitude;
@synthesize longitude;

- (NSString *) cleanDescription {
	NSScanner *scanner = [NSScanner scannerWithString:self.description];
	NSString *tag = @"";
	NSString *cleaned = self.description;

	while ([scanner isAtEnd] == NO) {
		[scanner scanUpToString:@"<" intoString:NULL];
		[scanner scanUpToString:@">" intoString:&tag];
		cleaned = [cleaned stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", tag] withString:@""];
	}
	return cleaned;
}

-(void) dealloc {
	[title release];
	[description release];
	[link release];
	[venueTitle release];
	[venueAddress release];
	[super dealloc];
}

-(BOOL) occursOnTheSameDayAs:(Event*) otherEvent {
	NSCalendar* calendar = [NSCalendar currentCalendar];

	unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
	NSDateComponents* comp1 = [calendar components:unitFlags fromDate:self.date];
	NSDateComponents* comp2 = [calendar components:unitFlags fromDate:otherEvent.date];

	return	[comp1 day]   == [comp2 day] &&
			[comp1 month] == [comp2 month] &&
			[comp1 year]  == [comp2 year];
}
	

@end
