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

@synthesize stool = _stool;
@synthesize imageView,titleLabel;

- (void) setStool:(Stool *)stool
{
    _stool = stool;
    
    UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"poo%d.png",[stool.index intValue]]];
    self.imageView.image = img;
    self.titleLabel.text = [Util timePretty:stool.time];
    
}

@end
