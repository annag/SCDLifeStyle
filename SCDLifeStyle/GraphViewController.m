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
#import "UIButtonDict.h"


#define SPAN_DAYS 10 //num days to show on graph at zoom level 1.0

@interface GraphViewController ()

@property(nonatomic,assign) float zoomLevel;
@property(nonatomic,strong) NSNumber *selectedGraph;

@end

@implementation GraphViewController

@synthesize graphView;
@synthesize zoomLevel;
@synthesize selectedGraph;


- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.selectedGraph = [NSNumber numberWithInt:0];
    [self updateGraphData];

}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}

- (IBAction)onClose:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)onGraphSelect:(id)sender;
{
    UIButtonDict *bt = sender;
    self.selectedGraph = [bt.dict objectForKey:@"graph_type"];
    [self updateGraphData];
}

#pragma mark render graph
- (void) updateGraphData
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
    
    NSArray *dataArray = [NSArray arrayWithObjects:
                          dateArray, 
                          daysArray, 
                          [NSNumber numberWithFloat:zoomLevel], 
                          self.selectedGraph, 
                          nil];
    
    [self.graphView setData:dataArray];
    

    
}



@end
