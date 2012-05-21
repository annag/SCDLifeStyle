//
//  MainViewController.h
//  SCDLifeStyle
//
//  Created by Juan Fluxa on 5/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BaseViewController.h"
#import "Bar.h"

@interface MainViewController : BaseViewController

@property(nonatomic,strong) IBOutlet UIView *top1;
@property(nonatomic,strong) IBOutlet UIView *top2;
@property(nonatomic,strong) IBOutlet UIView *top3;
@property(nonatomic,strong) IBOutlet UIView *top4;

@property(nonatomic,strong) IBOutlet Bar *relaxedBar;
@property(nonatomic,strong) IBOutlet Bar *stoolBar;
@property(nonatomic,strong) IBOutlet Bar *activityBar;
@property(nonatomic,strong) IBOutlet Bar *sleepBar;

- (IBAction)onAddDay:(id)sender;

@end
