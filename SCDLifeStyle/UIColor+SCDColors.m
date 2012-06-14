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
	return [UIColor colorWithHex:hex alpha:1];
}

+ (id) colorWithHex:(unsigned int)hex alpha:(CGFloat)alpha{
	
	return [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0
                           green:((float)((hex & 0xFF00) >> 8)) / 255.0
                            blue:((float)(hex & 0xFF)) / 255.0
                           alpha:alpha];
	
}

+ (UIColor*) randomColor{
	
	int r = arc4random() % 255;
	int g = arc4random() % 255;
	int b = arc4random() % 255;
	return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1];
	
}
+ (UIColor *) stress5Color //dark purple
{
    return [UIColor colorWithRed:37/255.0 green:21/255.0 blue:92/255.0 alpha:1];
}
+ (UIColor *) stress4Color //dark purple
{
	return [UIColor colorWithRed:62/255.0 green:17/255.0 blue:137/255.0 alpha:1];
}
+ (UIColor *) stress3Color //middle dark purple
{
	return [UIColor colorWithRed:113/255.0 green:82/255.0 blue:192/255.0 alpha:1];
}
+ (UIColor *) stress2Color //middle light purple
{
	return [UIColor colorWithRed:171/255.0 green:115/255.0 blue:242/255.0 alpha:1];
}
+ (UIColor *) stress1Color //light purple
{
	return [UIColor colorWithRed:189/255.0 green:161/255.0 blue:238/255.0 alpha:1];
}

+ (UIColor *) sleep5Color //dark teel
{	
	return [UIColor colorWithRed:13/255.0 green:75/255.0 blue:86/255.0 alpha:1];
}
+ (UIColor *) sleep4Color //dark teel
{
	return [UIColor colorWithRed:10/255.0 green:66/255.0 blue:76/255.0 alpha:1];
}
+ (UIColor *) sleep3Color //middle dark teel
{
	return [UIColor colorWithRed:1/255.0 green:108/255.0 blue:137/255.0 alpha:1];
}
+ (UIColor *) sleep2Color //middle light teel
{
	return [UIColor colorWithRed:30/255.0 green:151/255.0 blue:183/255.0 alpha:1];
}
+ (UIColor *) sleep1Color //light teel
{
	return [UIColor colorWithRed:34/255.0 green:191/255.0 blue:232/255.0 alpha:1];
}

+ (UIColor *) excer4Color //dark green
{
	return [UIColor colorWithRed:0/255.0 green:107/255.0 blue:41/255.0 alpha:1];
}
+ (UIColor *) excer3Color //middle dark green
{
	return [UIColor colorWithRed:1/255.0 green:148/255.0 blue:56/255.0 alpha:1];
}
+ (UIColor *) excer2Color //middle light green
{
	return [UIColor colorWithRed:70/255.0 green:185/255.0 blue:117/255.0 alpha:1];
}
+ (UIColor *) excer1Color //light green
{
	return [UIColor colorWithRed:155/255.0 green:222/255.0 blue:153/255.0 alpha:1];
}

+ (UIColor *) challangeColor{
    return [UIColor colorWithRed:255/255.0 green:234/255.0 blue:0/255.0 alpha:1];
}

@end