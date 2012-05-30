//
//  AddChallengeViewController.m
//  SCDLifeStyle
//
//  Created by Juan Fluxa on 5/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AddChallengeViewController.h"
#import "Challenge.h"

@interface AddChallengeViewController () <UITextFieldDelegate,UITextViewDelegate>


@end

@implementation AddChallengeViewController

@synthesize nameTF,descTV,durationTF;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (IBAction)onAddChallenge:(id)sender
{
    if (![self.nameTF.text isEqualToString:@""] &&
        ![self.descTV.text isEqualToString:@""] &&
        ![self.durationTF.text isEqualToString:@""] ) 
    {
        
        Challenge *challenge = [NSEntityDescription insertNewObjectForEntityForName:@"Challenge" 
                                      inManagedObjectContext:self.managedObjectContext];
        challenge.name = self.nameTF.text;
        challenge.desc = self.descTV.text;
        challenge.duration = [NSNumber numberWithInteger:[self.durationTF.text intValue]];
        challenge.started = NO;
        
        //save day object
        NSError *error = nil;
        [self.managedObjectContext save:&error];
        
        if (error == nil) {
            [self dismissModalViewControllerAnimated:YES];
        }
        else {
            Alert(@"Error adding Challenge", @"Add Challenge");
        }
    }
    else {
        Alert(@"fill out all the fields", @"Add Challenge");
    }
}

- (IBAction)onCancel:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark UITextField/View Delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    if (textField == self.nameTF) 
    {
        [UIView animateWithDuration:.5f animations:^{
            CGRect f = self.view.frame;
            self.view.frame = CGRectMake(0.0f, 0.0f, f.size.width, f.size.height);
        }];

    }
    else if (textField == self.durationTF) 
    {
        [UIView animateWithDuration:.5f animations:^{
            CGRect f = self.view.frame;
            self.view.frame = CGRectMake(0.0f, -70.0f, f.size.width, f.size.height);
        }];
    }
    
    return YES;
}

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    if (textView == self.descTV) {
        
        [UIView animateWithDuration:.5f animations:^{
            CGRect f = self.view.frame;
            self.view.frame = CGRectMake(0.0f, 0.0f, f.size.width, f.size.height);
        }];
         
    }
    return YES;
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.nameTF) 
    {
        [self.descTV becomeFirstResponder];
    }
    else if (textField == self.durationTF) 
    {
        [self.durationTF resignFirstResponder];
        [UIView animateWithDuration:.5f animations:^{
            CGRect f = self.view.frame;
            self.view.frame = CGRectMake(0.0f, 0.0f, f.size.width, f.size.height);
        }];  
    }
    
    return YES;
}

- (BOOL) textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [self.durationTF becomeFirstResponder];
        return NO;
    }
    return YES;
}



@end
