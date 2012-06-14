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

#define SLEEP_TYPE      0
#define STRESS_TYPE     1
#define EXCERSIZE_TYPE  2
#define STOOL_TYPE      3

#define SLEEP_HEIGHT_5  330/2
#define SLEEP_HEIGHT_4  254/2
#define SLEEP_HEIGHT_3  180/2
#define SLEEP_HEIGHT_2  104/2
#define SLEEP_HEIGHT_1  30/2

#define STRESS_HEIGHT_5  330/2
#define STRESS_HEIGHT_4  254/2
#define STRESS_HEIGHT_3  180/2
#define STRESS_HEIGHT_2  104/2
#define STRESS_HEIGHT_1  30/2

#define EXCER_HEIGHT_4  330/2
#define EXCER_HEIGHT_3  220/2
#define EXCER_HEIGHT_2  110/2
#define EXCER_HEIGHT_1  30/2

#define STOOL_POS_7  330/2
#define STOOL_POS_6  274/2
#define STOOL_POS_5  220/2
#define STOOL_POS_4  164/2
#define STOOL_POS_3  110/2
#define STOOL_POS_2  54/2
#define STOOL_POS_1  0

- (int)getHeightFor:(int)type andValue:(NSNumber*)value{

    switch(type){
        case SLEEP_TYPE:
            if([value intValue]  == 4){        //very good
                return SLEEP_HEIGHT_5;
            }else if([value intValue]  == 3){  //good
                return SLEEP_HEIGHT_4;
            }else if([value intValue]  == 2){  //soso
                return SLEEP_HEIGHT_3;
            }else if([value intValue]  == 1){  //poor
                return SLEEP_HEIGHT_2;
            }else if([value intValue]  == 0){  //very poor
                return SLEEP_HEIGHT_1;
            }
        case STRESS_TYPE:
            if([value intValue]  == 4){        //very relaxed
                return STRESS_HEIGHT_5;
            }else if([value intValue]  == 3){  //relaxed
                return STRESS_HEIGHT_4;
            }else if([value intValue]  == 2){  //gloomy
                return STRESS_HEIGHT_3;
            }else if([value intValue]  == 1){  //stressed
                return STRESS_HEIGHT_2;
            }else if([value intValue]  == 0){  //very stressed
                return STRESS_HEIGHT_1;
            }
        case EXCERSIZE_TYPE:
            if([value intValue]  == 3){        //more!
                return EXCER_HEIGHT_4;
            }else if([value intValue]  == 2){  //daily goal
                return EXCER_HEIGHT_3;
            }else if([value intValue]  == 1){  //a little
                return EXCER_HEIGHT_2;
            }else if([value intValue]  == 0){   //none
                return EXCER_HEIGHT_1;
            }
        case STOOL_TYPE:
            if([value intValue]  == 6){        //very constipated
                return STOOL_POS_7;
            }else if([value intValue]  == 5){  //constipated
                return STOOL_POS_6;
            }else if([value intValue]  == 4){  //good poo
                return STOOL_POS_5;
            }else if([value intValue]  == 3){  //good poo
                return STOOL_POS_4;
            }else if([value intValue]  == 2){  //slight diareah
                return STOOL_POS_3;
            }else if([value intValue]  == 1){  //diareah
                return STOOL_POS_2;
            }else if([value intValue]  == 0){  //very loose stool (extreme diareah)
                return STOOL_POS_1;
            }
        default:
            return 0;
    }
    
}

- (UIColor *)getColorFor:(int)type andValue:(NSNumber*)value{
    
    switch(type){
        case SLEEP_TYPE:
            if([value intValue]  == 4){        //very good
                return [UIColor sleep5Color];
            }else if([value intValue]  == 3){  //good
                return [UIColor sleep4Color];
            }else if([value intValue]  == 2){  //soso
                return  [UIColor sleep3Color];
            }else if([value intValue]  == 1){  //poor
                return  [UIColor sleep2Color];
            }else if([value intValue]  == 0){  //very poor
                return  [UIColor sleep1Color];
            }
        case STRESS_TYPE:
            if([value intValue]  == 4){        //very relaxed
                return [UIColor stress5Color];
            }else if([value intValue]  == 3){  //relaxed
                return [UIColor stress4Color];
            }else if([value intValue]  == 2){  //gloomy
                return [UIColor stress3Color];
            }else if([value intValue]  == 1){  //stressed
                return [UIColor stress2Color];
            }else if([value intValue]  == 0){  //very stressed
                return [UIColor stress1Color];
            }
        case EXCERSIZE_TYPE:
            if([value intValue]  == 3){        //more!
                return [UIColor excer4Color];
            }else if([value intValue]  == 2){  //daily goal
                return [UIColor excer3Color];
            }else if([value intValue]  == 1){  //a little
                return [UIColor excer2Color];
            }else if([value intValue]  == 0){   //none
                return [UIColor excer1Color];
            }
        default:
            return [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1];
    }
    
}
@end