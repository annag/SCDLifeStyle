//
//  StoolView.h
//  SCDLifeStyle
//
//  Created by Juan Fluxa on 5/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Stool.h"

@protocol StoolViewDelegate <NSObject>

- (void) onStoolViewDelete:(Stool*)stool;

@end

@interface StoolView : UIView

@property(assign) id delegate;
@property(nonatomic,strong) IBOutlet UIImageView *imageView;
@property(nonatomic,strong) IBOutlet UILabel *titleLabel;
@property(nonatomic,strong) Stool *stool;

- (IBAction)onDelete:(id)sender;

@end
