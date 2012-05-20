//
//  Day.h
//  SCDLifeStyle
//
//  Created by Juan Fluxa on 5/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Stool;

@interface Day : NSManagedObject

@property (nonatomic, retain) NSString * day_id;
@property (nonatomic, retain) NSNumber * excercise;
@property (nonatomic, retain) NSNumber * sleep_length;
@property (nonatomic, retain) NSNumber * sleep_quality;
@property (nonatomic, retain) NSNumber * stress;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) Stool *stools;

@end
