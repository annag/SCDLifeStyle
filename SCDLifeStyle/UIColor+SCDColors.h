//
//  UIColor+SCDColors.h
//  SCDLifeStyle
//
//  Created by Juan Fluxa on 5/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


#import <UIKit/UIKit.h>

/** Additional functionality for `UIColor`.  */
@interface UIColor (SCDColors)

/** Creates and returns a color object using the specific hex value. 
 @param hex The hex value that will decide the color.
 @return The `UIColor` object.
*/
+ (UIColor *) colorWithHex:(unsigned int)hex;

/** Creates and returns a color object using the specific hex value. 
 @param hex The hex value that will decide the color.
 @param alpha The opacity of the color.
 @return The `UIColor` object.
*/
+ (UIColor *) colorWithHex:(unsigned int)hex alpha:(CGFloat)alpha;


+ (UIColor *) randomColor;

+ (UIColor *) stress5Color; // very dark purple     //relaxed
+ (UIColor *) stress4Color; //dark purple           //relaxed (slight stress)
+ (UIColor *) stress3Color; //middle dark purple    //stressed
+ (UIColor *) stress2Color; //middle light purple   //quite stressed
+ (UIColor *) stress1Color; //light purple          //extremely stressed

+ (UIColor *) sleep5Color; //very dark teel         //very good
+ (UIColor *) sleep4Color; //dark teel              //good
+ (UIColor *) sleep3Color; //middle dark teel       //soso
+ (UIColor *) sleep2Color; //middle light teel      //poor
+ (UIColor *) sleep1Color; //light teel             //very poor

+ (UIColor *) excer4Color; //dark green              //More! 
+ (UIColor *) excer3Color; //middle dark green       //Daily Goal
+ (UIColor *) excer2Color; //middle light green      //A little
+ (UIColor *) excer1Color; //light green             //Zero

+ (UIColor *) challengeColor; //yellow alpha
+ (UIColor *) challengeStrokeColor; //yellow

+ (UIColor *) graphLineBg; //light blue

@end