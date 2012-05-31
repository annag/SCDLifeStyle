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

+ (UIColor *) stress5Color; // very dark purple
+ (UIColor *) stress4Color; //dark purple
+ (UIColor *) stress3Color; //middle dark purple
+ (UIColor *) stress2Color; //middle light purple
+ (UIColor *) stress1Color; //light purple

+ (UIColor *) sleep5Color; //very dark teel
+ (UIColor *) sleep4Color; //dark teel
+ (UIColor *) sleep3Color; //middle dark teel
+ (UIColor *) sleep2Color; //middle light teel
+ (UIColor *) sleep1Color; //light teel

+ (UIColor *) exer4Color; //dark green
+ (UIColor *) exer3Color; //middle dark green
+ (UIColor *) exer2Color; //middle light green
+ (UIColor *) exer1Color; //light green

+ (UIColor *) challangeColor; //yellow
@end