//
//  BPExpandVideoFeedAnimatedTransitioning.m
//  BabyProofPhotos
//
//  Created by Onsi Fakhouri on 7/29/13.
//  Copyright (c) 2013 Onsi Fakhouri. All rights reserved.
//

#import "BPExpandVideoFeedAnimatedTransitioning.h"
#import "BPVideoFeedBubbleView.h"
#import "BPFullScreenVideoFeedViewController.h"
#import "BPBreezyBubblesSimulator.h"
#import "BPMath.h"

@interface BPExpandVideoFeedAnimatedTransitioning ()

@property (nonatomic, strong) BPVideoFeedBubbleView *videoFeedBubble;
@property (nonatomic, strong) BPBreezyBubblesSimulator *breezyBubblesSimulator;
@property (nonatomic, assign) NSTimeInterval transitionDuration;

@end

@implementation BPExpandVideoFeedAnimatedTransitioning

- (instancetype)initWithVideoFeedBubble:(BPVideoFeedBubbleView *)videoFeedBubble
                              simulator:(BPBreezyBubblesSimulator *)breezyBubblesSimulator
{
    self = [super init];
    
    if (self) {
        self.videoFeedBubble = videoFeedBubble;
        self.breezyBubblesSimulator = breezyBubblesSimulator;
        self.transitionDuration = 2.0;
    }
    
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return self.transitionDuration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView *containerView = transitionContext.containerView;
    BPFullScreenVideoFeedViewController *fullScreenController = (BPFullScreenVideoFeedViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    [self.breezyBubblesSimulator removeBreezyItem:self.videoFeedBubble];
    
    [UIView animateWithDuration:self.transitionDuration
                     animations:^{
                         [self.videoFeedBubble expandToFillSuperviewWithDuration:self.transitionDuration];
                     } completion:^(BOOL finished) {
                         fullScreenController.view.frame = [transitionContext finalFrameForViewController:fullScreenController];
                         [containerView addSubview:fullScreenController.view];
                         
                         CALayer *videoFeedLayer = [self.videoFeedBubble removeVideoFeedLayer];
                         [fullScreenController installVideoFeedLayer:videoFeedLayer];
                         
                         [transitionContext completeTransition:YES];
                     }];
}

@end
