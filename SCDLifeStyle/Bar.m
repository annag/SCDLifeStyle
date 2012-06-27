//
//  Bar.m
//  SCDLifeStyle
//
//  Created by Juan Fluxa on 5/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Bar.h"

#define BASE_PERCENT 0.15f

@interface Bar ()

@property(nonatomic,assign) float Y;
@property(nonatomic,assign) float H;

@end

@implementation Bar

@synthesize percent = _percent;
@synthesize topPiece;
@synthesize Y,H;


- (id) initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder])) 
    {
        self.Y = self.frame.origin.y;
        self.H = self.frame.size.height;
        _percent = -1.0f;

    }
    return self;
}

- (void) setPercent:(float)percent
{
    if (percent != _percent) 
    {
        
        _percent = BASE_PERCENT + (1.0f-BASE_PERCENT) * percent;
        
        [self animatePercent];
    }
}

- (void) animatePercent
{
    CGRect f = self.frame;
    float newH = roundf(_percent*self.H);
    [UIView animateWithDuration:0.5f 
                     animations:^{
                        
                         self.frame = CGRectMake(f.origin.x, self.Y + (self.H - newH), f.size.width, newH);
                         
                     }];
    
    if (self.topPiece != nil) {
        CGRect tf = self.topPiece.frame;
        [UIView animateWithDuration:0.5f
                         animations:^{
                             self.topPiece.frame = CGRectMake(tf.origin.x, self.Y + (self.H - newH) - tf.size.height, tf.size.width, tf.size.height); 
                         }];
    }
}

- (void) layoutSubviews
{
    [super layoutSubviews];
       
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
