//
//  ChallengeNote.h
//  SCDLifeStyle
//
//  Created by Juan Fluxa on 5/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChallengeNote : UIView

@property(nonatomic,strong) IBOutlet UILabel *infoLabel;
@property(nonatomic,strong) IBOutlet UILabel *timeLabel;

- (void) clean;

@end
