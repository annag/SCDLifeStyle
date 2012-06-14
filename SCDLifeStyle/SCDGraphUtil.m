//
//  SCDGraphUtil.m
//  SCDLifeStyle
//
//  Created by Juan Fluxa on 6/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SCDGraphUtil.h"

@implementation SCDGraphUtil

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

+ (int)getHeightFor:(int)type andValue:(NSNumber*)value
{
    
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

+ (UIColor *)getColorFor:(int)type andValue:(NSNumber*)value
{
    
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
