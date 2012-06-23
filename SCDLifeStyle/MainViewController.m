//
//  VieMainViewControllerwController.m
//  SCDLifeStyle
//
//  Created by Juan Fluxa on 5/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Util.h"



@interface MainViewController ()

@end

@implementation MainViewController

@synthesize top1,top2,top3,top4;
@synthesize relaxedBar,stoolBar,activityBar,sleepBar;

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self updateBars];
     
}

- (void) viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    if (animated) {
        [self updateBars];
    }
}

- (void)updateBars{

    [self.relaxedBar setTopPiece:self.top1];
    float percentage1 = [[Util instance] getTodaysStressPercentage];
    [self.relaxedBar setPercent:percentage1];
    
    
    [self.stoolBar setTopPiece:self.top2];
    float percentage2 = [[Util instance] getTodaysStoolPercentage];
    [self.stoolBar setPercent:percentage2];
    
    [self.activityBar setTopPiece:self.top3];
    float percentage3 = [[Util instance] getTodaysExcersisePercentage];
    [self.activityBar setPercent:percentage3];
    
    [self.sleepBar setTopPiece:self.top4];
    float percentage4 = [[Util instance] getTodaysSleepPercentage];
    [self.sleepBar setPercent:percentage4];
}

- (IBAction)onAddDay:(id)sender
{
    [self performSegueWithIdentifier:@"AddDay" sender:self];
}

@end
