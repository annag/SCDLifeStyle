//
//  GraphViewController.m
//  SCDLifeStyle
//
//  Created by Juan Fluxa on 5/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GraphViewController.h"
#import "UIColor+SCDColors.h"
#import "NSDate+SCDCategory.h"
#import "Util.h"
#import "Day.h"


#define SPAN_DAYS 10 //num days to show on graph at zoom level 1.0



@interface GraphViewController ()

@property(nonatomic,assign) float zoomLevel;

@end

@implementation GraphViewController

@synthesize graphView;
@synthesize zoomLevel;


- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self setupGraphData];

}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}

- (IBAction)onClose:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark render graph
- (void) setupGraphData
{
    zoomLevel = 1.0f;
    
    int spanDays = SPAN_DAYS*zoomLevel;
    
    NSMutableArray *dateArray = [NSMutableArray array];
    NSMutableArray *daysArray = [NSMutableArray array];
    
    for (int i=0; i<spanDays; i++) 
    {
        NSDate *d = [NSDate date];
        
        d = [d dateByAddingDays:-i];
        
        [dateArray addObject:d];
        
        Day *day = [[Util instance] getDayFromDate:d];
        
        if (day != nil) 
        {
            [daysArray addObject:day];
        }
        else 
        {
            [daysArray addObject:[NSNull null]];
        }
    }
    
    NSArray *dataArray = [NSArray arrayWithObjects:dateArray, daysArray, [NSNumber numberWithFloat:zoomLevel], nil];
    [self.graphView setData:dataArray];
    
    NSLog(@"data for graph ready");

    
}



@end
