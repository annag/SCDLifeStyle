//
//  GraphViewController.h
//  SCDLifeStyle
//
//  Created by Juan Fluxa on 5/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BaseViewController.h"
#import "GraphView.h"
#import "UIButtonDict.h"

@interface GraphViewController : BaseViewController

@property(nonatomic,strong) IBOutlet GraphView *graphView;
@property(nonatomic,strong) IBOutlet UIButtonDict *zoomMinusButton;
@property(nonatomic,strong) IBOutlet UIButtonDict *zoomPlusButton;
@property(nonatomic,strong) IBOutlet UIButton *nextButton;
@property(nonatomic,strong) IBOutlet UIButton *graphTypeAButton;
@property(nonatomic,strong) IBOutlet UIButton *graphTypeBButton;
@property(nonatomic,strong) IBOutlet UIButton *graphTypeCButton;

- (IBAction)onClose:(id)sender;
- (IBAction)onGraphSelect:(id)sender;
- (IBAction)onZoomSelect:(id)sender;
- (IBAction)onPrevious:(id)sender;
- (IBAction)onNext:(id)sender;
- (IBAction)onChallenge:(id)sender;

@end
