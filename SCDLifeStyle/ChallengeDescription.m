//
//  ChallengeDescription.m
//  SCDLifeStyle
//
//  Created by Juan Fluxa on 6/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ChallengeDescription.h"

@implementation ChallengeDescription

@synthesize titleLabel,infoLabel,nodataLabel;

- (void) clean
{
    [self.titleLabel setText:@""];
    [self.infoLabel setText:@""];
}

@end
