//
//  Util.h
//  SCDLifeStyle
//
//  Created by Juan Fluxa on 5/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Util : NSObject

+ (NSString*) dayIdFromDate:(NSDate*)date;
+ (NSString*) dayIdToday;
+ (NSString*) todayPretty;
+ (NSString*) timePretty:(NSDate*)date;
@end
