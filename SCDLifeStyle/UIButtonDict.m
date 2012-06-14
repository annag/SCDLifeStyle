//
//  UIButtonDict.m
//  SCDLifeStyle
//
//  Created by Juan Fluxa on 6/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UIButtonDict.h"

@interface UIButtonDict ()



@end

@implementation UIButtonDict

@synthesize dict;

- (id) initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder])) 
    {
        self.dict = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void) setValue:(id)value forKeyPath:(NSString *)keyPath
{
    [self.dict setValue:value forKeyPath:keyPath];
}

@end
