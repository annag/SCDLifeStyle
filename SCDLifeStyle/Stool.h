//
//  Stool.h
//  SCDLifeStyle
//
//  Created by Juan Fluxa on 5/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Day;

@interface Stool : NSManagedObject

@property (nonatomic, retain) NSNumber * index;
@property (nonatomic, retain) NSDate * time;
@property (nonatomic, retain) Day *day;

@end
