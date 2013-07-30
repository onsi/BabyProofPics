//
//  BPExpandVideoFeedAnimatedTransitioning.h
//  BabyProofPhotos
//
//  Created by Onsi Fakhouri on 7/29/13.
//  Copyright (c) 2013 Onsi Fakhouri. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BPVideoFeedBubbleView;

@interface BPExpandVideoFeedAnimatedTransitioning : NSObject <UIViewControllerAnimatedTransitioning>

- (instancetype)initWithVideoFeedBubble:(BPVideoFeedBubbleView *)videoFeedBubble;

@end
