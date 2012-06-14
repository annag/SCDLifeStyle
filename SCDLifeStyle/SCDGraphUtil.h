//
//  SCDGraphUtil.h
//  SCDLifeStyle
//
//  Created by Juan Fluxa on 6/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIColor+SCDColors.h"

@interface SCDGraphUtil : NSObject

+ (int)getHeightFor:(int)type andValue:(NSNumber*)value;
+ (UIColor *)getColorFor:(int)type andValue:(NSNumber*)value;

@end
