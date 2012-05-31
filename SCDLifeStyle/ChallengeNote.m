//
//  ChallengeNote.m
//  SCDLifeStyle
//
//  Created by Juan Fluxa on 5/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ChallengeNote.h"

@interface ChallengeNote ()
{
    
}
@end

@implementation ChallengeNote

@synthesize timeLabel,titleLabel,textLabel;

- (id) initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder])) 
    {
                
    }
    return self;
}


- (void) clean
{
    [self.titleLabel setText:@""];
    [self.textLabel setText:@""];
    [self.timeLabel setText:@""];
}

@end
