//
//  GraphViewController.h
//  SCDLifeStyle
//
//  Created by Juan Fluxa on 5/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BaseViewController.h"
#import "GraphView.h"

@interface GraphViewController : BaseViewController

@property(nonatomic,strong) IBOutlet GraphView *graphView;

- (IBAction)onClose:(id)sender;
- (IBAction)onGraphSelect:(id)sender;

@end
