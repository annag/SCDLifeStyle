//
//  ChallengeDetailViewController.m
//  SCDLifeStyle
//
//  Created by Juan Fluxa on 5/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ChallengeDetailViewController.h"
#import "ChallengeHeader.h"
#import "ChallengeSegment.h"
#import "ChallengeNote.h"

@interface ChallengeDetailViewController ()

@end

@implementation ChallengeDetailViewController

@synthesize challenge;
@synthesize scrollView,actionButton;

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self render];
}

- (IBAction)onClose:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void) render
{
    [self clean];
    
    float posY = 0.0f;
    
    //header
    ChallengeHeader *chh = [[[NSBundle mainBundle] loadNibNamed:@"ChallengeHeader" owner:self options:nil] objectAtIndex:0];
    chh.labelA.text = self.challenge.name;
    posY = [self addSubView:chh withPosY:posY];
    
    //segment - about
    ChallengeSegment *aboutSegment = [[[NSBundle mainBundle] loadNibNamed:@"ChallengeSegment" owner:self options:nil] objectAtIndex:0];
    aboutSegment.titleLabel.text = @"ABOUT";
    posY = [self addSubView:aboutSegment withPosY:posY];
    
    //about - duration
    ChallengeNote *aboutDuration = [[[NSBundle mainBundle] loadNibNamed:@"ChallengeNote" owner:self options:nil] objectAtIndex:0];
    [aboutDuration clean];
    aboutDuration.titleLabel.text = [NSString stringWithFormat:@"Duration: %d Days",[self.challenge.duration intValue]];
    posY = [self addSubView:aboutDuration withPosY:posY];
    
    if ([self.challenge.started boolValue]) 
    {
        //started
        
        //about - average
        
        
        //about - description
        ChallengeNote *aboutDesc = [[[NSBundle mainBundle] loadNibNamed:@"ChallengeNote" owner:self options:nil] objectAtIndex:0];
        [aboutDesc clean];
        aboutDesc.textLabel.text = self.challenge.desc;
        posY = [self addSubView:aboutDesc withPosY:posY];
        
        //segment - during
        
        
    }
    else 
    {
        //not started
        chh.labelB.text = @"-not started-";
        
        
        //about - description
        ChallengeNote *aboutDesc = [[[NSBundle mainBundle] loadNibNamed:@"ChallengeNoteBottom" owner:self options:nil] objectAtIndex:0];
        [aboutDesc clean];
        aboutDesc.textLabel.text = self.challenge.desc;
        posY = [self addSubView:aboutDesc withPosY:posY];
        
        [self.actionButton setTitle:@"START TODAY" forState:UIControlStateNormal];
        [self.actionButton addTarget:self action:@selector(actionStartToday:) forControlEvents:UIControlEventTouchUpInside];
        
        //end
    }
    
    CGRect f = self.scrollView.frame;
    [self.scrollView setContentSize:CGSizeMake(f.size.width, posY)];
}

- (void) clean
{
    for (UIView *v in [self.scrollView subviews]) 
    {
        [v removeFromSuperview];
    }
}

- (float) addSubView:(UIView*)view withPosY:(float)posY
{
    view.frame = CGRectMake(0, posY, view.frame.size.width, view.frame.size.height);
    [self.scrollView addSubview:view];
    posY += view.frame.size.height;
    return posY;
}

- (void) actionStartToday:(id)sender
{
    self.challenge.start_date = [NSDate date];
    self.challenge.started = [NSNumber numberWithBool:YES];
    NSError *error = nil;
    [self.managedObjectContext save:&error];
    if (error == nil) 
    {
        [self render];
    }
    else {
        Alert(@"Error saving challenge state", @"Challenge");
    }
}




@end
