//
//  TrendBoxView.h
//  SCDLifeStyle
//
//  Created by Juan Fluxa on 7/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TrendBoxView : UIView

@property(nonatomic,strong) IBOutlet UILabel *trackedLabel;
@property(nonatomic,strong) IBOutlet UILabel *bmTypeLabel;
@property(nonatomic,strong) IBOutlet UILabel *bmTimeLabel;
@property(nonatomic,strong) IBOutlet UIImageView *bmTrendImageView;

@end
