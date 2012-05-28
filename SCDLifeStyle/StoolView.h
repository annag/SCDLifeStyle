//
//  StoolView.h
//  SCDLifeStyle
//
//  Created by Juan Fluxa on 5/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Stool.h"

@interface StoolView : UIView

@property(nonatomic,strong) IBOutlet UIImageView *imageView;
@property(nonatomic,strong) IBOutlet UILabel *titleLabel;
@property(nonatomic,strong) Stool *stool;

@end
