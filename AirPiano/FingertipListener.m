/******************************************************************************\
* Copyright (C) 2012-2013 Leap Motion, Inc. All rights reserved.               *
* Leap Motion proprietary and confidential. Not for distribution.              *
* Use subject to the terms of the Leap Motion SDK Agreement available at       *
* https://developer.leapmotion.com/sdk_agreement, or another agreement         *
* between Leap Motion and you, your company or other organization.             *
\******************************************************************************/

#import "FingertipListener.h"

@implementation FingertipListener
{
	BOOL lastFrameWasEmpty;
    LeapController *controller;
}

@synthesize delegate;

- (void)run
{
	lastFrameWasEmpty = NO;
    controller = [[LeapController alloc] init];
    [controller addListener:self];
    NSLog(@"running");
    [[NSRunLoop currentRunLoop] run]; // required for performSelectorOnMainThread:withObject
}

#pragma mark - SampleListener Callbacks

- (void)onInit:(NSNotification *)notification
{
    NSLog(@"Initialized");
}

- (void)onConnect:(NSNotification *)notification;
{
    NSLog(@"Connected");
    LeapController *aController = (LeapController *)[notification object];
    [aController enableGesture:LEAP_GESTURE_TYPE_CIRCLE enable:YES];
    [aController enableGesture:LEAP_GESTURE_TYPE_KEY_TAP enable:YES];
    [aController enableGesture:LEAP_GESTURE_TYPE_SCREEN_TAP enable:YES];
    [aController enableGesture:LEAP_GESTURE_TYPE_SWIPE enable:YES];
}

- (void)onDisconnect:(NSNotification *)notification;
{
    NSLog(@"Disconnected");
}

- (void)onExit:(NSNotification *)notification;
{
    NSLog(@"Exited");
}

- (void)onFrame:(NSNotification *)notification;
{
    LeapController *aController = (LeapController *)[notification object];
    LeapFrame *frame = [aController frame:0];

	NSMutableArray *positions = [NSMutableArray array];

	for (LeapHand *hand in frame.hands) {
		for (LeapFinger *finger in hand.fingers) {
			[positions addObject:finger.tipPosition];
		}
	}
	
	if (positions.count == 0 && lastFrameWasEmpty) {
		// do nothing; no point sending multiple "no fingertips" messages
	} else {
		[self.delegate fingertipListener:self didDetectFingertipsAtPositions:positions];
	}
	
	lastFrameWasEmpty = (positions.count == 0);
}

+ (NSString *)stringForState:(LeapGestureState)state
{
    switch (state) {
        case LEAP_GESTURE_STATE_INVALID:
            return @"STATE_INVALID";
        case LEAP_GESTURE_STATE_START:
            return @"STATE_START";
        case LEAP_GESTURE_STATE_UPDATE:
            return @"STATE_UPDATED";
        case LEAP_GESTURE_STATE_STOP:
            return @"STATE_STOP";
        default:
            return @"STATE_INVALID";
    }
}

@end
