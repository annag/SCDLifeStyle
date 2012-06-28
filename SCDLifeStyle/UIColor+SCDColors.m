//
//  UIColor+SCDColors.h
//  SCDLifeStyle
//
//  Created by Juan Fluxa on 5/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


#import "UIColor+SCDColors.h"



@implementation UIColor (SCDColors)


+ (id) colorWithHex:(unsigned int)hex{
	return [UIColor colorWithHex:hex alpha:1.0f];
}

+ (id) colorWithHex:(unsigned int)hex alpha:(CGFloat)alpha{
	
	return [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0f
                           green:((float)((hex & 0xFF00) >> 8)) / 255.0f
                            blue:((float)(hex & 0xFF)) / 255.0f
                           alpha:alpha];
	
}

+ (UIColor*) randomColor{
	
	int r = arc4random() % 255;
	int g = arc4random() % 255;
	int b = arc4random() % 255;
	return [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0f];
	
}
+ (UIColor *) stress5Color //dark purple
{
    return [UIColor colorWithRed:37.0f/255.0f green:21.0f/255.0f blue:92.0f/255.0f alpha:1.0f];
}
+ (UIColor *) stress4Color //dark purple
{
	return [UIColor colorWithRed:62.0f/255.0f green:17.0f/255.0f blue:137.0f/255.0f alpha:1.0f];
}
+ (UIColor *) stress3Color //middle dark purple
{
	return [UIColor colorWithRed:113.0f/255.0f green:82.0f/255.0f blue:192.0f/255.0f alpha:1.0f];
}
+ (UIColor *) stress2Color //middle light purple
{
	return [UIColor colorWithRed:171.0f/255.0f green:115.0f/255.0f blue:242.0f/255.0f alpha:1.0f];
}
+ (UIColor *) stress1Color //light purple
{
	return [UIColor colorWithRed:189.0f/255.0f green:161.0f/255.0f blue:238.0f/255.0f alpha:1.0f];
}

+ (UIColor *) sleep5Color //dark teel
{	
	return [UIColor colorWithRed:13.0f/255.0f green:75.0f/255.0f blue:86.0f/255.0f alpha:1.0f];
}
+ (UIColor *) sleep4Color //dark teel
{
	return [UIColor colorWithRed:10.0f/255.0f green:66.0f/255.0f blue:76.0f/255.0f alpha:1.0f];
}
+ (UIColor *) sleep3Color //middle dark teel
{
	return [UIColor colorWithRed:1.0f/255.0f green:108.0f/255.0f blue:137.0f/255.0f alpha:1.0f];
}
+ (UIColor *) sleep2Color //middle light teel
{
	return [UIColor colorWithRed:30.0f/255.0f green:151.0f/255.0f blue:183.0f/255.0f alpha:1.0f];
}
+ (UIColor *) sleep1Color //light teel
{
	return [UIColor colorWithRed:34/255.0f green:191/255.0f blue:232/255.0f alpha:1.0f];
}

+ (UIColor *) excer4Color //dark green
{
	return [UIColor colorWithRed:0/255.0f green:107/255.0f blue:41/255.0f alpha:1.0f];
}
+ (UIColor *) excer3Color //middle dark green
{
	return [UIColor colorWithRed:1/255.0f green:148/255.0f blue:56/255.0f alpha:1.0f];
}
+ (UIColor *) excer2Color //middle light green
{
	return [UIColor colorWithRed:70.0f/255.0f green:185.0f/255.0f blue:117.0f/255.0f alpha:1.0f];
}
+ (UIColor *) excer1Color //light green
{
	return [UIColor colorWithRed:155.0f/255.0f green:222.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
}

+ (UIColor *) challengeColor //yellow alpha
{
    return [UIColor colorWithRed:255.0f/255.0f green:234.0f/255.0f blue:0/255.0f alpha:.2f];
}

+ (UIColor *) challengeStrokeColor //yellow
{
    return [UIColor colorWithRed:255.0f/255.0f green:234.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
}

+ (UIColor *) graphLineBg //light blue
{
    return [UIColor colorWithRed:3.0f/255.0f green:109.0f/255.0f blue:179.0f/255.0f alpha:0.5f];
}

@end