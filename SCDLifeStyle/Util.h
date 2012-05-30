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

@interface Util : NSObject

//static
+ (Util*)instance;
+ (NSString*) dayIdFromDate:(NSDate*)date;
+ (NSString*) dayIdToday;
+ (NSString*) todayPretty;
+ (NSString*) timePretty:(NSDate*)date;

//properties
@property(nonatomic,strong) NSManagedObjectContext *managedObjectContext;

//public
- (Day*) getDayFromDate:(NSDate*)date;
- (NSArray*) getChallenges;

@end
