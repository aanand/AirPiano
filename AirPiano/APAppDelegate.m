//
//  APAppDelegate.m
//  AirPiano
//
//  Created by Aanand Prasad on 26/02/2013.
//  Copyright (c) 2013 Aanand Prasad. All rights reserved.
//

#import "APAppDelegate.h"
#import "FingertipListener.h"

@interface APAppDelegate () <FingertipListenerDelegate>
@end

@implementation APAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    FingertipListener *listener = [[FingertipListener alloc]init];
	listener.delegate = self;
    [listener run];
}

-(void)fingertipListener:(FingertipListener *)listener didDetectFingertipsAtPositions:(NSArray *)positions
{
	NSLog(@"fingertips: %@", [positions componentsJoinedByString:@", "]);
}

@end
