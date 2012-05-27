//
//  AddDayViewController.m
//  SCDLifeStyle
//
//  Created by Juan Fluxa on 5/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AddDayViewController.h"
#import "Util.h"

@interface AddDayViewController ()

@end

@implementation AddDayViewController

@synthesize stoolControl,excerciseControl,sleepLengthControl,sleepQualityControl,stressControl;
@synthesize containerView, scrollView;


- (void)viewDidLoad
{
    [super viewDidLoad];
	
    NSString *todayId = [Util dayIdToday];
    NSLog(@"today id %@",todayId);
    
    [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width, self.containerView.frame.size.height)];
    
}

- (IBAction)onDone:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction) onControlChanted:(id)sender
{
    NSLog(@"onStoolSelected: selected segment = %d", [sender selectedSegmentIndex]);
    
    
    
}

@end
