//
//  APAppDelegate.m
//  AirPiano
//
//  Created by Aanand Prasad on 26/02/2013.
//  Copyright (c) 2013 Aanand Prasad. All rights reserved.
//

#import "APAppDelegate.h"
#import "Sample.h"

@implementation APAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    Sample *sample = [[Sample alloc]init];
    [sample run];
}

@end
