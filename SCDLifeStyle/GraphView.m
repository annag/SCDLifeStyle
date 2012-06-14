//
//  GraphView.m
//  SCDLifeStyle
//
//  Created by Juan Fluxa on 6/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GraphView.h"
#import "Day.h"

@implementation GraphView
@synthesize data = _data;

- (void) setData:(NSArray *)data
{
    _data = data;
    
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    if (self.data != nil) 
    {
        //clean graph view
        for (UIView *v in [self subviews]) 
        {
            [v removeFromSuperview];
        }
        
        NSArray *dates = [self.data objectAtIndex:0];
        NSArray *days = [self.data objectAtIndex:1];
        
        int c = [dates count];
        
        for (int i=0; i<c; i++) 
        {
            NSDate *date = [dates objectAtIndex:i];
            NSObject *dayO = [days objectAtIndex:i];
            
            if (dayO != [NSNull null]) 
            {
                Day *day = (Day*)dayO;
                
            }
        }
    }
}


@end
