//
//  ChallengeDetailViewController.h
//  SCDLifeStyle
//
//  Created by Juan Fluxa on 5/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BaseViewController.h"
#import "Challenge.h"

@interface ChallengeDetailViewController : BaseViewController

@property(nonatomic,strong) Challenge *challenge;

@property(nonatomic,strong) IBOutlet UIScrollView *scrollView;
@property(nonatomic,strong) IBOutlet UIButton *actionButton;
@property(nonatomic,strong) IBOutlet UIView *container;
@property(nonatomic,strong) IBOutlet UITextView *noteTV;


- (IBAction)onClose:(id)sender;

- (IBAction)onCancelNote:(id)sender;
- (IBAction)onAddNote:(id)sender;

@end
