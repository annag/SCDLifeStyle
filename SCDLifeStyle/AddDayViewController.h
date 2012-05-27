//
//  AddDayViewController.h
//  SCDLifeStyle
//
//  Created by Juan Fluxa on 5/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BaseViewController.h"

@interface AddDayViewController : BaseViewController

@property(nonatomic,strong) IBOutlet UILabel *topTitle;
@property(nonatomic,strong) IBOutlet UISegmentedControl *stoolControl;
@property(nonatomic,strong) IBOutlet UISegmentedControl *excerciseControl;
@property(nonatomic,strong) IBOutlet UISegmentedControl *sleepLengthControl;
@property(nonatomic,strong) IBOutlet UISegmentedControl *sleepQualityControl;
@property(nonatomic,strong) IBOutlet UISegmentedControl *stressControl;
@property(nonatomic,strong) IBOutlet UIScrollView *scrollView;
@property(nonatomic,strong) IBOutlet UIView *containerView;


- (IBAction) onDone:(id)sender;
- (IBAction) onControlChanted:(id)sender;



@end
