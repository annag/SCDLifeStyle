//
//  Util.h
//  SCDLifeStyle
//
//  Created by Juan Fluxa on 5/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Day.h"
#import "Stool.h"
#import "Challenge.h"
#import "UIColor+SCDColors.h"

#define SLEEP_TYPE      0
#define STRESS_TYPE     1
#define EXERCISE_TYPE   2
#define STOOL_TYPE      3

@interface Util : NSObject

//static
+ (Util*)instance;
+ (NSString*) dayIdFromDate:(NSDate*)date;
+ (NSString*) dayIdToday;
+ (NSString*) todayPretty;
+ (NSString*) timePretty:(NSDate*)date;
+ (NSString *)ordinalString:(NSNumber *)rank;

//properties
@property(nonatomic,strong) NSManagedObjectContext *managedObjectContext;

//public
- (Day*) getDayFromDate:(NSDate*)date;
- (NSArray*) getChallenges;
- (NSArray*) getActiveChallengesFromDate:(NSDate*)fromDate toDate:(NSDate*)toDate;
- (void) updateChallenges; //check if any challenge has finished

// Challenge requests
- (NSDate*) endDateForChallenge:(Challenge*)challenge;
- (int)getDaysRemainingForChallenge:(Challenge*)challenge;
- (int)getCurrentDayForChallenge:(Challenge*)challenge;

- (float)getAverageStoolFrequencyOfLast14Days;
- (float)getAverageStoolFrequencyOfLast14DaysFrom:(NSDate*)fromDate;
- (float)getAverageStoolFrequencyOfChallenge:(Challenge*)challenge;

- (float)getAverageStoolTypeOfLast14Days;
- (float)getAverageStoolTypeOfLast14DaysFrom:(NSDate*)fromDate;
- (float)getAverageStoolTypeOfChallenge:(Challenge*)challenge;


// Home view requests
- (float) getTodaysStressPercentage;
- (float) getTodaysSleepPercentage;
- (float) getTodaysExcersisePercentage;
- (float) getTodaysStoolPercentage;


//graph utils
+ (int)getHeightFor:(int)type andValue:(NSNumber*)value;
+ (UIColor *)getColorFor:(int)type andValue:(NSNumber*)value;

+(NSString*) getLabelFor:(int)type;
+ (void)resizeFontForLabel:(UILabel*)aLabel maxSize:(int)maxSize minSize:(int)minSize;
@end
