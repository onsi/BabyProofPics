//
//  BPContractVideoFeedAnimatedTransitioning.h
//  BabyProofPhotos
//
//  Created by Onsi Fakhouri on 8/1/13.
//  Copyright (c) 2013 Onsi Fakhouri. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BPVideoFeedBubbleView, BPBreezyBubblesSimulator;

@interface BPContractVideoFeedAnimatedTransitioning : NSObject <UIViewControllerAnimatedTransitioning>

- (instancetype)initWithVideoFeedBubble:(BPVideoFeedBubbleView *)videoFeedBubble
                              simulator:(BPBreezyBubblesSimulator *)breezyBubblesSimulator
                         contractedSize:(CGSize)contractedSize
                       contractedCenter:(CGPoint)contractedCenter;

@end
