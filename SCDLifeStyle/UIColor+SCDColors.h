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

@end