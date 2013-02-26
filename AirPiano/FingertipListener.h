/******************************************************************************\
* Copyright (C) 2012-2013 Leap Motion, Inc. All rights reserved.               *
* Leap Motion proprietary and confidential. Not for distribution.              *
* Use subject to the terms of the Leap Motion SDK Agreement available at       *
* https://developer.leapmotion.com/sdk_agreement, or another agreement         *
* between Leap Motion and you, your company or other organization.             *
\******************************************************************************/

#import <Foundation/Foundation.h>
#import "LeapObjectiveC.h"

@class FingertipListener;

@protocol FingertipListenerDelegate <NSObject>

-(void)fingertipListener:(FingertipListener *)listener didDetectFingertipsAtPositions:(NSArray *)positions;

@end

@interface FingertipListener : NSObject<LeapListener>

@property (weak, nonatomic) id<FingertipListenerDelegate> delegate;

-(void)run;

@end
