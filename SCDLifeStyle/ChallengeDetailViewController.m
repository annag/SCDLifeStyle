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
#import "Util.h"
#import "Note.h"
#import "NSDate+SCDCategory.h"

@interface ChallengeDetailViewController ()

@end

@implementation ChallengeDetailViewController

@synthesize challenge;
@synthesize scrollView,actionButton,container,noteTV;

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
        
        if (self.challenge.finished.boolValue) 
        {
            chh.labelB.text = @"- finished -";
        }
        else 
        {
            int daysRemaining = [[Util instance] getDaysRemainingForChallenge:self.challenge];
            chh.labelB.text = [NSString stringWithFormat:@"-%d days remaining-",daysRemaining];
        }
        
        
        //about - average
        float stoolAvg = [[Util instance] getAverageStoolFrequencyOfLast14Days];
        ChallengeNote *aboutAvg = [[[NSBundle mainBundle] loadNibNamed:@"ChallengeNote" owner:self options:nil] objectAtIndex:0];
        [aboutAvg clean];
        aboutAvg.titleLabel.text = @"Average stool last 14 days";
        aboutAvg.textLabel.text = (stoolAvg >= 0.0f) ? [NSString stringWithFormat:@"- every %.2f days",stoolAvg] : @"not enough data";
        posY = [self addSubView:aboutAvg withPosY:posY];
        
        //about - description
        ChallengeNote *aboutDesc = [[[NSBundle mainBundle] loadNibNamed:@"ChallengeNoteBottom" owner:self options:nil] objectAtIndex:0];
        [aboutDesc clean];
        aboutDesc.textLabel.text = self.challenge.desc;
        posY = [self addSubView:aboutDesc withPosY:posY];
        
        posY += 10;
        //segment - during
        if ([self.challenge.note count] > 0) 
        {
            //segment
            ChallengeSegment *duringSegment = [[[NSBundle mainBundle] loadNibNamed:@"ChallengeSegment" owner:self options:nil] objectAtIndex:0];
            duringSegment.titleLabel.text = @"DURING";
            posY = [self addSubView:duringSegment withPosY:posY];
            
            //notes
            int noteCount = 0;
            for (Note *note in self.challenge.note) 
            {
                noteCount++;
                NSString *nibName = @"ChallengeNote";
                if (noteCount >= [self.challenge.note count]) {
                    nibName = @"ChallengeNoteBottom";
                }
                
                ChallengeNote *duringNote = [[[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil] objectAtIndex:0];
                [duringNote clean];
                int daysNote = [self.challenge.start_date daysBetweenDate:note.added];
                duringNote.textLabel.text = note.text;
                duringNote.timeLabel.text = [NSString stringWithFormat:@"%d days",daysNote];
                posY = [self addSubView:duringNote withPosY:posY];
                
            }
            
            
        }
        
        //action
        [self.actionButton setTitle:@"Add Note" forState:UIControlStateNormal];
        [self.actionButton removeTarget:self action:@selector(actionStartToday:) forControlEvents:UIControlEventAllEvents];
        [self.actionButton addTarget:self action:@selector(actionAddNote:) forControlEvents:UIControlEventTouchUpInside];
        
        
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
    self.challenge.end_date = [[Util instance] endDateForChallenge:self.challenge];
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

- (void) actionAddNote:(id)sender
{
    [UIView animateWithDuration:0.5f 
                     animations:^{
                         self.container.frame = CGRectMake(0, -480, self.container.frame.size.width, self.container.frame.size.height);
                     }
                    completion:^(BOOL finished) {
                        [self.noteTV becomeFirstResponder];
                    }];
}

- (void) animBackFromNote
{
    [self.noteTV resignFirstResponder];
    [UIView animateWithDuration:0.5f 
                     animations:^{
                         self.container.frame = CGRectMake(0, 0, self.container.frame.size.width, self.container.frame.size.height);
                     }];
}

- (IBAction)onCancelNote:(id)sender
{
    [self animBackFromNote];
}

- (IBAction)onAddNote:(id)sender
{
    if (![self.noteTV.text isEqualToString:@""]) 
    {
        Note *note = [NSEntityDescription insertNewObjectForEntityForName:@"Note" 
                                                             inManagedObjectContext:self.managedObjectContext];
        note.added = [NSDate date];
        note.text = self.noteTV.text;
        self.noteTV.text = @"";
        
        [self.challenge addNoteObject:note];
                
        //save object
        NSError *error = nil;
        [self.managedObjectContext save:&error];
        
        if (error != nil) {
            Alert(@"Error adding note", @"Challenge Note");
        }
        else 
        {
            [self render];
        }
        
        [self animBackFromNote];
        
    }
}

@end
