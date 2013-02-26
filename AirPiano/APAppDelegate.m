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

@property (strong, nonatomic) NSArray *keys;
@property (strong, nonatomic) NSArray *yRange;

@end

@implementation APAppDelegate

@synthesize keys, yRange;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	self.keys = @[
  @{ @"x": @[@-100, @0], @"note": @0 },
  @{ @"x": @[@0, @100], @"note": @1 }
  ];

    self.yRange = @[@100, @200];
	
	FingertipListener *listener = [[FingertipListener alloc]init];
	listener.delegate = self;
    [listener run];
}

-(void)fingertipListener:(FingertipListener *)listener didDetectFingertipsAtPositions:(NSArray *)positions
{
	NSMutableSet *notes = [NSMutableSet set];
	
	NSNumber *yMin = [yRange objectAtIndex:0];
	NSNumber *yMax = [yRange objectAtIndex:1];
	
	for (NSDictionary *key in self.keys) {
		for (LeapVector *position in positions) {
			NSArray *xRange = [key objectForKey:@"x"];
			NSNumber *xMin = [xRange objectAtIndex:0];
			NSNumber *xMax = [xRange objectAtIndex:1];

			if (position.x >= xMin.floatValue && position.x <= xMax.floatValue &&
				position.y >= yMin.floatValue && position.y <= yMax.floatValue) {
				[notes addObject:[key objectForKey:@"note"]];
			}
		}
	}
	
	if (notes.count > 0) {
		NSLog(@"notes = %@", notes);
	}
}

@end
