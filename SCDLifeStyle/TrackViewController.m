//
//  TrackViewController.m
//  SCDLifeStyle
//
//  Created by Juan Fluxa on 5/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TrackViewController.h"
#import "Util.h"
#import "Day.h"
#import "AddDayViewController.h"

@interface TrackViewController () <TKCalendarMonthViewDelegate,TKCalendarMonthViewDataSource>

@property(nonatomic,strong) NSMutableArray *dataArray;
@property(nonatomic,strong) NSMutableArray *dataDict;

@end

@implementation TrackViewController

@synthesize dataArray,dataDict;

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor blackColor]];
    self.monthView.frame = CGRectMake(0, 0, self.monthView.frame.size.width, self.monthView.frame.size.height);
}

- (void) viewDidAppear:(BOOL)animated
{
    if (animated) {
        [self.monthView reload];
    }
    [super viewDidAppear:animated];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"AddDay"]) 
    {
        AddDayViewController *advc = [segue destinationViewController];
        advc.selectedDate = (NSDate*)sender;
    }
}

#pragma mark TKCalendar delegate
- (NSArray*) calendarMonthView:(TKCalendarMonthView*)monthView marksFromDate:(NSDate*)startDate toDate:(NSDate*)lastDate
{
    self.dataArray = [NSMutableArray array];
    self.dataDict = [NSMutableArray array];
    NSDate *d = startDate;
	while(YES)
    {
		Day *day = [[Util instance] getDayFromDate:d];
        
        if (day != nil) 
        {
            [self.dataArray addObject:[NSNumber numberWithBool:YES]];

        }
        else 
        {
            [self.dataArray addObject:[NSNumber numberWithBool:NO]];
        }
        
        		
		TKDateInformation info = [d dateInformationWithTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
		info.day++;
		d = [NSDate dateFromDateInformation:info timeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
		if([d compare:lastDate]==NSOrderedDescending) break;
	}
    
    return dataArray;
}

- (void) calendarMonthView:(TKCalendarMonthView*)monthView didSelectDate:(NSDate*)date
{
    [self performSegueWithIdentifier:@"AddDay" sender:date];
}

@end
