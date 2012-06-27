//
//  AddChallengeViewController.h
//  SCDLifeStyle
//
//  Created by Juan Fluxa on 5/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BaseViewController.h"

@interface AddChallengeViewController : BaseViewController

@property(nonatomic,strong) IBOutlet UITextField *nameTF;
@property(nonatomic,strong) IBOutlet UITextView *descTV;
@property(nonatomic,strong) IBOutlet UITextField *durationTF;
@property(nonatomic,strong) IBOutlet UIPickerView *durationPicker;


- (IBAction)onAddChallenge:(id)sender;
- (IBAction)onCancel:(id)sender;

@end
