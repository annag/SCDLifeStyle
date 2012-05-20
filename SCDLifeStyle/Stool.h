//
//  Stool.h
//  SCDLifeStyle
//
//  Created by Juan Fluxa on 5/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Stool : NSManagedObject

@property (nonatomic, retain) NSNumber * index;
@property (nonatomic, retain) NSDate * time;
@property (nonatomic, retain) NSString * day_id;

@end
