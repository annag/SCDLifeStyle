//
//  ChallengeNote.m
//  SCDLifeStyle
//
//  Created by Juan Fluxa on 5/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ChallengeNote.h"

@implementation ChallengeNote

@synthesize timeLabel,titleLabel,textLabel;

- (id) initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder])) 
    {
        //clean labels at start
        self.titleLabel.text = @"";
        self.textLabel.text = @"";
        self.timeLabel.text = @"";
    }
    return self;
}

@end
