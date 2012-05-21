//
//  VieMainViewControllerwController.m
//  SCDLifeStyle
//
//  Created by Juan Fluxa on 5/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"
#import <QuartzCore/QuartzCore.h>



@interface MainViewController ()

@end

@implementation MainViewController

@synthesize top1,top2,top3,top4;
@synthesize relaxedBar,stoolBar,activityBar,sleepBar;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.relaxedBar setTopPiece:self.top1];
    [self.relaxedBar setPercent:0.5f];
    
    
    [self.stoolBar setTopPiece:self.top2];
    [self.stoolBar setPercent:.1f];
    
    [self.activityBar setTopPiece:self.top3];
    [self.activityBar setPercent:.7f];
    
    [self.sleepBar setTopPiece:self.top4];
    [self.sleepBar setPercent:.4f];
     
}

- (IBAction)onAddDay:(id)sender
{
    [self performSegueWithIdentifier:@"AddDay" sender:self];
}

@end
