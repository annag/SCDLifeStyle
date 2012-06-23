//
//  ChallengeDescription.h
//  SCDLifeStyle
//
//  Created by Juan Fluxa on 6/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChallengeDescription : UIView

@property(nonatomic,strong) IBOutlet UILabel *titleLabel;
@property(nonatomic,strong) IBOutlet UILabel *infoLabel;
@property(nonatomic,strong) IBOutlet UILabel *nodataLabel;

- (void) clean;

@end
