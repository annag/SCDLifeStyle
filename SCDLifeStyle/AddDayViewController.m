//
//  AddDayViewController.m
//  SCDLifeStyle
//
//  Created by Juan Fluxa on 5/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AddDayViewController.h"
#import "Util.h"
#import "Day.h"

@interface AddDayViewController ()

@property(nonatomic,strong) Day *dayObject;

@end

@implementation AddDayViewController

@synthesize topTitle;
@synthesize stoolControl,excerciseControl,sleepLengthControl,sleepQualityControl,stressControl;
@synthesize containerView, scrollView;
@synthesize dayObject;


- (void)viewDidLoad
{
    [super viewDidLoad];
	
    NSString *todayId = [Util dayIdToday];
    NSLog(@"today id %@",todayId);
    
    [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width, self.containerView.frame.size.height)];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"day_id == %@",[Util dayIdToday]];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Day"];
    [request setPredicate:predicate];
    NSError *error = nil;
    NSArray *a = [self.managedObjectContext executeFetchRequest:request error:&error];
    if ([a count] > 0 && error == nil) 
    {
        self.dayObject = (Day*)[a objectAtIndex:0];
    }
    
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
