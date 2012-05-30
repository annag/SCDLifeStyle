//
//  Note.h
//  SCDLifeStyle
//
//  Created by Juan Fluxa on 5/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Note : NSManagedObject

@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSDate * added;

@end
