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


#define SPAN_DAYS 30 //num days to show on graph at zoom level 1.0

@interface GraphViewController ()

@property(nonatomic,strong) NSNumber *zoomLevel;
@property(nonatomic,strong) NSNumber *selectedGraph;

@end

@implementation GraphViewController

@synthesize graphView, zoomMinusButton, zoomPlusButton;
@synthesize zoomLevel;
@synthesize selectedGraph;



- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.selectedGraph = [NSNumber numberWithInt:0];
    self.zoomLevel = [NSNumber numberWithFloat:1.0f];
    self.zoomMinusButton.selected = YES;
    //self.zoomMinusButton.enabled = NO;
    
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

- (IBAction)onZoomSelect:(id)sender
{
    UIButtonDict *bt = sender;
    self.zoomLevel = [bt.dict objectForKey:@"zoom_level"];
    
    self.zoomMinusButton.selected = NO;
    self.zoomPlusButton.selected = NO;
    //self.zoomMinusButton.enabled = YES;
    //self.zoomPlusButton.enabled = YES;
    
    bt.selected = YES;
    //bt.enabled = NO;
    
    [self updateGraphData];

}

#pragma mark render graph
- (void) updateGraphData
{
    
    int spanDays = SPAN_DAYS/self.zoomLevel.floatValue;
    
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
                          self.zoomLevel, 
                          self.selectedGraph, 
                          nil];
    
    [self.graphView setData:dataArray];
    

    
}



@end
