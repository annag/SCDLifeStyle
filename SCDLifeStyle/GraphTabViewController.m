//
//  GraphTabViewController.m
//  SCDLifeStyle
//
//  Created by Juan Fluxa on 5/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GraphTabViewController.h"

@interface GraphTabViewController ()

@end

@implementation GraphTabViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
	
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (!animated) {
        [self performSegueWithIdentifier:@"Graph" sender:self];
    }
}

@end
