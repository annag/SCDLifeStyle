//
//  GraphView.m
//  SCDLifeStyle
//
//  Created by Juan Fluxa on 6/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GraphView.h"
#import "Day.h"
#import <QuartzCore/QuartzCore.h>
#import "Util.h"
#import "NSDate+SCDCategory.h"
#import "Stool.h"

//ALL VALUES AT ZOOM LEVEL 1.0
#define BAR_W 10
#define BAR_GAP 1

#define MARGIN_X 30
#define DATE_LINE_EACH 7 //days
#define DATE_LINE_SHORT 140.0f
#define DATE_LINE_LONG 200.0f
#define CHALLENGE_H 220.0f


@implementation GraphView
@synthesize data = _data;

//NSArray [dates,days,zoomlevel,graphType]
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
        NSArray *ch = [self.data objectAtIndex:2];
        NSNumber *zoom = [self.data objectAtIndex:3];
        NSNumber *type = [self.data objectAtIndex:4];
        
        BOOL showChallenges = [ch count] > 0;
    
        float barW = BAR_W*zoom.floatValue;
        float barGap = BAR_GAP*zoom.floatValue;
        float posX = self.frame.size.width - MARGIN_X - barW;
        float posY = self.frame.size.height;
        
        float todayPinPos;

        int graphType = type.intValue;

        int c = [dates count];
        for (int i=0; i<c; i++) 
        {
            NSDate *date = [dates objectAtIndex:i];
            NSObject *dayO = [days objectAtIndex:i];
            
            CGContextRef c = UIGraphicsGetCurrentContext();
            
            //date
            if (zoom.floatValue == 1.0f) //normal
            {
                if (date.dateInformation.weekday == 2 || date.dateInformation.day == 1) 
                {
                    
                    NSString *dateString;
                    float lineH;
                    
                    if (date.dateInformation.day == 1) 
                    {
                        dateString = [NSString stringWithFormat:@"%d %@", date.dateInformation.day, [date monthString]];
                        lineH = DATE_LINE_LONG;
                    }
                    else 
                    {
                        lineH = DATE_LINE_SHORT;
                    }
                    
                    //draw line
                    CGContextBeginPath(c);
                    CGContextSetLineWidth(c, 1.0f);
                    CGContextSetStrokeColorWithColor(c, [UIColor whiteColor].CGColor);
                    CGContextMoveToPoint(c, posX+barW+barGap, posY);
                    CGContextAddLineToPoint(c, posX+barW+barGap, self.frame.size.height-lineH);
                    CGContextClosePath(c);
                    CGContextDrawPath(c, kCGPathStroke);
                    
                    //draw date
                    if (dateString != nil) 
                    {
                        UIFont *dateFont = [UIFont fontWithName:@"Helvetica" size:17];
                        CGSize dateSize = [dateString sizeWithFont:dateFont];
                        CGContextSetFillColorWithColor(c, [UIColor whiteColor].CGColor);
                        [dateString drawInRect:CGRectMake(posX-dateSize.width, 10, 100, 50) 
                                      withFont:dateFont];
                    }
                    
                    
                }

            }
            else //zoomed view
            {
                if (date.dateInformation.weekday == 2) 
                {
                    NSString *dateString = [NSString stringWithFormat:@"Monday %d %@", date.dateInformation.day, [date monthString]];
                    float lineH = DATE_LINE_LONG;
                    
                    //draw line
                    CGContextBeginPath(c);
                    CGContextSetLineWidth(c, 1.0f);
                    CGContextSetStrokeColorWithColor(c, [UIColor whiteColor].CGColor);
                    CGContextMoveToPoint(c, posX+barW+barGap, posY);
                    CGContextAddLineToPoint(c, posX+barW+barGap, self.frame.size.height-lineH);
                    CGContextClosePath(c);
                    CGContextDrawPath(c, kCGPathStroke);
                    
                    //draw date
                    UIFont *dateFont = [UIFont fontWithName:@"Helvetica" size:14];
                    CGSize dateSize = [dateString sizeWithFont:dateFont];
                    CGContextSetFillColorWithColor(c, [UIColor whiteColor].CGColor);
                    [dateString drawInRect:CGRectMake(posX-dateSize.width/2+20, 5, dateSize.width, dateSize.width) 
                                  withFont:dateFont];

                    
                    
                }

            }
                        
            //GRAPH
            if (dayO != [NSNull null]) 
            {
                Day *day = (Day*)dayO;
                
                //BARS
                NSNumber *barValue;
                switch (graphType) 
                {
                    case SLEEP_TYPE:
                        barValue = day.sleep_quality;
                        break;
                        
                    case STRESS_TYPE:
                        barValue = day.stress;
                        break;
        
                    case EXERCISE_TYPE:
                        barValue = day.excercise;
                        break;
                }
                
                //graph!
                if (barValue != nil) 
                {
                    float barH = [Util getHeightFor:graphType andValue:barValue];
                    UIColor *color = [Util getColorFor:graphType andValue:barValue];
                    CGContextSetFillColorWithColor(c, color.CGColor);
                    CGContextFillRect(c, CGRectMake(posX, posY, barW, -barH));
                }
                
                //POO
                UIImage *pooDot = [UIImage imageNamed:@"graph_stool.png"];
                for (Stool *stool in day.stool) 
                {
                    int stoolPosY = [Util getHeightFor:STOOL_TYPE andValue:stool.type];
                    [pooDot drawAtPoint:CGPointMake(posX, stoolPosY+52)];
                    
                }
                
                //date pin pos
                if ([date isToday]) 
                {
                    todayPinPos = posX;
                }
                
            }
            
            //challenges
            if (showChallenges) 
            {
                NSNumber *challenge = [ch objectAtIndex:i];
                if (challenge.boolValue) 
                {
                    CGContextSetFillColorWithColor(c, [UIColor challengeColor].CGColor);
                    CGContextFillRect(c, CGRectMake(posX, posY, barW+barGap, -CHALLENGE_H));
                }
            }
            
            //today pin
            UIImage *todayPin = [UIImage imageNamed:@"graph_stool.png"];
            [todayPin drawAtPoint:CGPointMake(todayPinPos+barW/2+barGap/2, 200)];

            posX -= barW + barGap;
        }
    }
}


@end
