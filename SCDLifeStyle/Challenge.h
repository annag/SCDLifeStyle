//
//  Challenge.h
//  SCDLifeStyle
//
//  Created by Juan Fluxa on 6/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Note;

@interface Challenge : NSManagedObject

@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSNumber * duration;
@property (nonatomic, retain) NSDate * end_date;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * start_date;
@property (nonatomic, retain) NSNumber * started;
@property (nonatomic, retain) NSNumber * finished;
@property (nonatomic, retain) NSSet *note;
@end

@interface Challenge (CoreDataGeneratedAccessors)

- (void)addNoteObject:(Note *)value;
- (void)removeNoteObject:(Note *)value;
- (void)addNote:(NSSet *)values;
- (void)removeNote:(NSSet *)values;

@end
