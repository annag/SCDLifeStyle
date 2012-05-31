//
//  Util.m
//  SCDLifeStyle
//
//  Created by Juan Fluxa on 5/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Util.h"
#import "NSDate+SCDCategory.h"

static Util *instance = nil;

@implementation Util
@synthesize managedObjectContext;

+ (Util*)instance
{
    @synchronized(self)
    {
    	if (instance == nil)
    		instance = [[Util alloc] init];
    }
    return instance;
}

+ (id)allocWithZone:(NSZone *)zone {
    @synchronized(self) {
        if (instance == nil) {
            instance = [super allocWithZone:zone];
            return instance;  // assignment and return on first allocation
        }
    }
    return nil; // on subsequent allocation attempts return nil
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}


//static
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

+ (NSString*) timePretty:(NSDate*)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH-mm"];
    NSString *dayId = [formatter stringFromDate:date];
    return dayId;
}

//public
- (Day*) getDayFromDate:(NSDate *)date
{
    NSString *dateId = [Util dayIdFromDate:date];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"day_id == %@",dateId];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Day"];
    [request setPredicate:predicate];
    NSError *error = nil;
    NSArray *a = [self.managedObjectContext executeFetchRequest:request error:&error];
    if ([a count] > 0 && error == nil) 
    {
        return (Day*)[a objectAtIndex:0];
    }
    return nil;
}

- (NSArray*) getChallenges
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Challenge"];
    NSError *error = nil;
    NSArray *challenges = [self.managedObjectContext executeFetchRequest:request error:&error];
    if (error == nil) {
        return challenges;
    }
    return [NSArray array];
}

///******************************************************************************///
// Challenge requests
///******************************************************************************///

- (NSDate*) endDateForChallenge:(Challenge*)challenge
{
    return [challenge.start_date dateByAddingDays:challenge.duration.intValue];
}

- (int)getDaysRemainingForChallenge:(Challenge*)challenge{

    return [challenge.start_date daysBetweenDate:challenge.end_date];
}

- (int)getCurrentDayForChallenge:(Challenge*)challenge{

     return [challenge.start_date daysBetweenDate:[NSDate date]];
}

- (float)getAverageStoolFrequencyOfLast14Days{

    return 3.5;
}

- (float)getAverageStoolFrequencyOfChallenge:(Challenge*)challenge
{
    return 4.5;
}

- (float)getAverageStyleTypeOfLast14Days{

    return 5.5;
}

- (float)getAverageStyleTypeOfChallenge:(Challenge*)challenge{
    
    return 6.5;
}

- (BOOL)challengeDidFinish:(Challenge*)challenge{
    
    int daysremaining = [self getDaysRemainingForChallenge:challenge];
    return (daysremaining <0);
}

///******************************************************************************///
// Home view requests
///******************************************************************************///
- (int) getTodaysStressPercentage{

    return 0;
}

- (int) getTodaysSleepPercentage{

    return 0;
}

- (int) getTodaysExcersisePercentage{

    return 0;
}

- (int) getTodaysStoolPercentage{
    
    return 0;
}
@end
