//
//  Util.m
//  SCDLifeStyle
//
//  Created by Juan Fluxa on 5/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Util.h"
#import "NSDate+SCDCategory.h"

#define noOfStressValues 4.0f

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
#define STOOL_POS_6  280/2
#define STOOL_POS_5  226/2
#define STOOL_POS_4  170/2
#define STOOL_POS_3  116/2
#define STOOL_POS_2  60/2
#define STOOL_POS_1  0

#define STOOL_TREND_BETTER 2
#define STOOL_TREND_SAME 1
#define STOOL_TREND_WORSE 0

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

+ (NSString *)ordinalString:(NSNumber *)rank
{
    NSString *suffix = nil;
    int rankInt = [rank intValue];
    int ones = rankInt % 10;
    int tens = floor(rankInt / 10);
    tens = tens % 10;
    if (tens == 1) {
        suffix = @"th";
    } else {
        switch (ones) {
            case 1 : suffix = @"st"; break;
            case 2 : suffix = @"nd"; break;
            case 3 : suffix = @"rd"; break;
            default : suffix = @"th";
        }
    }
    NSString *rankString = [NSString stringWithFormat:@"%@%@", rank, suffix];
    return rankString;
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

- (NSArray*) getActiveChallengesFromDate:(NSDate*)fromDate toDate:(NSDate*)toDate
{
    NSMutableArray *a = [NSMutableArray array];
    NSArray *challenges = [self getChallenges];
    for (Challenge *ch in challenges) 
    {
        if (ch.started.boolValue && [ch.start_date isBetweenDate:fromDate andDate:toDate]) 
        {
            [a addObject:ch];
        }
    }
    return a;
}

- (void) updateChallenges
{
    NSArray *challenges = [self getChallenges];
    BOOL modified = NO;
    for (Challenge *challenge in challenges) 
    {
        if (challenge.started.boolValue && !challenge.finished.boolValue) 
        {
            NSComparisonResult r = [challenge.end_date compare:[NSDate date]];
            if (r == NSOrderedAscending) {
                challenge.finished = [NSNumber numberWithBool:YES];
                modified = YES;
            }

        }
    }
    if (modified) {
        NSError *error = nil;
        [self.managedObjectContext save:&error];
        if (error != nil) {
            Alert(@"Challenges",@"Error saving challenges after updating");
        }
    }
}

///******************************************************************************///
// Challenge requests
///******************************************************************************///

- (NSDate*) endDateForChallenge:(Challenge*)challenge
{
    return [challenge.start_date dateByAddingDays:challenge.duration.intValue];
}

- (int)getDaysRemainingForChallenge:(Challenge*)challenge{

    return challenge.duration.intValue - [self getCurrentDayForChallenge:challenge];
}

- (int)getCurrentDayForChallenge:(Challenge*)challenge{

     return [challenge.start_date daysBetweenDate:[NSDate date]];
}


- (float)getAverageStoolFrequencyOfLast14Days{ 
    return [self getAverageStoolFrequencyOfLast14DaysFrom:[NSDate date]];
}

- (float)getAverageStoolFrequencyOfLast14DaysFrom:(NSDate*)fromDate
{ // in days

    //check if data has been entered for how many days 
    //if >7 
    // get all (7-14) stool trackings
    //create average for stool frequency

    NSMutableArray *timeBetweenPoops = [NSMutableArray array];
    int currentFrequency = 0;
    
    //get most days in database
    for (int i=0; i<14; i++) 
    {
        NSDate *d = [fromDate dateByAddingDays:-i];
        
        Day *day = [self getDayFromDate:d];
        
        if (day != nil) 
        {
            if(day.stool.count > 0){
                
                [timeBetweenPoops addObject:[NSNumber numberWithFloat:currentFrequency]] ;
                if(day.stool.count > 1){
                    int todayFrequency = day.stool.count/1;
                    [timeBetweenPoops addObject:[NSNumber numberWithFloat:todayFrequency]] ;
                }
                currentFrequency = 0;
            }else{
                 currentFrequency ++;
            }
        }else{
            currentFrequency ++;
        }
    }
    float daysSum = 0;
    for (NSNumber *days in timeBetweenPoops) {
        daysSum += days.intValue;
    }
    
    return daysSum/timeBetweenPoops.count;
}

- (float)getAverageStoolFrequencyOfChallenge:(Challenge*)challenge
{
    //get data of the days of the challange
    //create average for stool frequency

    NSMutableArray *timeBetweenPoops = [NSMutableArray array];
    int currentFrequency = 0;
    NSDate *d = challenge.start_date;
    int duration = challenge.duration.intValue;
    //get most days in database
    for (int i=0; i<duration; i++) 
    {
        d = [d dateByAddingDays:+i];
        
        Day *day = [self getDayFromDate:d];
        
        if (day != nil) 
        {
            if(day.stool.count > 0){
                
                [timeBetweenPoops addObject:[NSNumber numberWithFloat:currentFrequency]] ;
                if(day.stool.count > 1){
                    int todayFrequency = day.stool.count/1;
                    [timeBetweenPoops addObject:[NSNumber numberWithFloat:todayFrequency]] ;
                }
                currentFrequency = 0;
            }else{
                currentFrequency ++;
            }
        }else{
            currentFrequency ++;
        }
    }
    float daysSum = 0;
    for (NSNumber *days in timeBetweenPoops) {
        daysSum += days.intValue;
    }
    
    return daysSum/timeBetweenPoops.count;
}

- (float)getAverageStoolTypeOfLast14Days
{
    return [self getAverageStoolTypeOfLast14DaysFrom:[NSDate date]];
}

- (float)getAverageStoolTypeOfLast14DaysFrom:(NSDate*)fromDate{

    //check if data has been entered for how many days 
    //if >7 
    // get all (7-14) stool trackings
    //create average for stool type
    int stoolTypeSum   = 0;
    int stoolAmount     = 0;
    
    //get most days in database
    for (int i=0; i<14; i++) 
    {
        NSDate *d = [fromDate dateByAddingDays:-i];
        
        d = [d dateByAddingDays:-i];
        
        Day *day = [self getDayFromDate:d];
        
        if (day != nil) 
        {
            if(day.stool.count > 0){
                for (Stool *stool in day.stool) {
                    stoolTypeSum += stool.type.intValue;
                    stoolAmount ++;
                }
            }
        }
    }

    return round(stoolTypeSum/stoolAmount);
}

- (float)getAverageStoolTypeOfChallenge:(Challenge*)challenge{
    
    //get data of the days of the challange
    //create average for stool type
    
    //get data of the days of the challange
    //create average for stool frequency
    NSDate *d = challenge.start_date;
    int duration = challenge.duration.intValue;
    
    int stoolTypeSum   = 0;
    int stoolAmount     = 0;
    
    //get most days in database
    for (int i=0; i<duration; i++) 
    {
        d = [d dateByAddingDays:+i];
        
        Day *day = [self getDayFromDate:d];
        if (day != nil) 
        {
            if(day.stool.count > 0){
                for (Stool *stool in day.stool) {
                    stoolTypeSum += stool.type.intValue;
                    stoolAmount ++;
                }
            }
        }
    }
    
    return round(stoolTypeSum/stoolAmount);
}


///******************************************************************************///
// Home view requests
///******************************************************************************///
- (float) getTodaysStressPercentage{

    //get todays data
    Day *todayData = [self getDayFromDate:[NSDate date]];
    if(todayData == nil || todayData.stress == nil) return 0.0f;
    
    int stress = todayData.stress.intValue;
    float stress_percentage = stress/noOfStressValues;
    float percentage = stress_percentage;

    return percentage;
}

- (float) getTodaysSleepPercentage{

    //get todays data
    Day *todayData      = [self getDayFromDate:[NSDate date]];
    if(todayData == nil || todayData.sleep_length == nil || todayData.sleep_quality == nil) return 0.0f;
    
     //calculate percentage
    float sleeplength     = [self mapSleepLength:todayData.sleep_length.intValue];
    float sleepquality    = [self mapSleepQuality:todayData.sleep_quality.intValue];
    if(sleeplength == 0.0f && sleepquality == 0.0f)return 0.0f;
    float sleepValue = (sleepquality + sleeplength)/2;
    return sleepValue;
}

- (float)mapSleepLength:(int) sleeplength{
    
    //Sleep length:    -2, -1,-1 ,0,+1 ,+1
    if(sleeplength == 0)  return 0.0f;
    if (sleeplength == 1) return 0.15f;
    if (sleeplength == 2) return 0.4f;
    if (sleeplength == 3) return 0.8f;
    if (sleeplength == 4) return 1.0f;
    if (sleeplength == 5) return 1.0f;
    
    return 0;
    
}
- (float)mapSleepQuality:(int) sleepquality{
    //Sleep quality: 1, 2, 3, 4, 5
    
    if(sleepquality == 0) return  0.0f;
    if (sleepquality == 1) return 0.15f;
    if (sleepquality == 2) return 0.6f;
    if (sleepquality == 3) return 0.8f;
    if (sleepquality == 4) return 1.0f;
    return 0;
}

- (float) getTodaysExcersisePercentage{

    //get todays data
    Day *todayData      = [self getDayFromDate:[NSDate date]];
    if(todayData == nil || todayData.excercise == nil) return 0;
    
    //calculate percentage
    float activity = todayData.excercise.floatValue;
    if(activity == 3.0f) return 1.0f; //more
    else if(activity == 2.0f) return 0.85f; //the daily goal
    else if(activity == 0.0f) return 0.0f; //the daily goal
    return (activity+1)/4;
}

- (float) getTodaysStoolPercentage{
    
    //get todays data
    Day *todayData      = [self getDayFromDate:[NSDate date]];
    if(todayData == nil) return 0;
    
    int stooltypesum = 0;
    for (Stool *stool in todayData.stool) {
        
        if (stool.type.intValue == 6 || stool.type.intValue == 0) {
            stooltypesum += 0;
        }else if(stool.type.intValue == 5 || stool.type.intValue == 1) {
            stooltypesum += 33;
        }else if(stool.type.intValue == 4 || stool.type.intValue == 2) {
            stooltypesum += 66;
        }else if(stool.type.intValue == 3) {
            stooltypesum += 100;
        }
    }
    //calculate percentage
    /*
     1-7 = 4: ideal
     4: 100%
     3, 5: 66 %
     2, 6: 33%
     1, 7: 0%
     
     case: 1 + 7 = bad
     
     
     */
    if(todayData.stool.count == 0) return 0.0f;
    float averageStoolToday = stooltypesum/todayData.stool.count;
    return averageStoolToday/100.0f;
}

//GRAPH FUNCTIONS
+ (int)getHeightFor:(int)type andValue:(NSNumber*)value
{
    
    switch(type)
    {
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
        case EXERCISE_TYPE:
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
+(NSString*)getLabelFor:(int)type
{
    Day *todayData = [[Util instance] getDayFromDate:[NSDate date]];
    
    switch(type){
        case SLEEP_TYPE:
        {
            if(todayData == nil || todayData.sleep_quality == nil) return @"";
            
            int sleepLValue = todayData.sleep_length.intValue;
            int sleepQValue = todayData.sleep_quality.intValue;
            NSString *sleeplength = @"";
            
            if(sleepLValue == 4){        //very good
                sleeplength = @"+9";
            }else if(sleepLValue == 3){  //good
                 sleeplength = @"8";
            }else if(sleepLValue == 2){  //soso
                 sleeplength = @"7";
            }else if(sleepLValue == 1){  //poor
                 sleeplength =  @"6";
            }else if(sleepLValue == 0){  //very poor
                 sleeplength =  @"<5";
            }
            
            
            if(sleepQValue == 4){        //very good
                return [NSString stringWithFormat:@"%@ hrs very good",sleeplength];
            }else if(sleepQValue == 3){  //good
                return [NSString stringWithFormat:@"%@ hrs good",sleeplength];
            }else if(sleepQValue == 2){  //soso
                return  [NSString stringWithFormat:@"%@ hrs so-so",sleeplength];
            }else if(sleepQValue == 1){  //poor
                return  [NSString stringWithFormat:@"%@ hrs poor",sleeplength];
            }else if(sleepQValue == 0){  //very poor
                return  [NSString stringWithFormat:@"%@ hrs very poor",sleeplength];
            }
        }
        case STRESS_TYPE:
        {
            if(todayData == nil || todayData.stress == nil) return @"";
            
            int stressValue = todayData.stress.intValue;
            
            if(stressValue  == 0){        //very stressed 
                return @"extremely";
            }else if(stressValue  == 1){  //stressed 
                return @"very";
            }else if(stressValue  == 2){  //gloomy
                return @"quite";
            }else if(stressValue  == 3){  //relaxed
                return @"a little";
            }else if(stressValue  == 4){  //very relaxed
                return @"not at all";
            }
        }
        case EXERCISE_TYPE:
        {
            if(todayData == nil || todayData.excercise == nil) return @"";
            
            int activityValue = todayData.excercise.intValue;
            
            if(activityValue == 3){        //more!
                return @"more!";
            }else if(activityValue == 2){  //daily goal
                return @"daily goal";
            }else if(activityValue == 1){  //a little
                return @"a little";
            }else if(activityValue == 0){   //none
                return @"zero";
            }
        }
        case STOOL_TYPE:
        {
            if(todayData == nil || todayData.stool == nil) return @"";
            
            NSSet *stoolValues = todayData.stool;
            int stoolnr = [stoolValues count];

            int allstoolvalues = 0;
            
            for (Stool *stool in stoolValues) {
                allstoolvalues += [[stool type] intValue];
            }
            if(allstoolvalues == 0 || stoolnr == 0) return @"";
            int averageStoolvalue = (int)round(allstoolvalues/stoolnr);
     
            return  [NSString stringWithFormat:@"%d/%d",averageStoolvalue, stoolnr];
        }
        default:
            return @"";
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
        case EXERCISE_TYPE:
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
  

+(int)getStoolTrendfor2WeeksStarting:(NSDate*)startDate{
    
    //14 days
    //get average stooltype
    float avType1 = [[Util instance] getAverageStoolTypeOfLast14DaysFrom:startDate];
    //get average stooltime
    float avFreq1 = [[Util instance] getAverageStoolFrequencyOfLast14DaysFrom:startDate];
    
    //14 days before
    //get average stooltype
    float avType2 = [[Util instance] getAverageStoolTypeOfLast14DaysFrom:[startDate dateByAddingDays:-14]];
    //get average stooltime
    float avFreq2 = [[Util instance] getAverageStoolFrequencyOfLast14DaysFrom:[startDate dateByAddingDays:-14]];
    
    
    
    if(avType1 == avType2){ //same
        
    }else if(avType1 > avType2){
        if (avType1 <= 4){ //constipation
                //better
        }else if(avType1 > 4){ //diarreah
            //worse
        }
    }else if(avType1 < avType2){
        if (avType1 >= 4){ //diarreah
            //better
        }else if(avType1 < 4){ //constipated
            //worse
        }
    }
    
  /*  if(avFreq1 == avFreq2) {//same
    }else if (avFreq1 > 3){ // diarreah
        if (avFreq1 < avType2){ //better (less diarreah)
        }else if(avType1 > avType2){// worse (more diarreah)
        }
    }else if(avType1 < 4){
                    if (avType1 < avType2) //better 
                        if(avType1 > avType2)// worse
                            }*/
    
    return 55;
    
}
+(int)getPercentageTrackedfor2WeeksStarting:(NSDate*)startDate{

    int daysTracked    = 0;
    
    //get most days in database
    for (int i=0; i<14; i++) 
    {
        NSDate *d = [startDate dateByAddingDays:-i];
        
        d = [d dateByAddingDays:-i];
        
        Day *day = [[Util instance] getDayFromDate:d];
        
        if (day != nil)   daysTracked ++;
    }
    
    return round(daysTracked/14);

}
+ (void)resizeFontForLabel:(UILabel*)aLabel maxSize:(int)maxSize minSize:(int)minSize { 
    // use font from provided label so we don't lose color, style, etc
    UIFont *font = aLabel.font;
    
    // start with maxSize and keep reducing until it doesn't clip
    for(int i = maxSize; i >= minSize; i--) {
        font = [font fontWithSize:i];
        CGSize constraintSize = CGSizeMake(aLabel.frame.size.width, MAXFLOAT);
        
        // This step checks how tall the label would be with the desired font.
        CGSize labelSize = [aLabel.text sizeWithFont:font constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
        if(labelSize.height <= aLabel.frame.size.height)
            break;
    }
    // Set the UILabel's font to the newly adjusted font.
    aLabel.font = font;
}
@end
