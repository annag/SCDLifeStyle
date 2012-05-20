//
//  AddDayViewController.h
//  SCDLifeStyle
//
//  Created by Juan Fluxa on 5/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BaseViewController.h"

@interface AddDayViewController : BaseViewController

@property(nonatomic,strong) IBOutlet UISegmentedControl *stoolControl;
@property(nonatomic,strong) IBOutlet UISegmentedControl *excerciseControl;
@property(nonatomic,strong) IBOutlet UISegmentedControl *sleepLengthControl;
@property(nonatomic,strong) IBOutlet UISegmentedControl *sleepQualityControl;
@property(nonatomic,strong) IBOutlet UISegmentedControl *stressControl;

- (IBAction) onDone:(id)sender;
- (IBAction) onControlChanted:(id)sender;

@end
