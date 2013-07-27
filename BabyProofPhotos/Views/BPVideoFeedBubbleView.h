//
//  BPVideoFeedBubbleView.h
//  BabyProofPhotos
//
//  Created by Onsi Fakhouri on 7/26/13.
//  Copyright (c) 2013 Onsi Fakhouri. All rights reserved.
//

#import "BPTappableCircularView.h"

@interface BPVideoFeedBubbleView : BPTappableCircularView

#pragma mark - Adding and removing the video feed
- (void)installVideoFeedLayer:(CALayer *)videoFeedLayer;
- (void)removeVideoFeedLayer;

#pragma mark - Animations
- (void)expandToFillSuperviewWithDuration:(NSTimeInterval)duration;

@end
