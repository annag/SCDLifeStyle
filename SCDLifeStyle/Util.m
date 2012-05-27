//
//  Util.m
//  SCDLifeStyle
//
//  Created by Juan Fluxa on 5/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Util.h"

@implementation Util


+ (NSString*) dayIdFromDate:(NSDate*)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy_MM_dd"];
    NSString *dayId = [formatter stringFromDate:date];
    return dayId;
}

+ (NSString*) dayIdToday
{
    NSDate *today = [NSDate date];
    return [Util dayIdFromDate:today];    
}

+ (NSString*) todayPretty
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dayId = [formatter stringFromDate:[NSDate date]];
    return dayId;
}



@end
