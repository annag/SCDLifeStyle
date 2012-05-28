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
#import "StoolView.h"

@interface AddDayViewController ()

@property(nonatomic,strong) Day *dayObject;

@end

@implementation AddDayViewController

@synthesize topTitle;
@synthesize stoolControl,excerciseControl,sleepLengthControl,sleepQualityControl,stressControl;
@synthesize containerView, scrollView, stoolScrollView;
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
    else 
    {
        self.dayObject = [NSEntityDescription insertNewObjectForEntityForName:@"Day" 
                                                       inManagedObjectContext:self.managedObjectContext];
        self.dayObject.day_id = [Util dayIdToday];
    }
    
    [self render];
}

- (void) render
{
    self.topTitle.text = [Util todayPretty];
    
    if (self.dayObject.excercise != nil) {
        [self.excerciseControl setSelectedSegmentIndex:[self.dayObject.excercise intValue]];
    }
    
    if (self.dayObject.stress != nil) {
        [self.stressControl setSelectedSegmentIndex:[self.dayObject.stress intValue]];
    }
    
    if (self.dayObject.sleep_length != nil) {
        [self.sleepLengthControl setSelectedSegmentIndex:[self.dayObject.sleep_length intValue]];
    }
    
    if (self.dayObject.sleep_quality != nil) {
        [self.sleepQualityControl setSelectedSegmentIndex:[self.dayObject.sleep_quality intValue]];
    }
    
    //remove all subviews first
    for(UIView *v in [self.stoolScrollView subviews])
    {
        [v removeFromSuperview];
    }
    float posY = 0;
    for(Stool *stool in self.dayObject.stool)
    {
        StoolView *sv = [[[NSBundle mainBundle] loadNibNamed:@"StoolView" owner:self options:nil] objectAtIndex:0];
        [sv setStool:stool];
        sv.frame = CGRectMake(0, posY, sv.frame.size.width, sv.frame.size.height);
        [self.stoolScrollView addSubview:sv];
        
        posY += (2.0f + sv.frame.size.height);
        
    }
    [self.stoolScrollView setContentSize:CGSizeMake(self.stoolScrollView.frame.size.width, posY)];
}


- (IBAction)onDone:(id)sender
{
    //save day object
    NSError *error = nil;
    [self.managedObjectContext save:&error];
    
    if (error == nil) {
        [self dismissModalViewControllerAnimated:YES];
    }
    
}

- (IBAction) onCancel:(id)sender
{
    [self.managedObjectContext reset];
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction) onControlChanted:(id)sender
{
    NSLog(@"onStoolSelected: selected segment = %d", [sender selectedSegmentIndex]);
    
    NSNumber *selectedIndex = [NSNumber numberWithInt:[sender selectedSegmentIndex]];
    if (sender == self.excerciseControl) {
        self.dayObject.excercise = selectedIndex;
    }
    else if (sender == self.stressControl) {
        self.dayObject.stress = selectedIndex;
    }
    else if (sender == self.sleepLengthControl) {
        self.dayObject.sleep_length = selectedIndex;
    }
    else if (sender == self.sleepQualityControl) {
        self.dayObject.sleep_quality = selectedIndex;
    }
    else if (sender == self.stoolControl) 
    {
        Stool *stool = [NSEntityDescription insertNewObjectForEntityForName:@"Stool" 
                                                      inManagedObjectContext:self.managedObjectContext];
        stool.index = selectedIndex;
        stool.time = [NSDate date];
        //stool.day = self.dayObject;
        [self.dayObject addStoolObject:stool];
        
        [self render];
    }
    
}

@end
