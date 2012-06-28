//
//  AddChallengeViewController.m
//  SCDLifeStyle
//
//  Created by Juan Fluxa on 5/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AddChallengeViewController.h"
#import "Challenge.h"

@interface AddChallengeViewController () <UITextFieldDelegate,UITextViewDelegate,UIPickerViewDataSource, UIPickerViewDelegate>

@property(nonatomic,strong) NSArray *durationPickerData;

@end

@implementation AddChallengeViewController

@synthesize nameTF,descTV,durationTF,durationPicker;
@synthesize durationPickerData;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self.nameTF becomeFirstResponder];
    
    //duration picker data
    NSURL *dpDataUrl = [[NSBundle mainBundle] URLForResource:@"ChallengeDurationData" withExtension:@"plist"];
    self.durationPickerData = [NSArray arrayWithContentsOfURL:dpDataUrl];
    
}

- (IBAction)onAddChallenge:(id)sender
{
    if (![self.nameTF.text isEqualToString:@""] &&
        ![self.descTV.text isEqualToString:@""] &&
        ![self.durationTF.text isEqualToString:@""] ) 
    {
        
        NSDictionary *d = [self.durationPickerData objectAtIndex:self.durationTF.tag];
        Challenge *challenge = [NSEntityDescription insertNewObjectForEntityForName:@"Challenge" 
                                      inManagedObjectContext:self.managedObjectContext];
        challenge.name = self.nameTF.text;
        challenge.desc = self.descTV.text;
        challenge.duration = (NSNumber*)[d objectForKey:@"value"];
        challenge.started = [NSNumber numberWithBool:NO];
        challenge.finished = [NSNumber numberWithBool:NO];
        
        //save day object
        NSError *error = nil;
        [self.managedObjectContext save:&error];
        
        if (error == nil) 
        {
            [self dismissModalViewControllerAnimated:YES];
        }
        else 
        {
            Alert(@"Add Challenge",@"Error adding Challenge");
        }
    }
    else 
    {
        Alert(@"Add Challenge",@"fill out all the fields");
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
        [self showDurationPicker];
        return NO;
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
        //[self.durationTF becomeFirstResponder];
        [textView resignFirstResponder];
        [self showDurationPicker];
        return NO;
    }
    return YES;
}

#pragma mark UIPickerDelegate
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.durationPickerData count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSDictionary *d = [self.durationPickerData objectAtIndex:row];
    return [d objectForKey:@"label"];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (row == 0) {
        return;
    }
    NSDictionary *d = [self.durationPickerData objectAtIndex:row];
    self.durationTF.text = [d objectForKey:@"label"];
    self.durationTF.tag = row;
    [self hideDurationPicker];
    
}

- (void) showDurationPicker
{
    [UIView animateWithDuration:.5f animations:^{
        CGRect f = self.view.frame;
        self.view.frame = CGRectMake(0.0f, -70.0f, f.size.width, f.size.height);
    }];
    
    [UIView animateWithDuration:.5f 
                     animations:^{
                         self.durationPicker.frame = CGRectMake(0, 
                                                                480-self.durationPicker.frame.size.height+70, 
                                                                self.durationPicker.frame.size.width, 
                                                                self.durationPicker.frame.size.height);
                     }];
}

- (void) hideDurationPicker
{
    [UIView animateWithDuration:.5f animations:^{
        CGRect f = self.view.frame;
        self.view.frame = CGRectMake(0.0f, 0.0f, f.size.width, f.size.height);
    }];  
    
    [UIView animateWithDuration:0.5f 
                     animations:^{
                         self.durationPicker.frame = CGRectMake(0, 
                                                                480, 
                                                                self.durationPicker.frame.size.width, 
                                                                self.durationPicker.frame.size.height);
                     }];
}

@end
