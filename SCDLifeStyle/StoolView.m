//
//  StoolView.m
//  SCDLifeStyle
//
//  Created by Juan Fluxa on 5/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "StoolView.h"
#import "Util.h"

@implementation StoolView

@synthesize delegate;
@synthesize stool = _stool;
@synthesize imageView,titleLabel;

- (void) setStool:(Stool *)stool
{
    _stool = stool;
    
    int stoolType = [stool.index intValue]+1;
    UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"poo%d.png",stoolType]];
    self.imageView.image = img;
    self.titleLabel.text = [NSString stringWithFormat:@"Time: %@ - Type %d",[Util timePretty:stool.time],stoolType];
    
}

- (IBAction)onDelete:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(onStoolViewDelete:)]) 
    {
        [self.delegate onStoolViewDelete:self.stool];
    }
}

@end
