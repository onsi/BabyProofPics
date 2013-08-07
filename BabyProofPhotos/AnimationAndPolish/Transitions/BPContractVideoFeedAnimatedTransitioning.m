//
//  BPContractVideoFeedAnimatedTransitioning.m
//  BabyProofPhotos
//
//  Created by Onsi Fakhouri on 8/1/13.
//  Copyright (c) 2013 Onsi Fakhouri. All rights reserved.
//

#import "BPContractVideoFeedAnimatedTransitioning.h"
#import "BPVideoFeedBubbleView.h"
#import "BPFullScreenVideoFeedViewController.h"
#import "BPBreezyBubblesSimulator.h"

@interface BPContractVideoFeedAnimatedTransitioning ()

@property (nonatomic, strong) BPVideoFeedBubbleView *videoFeedBubble;
@property (nonatomic, strong) BPBreezyBubblesSimulator *breezyBubblesSimulator;
@property (nonatomic, assign) NSTimeInterval transitionDuration;
@property (nonatomic, assign) CGSize contractedSize;
@property (nonatomic, assign) CGPoint contractedCenter;

@end


@implementation BPContractVideoFeedAnimatedTransitioning

- (instancetype)initWithVideoFeedBubble:(BPVideoFeedBubbleView *)videoFeedBubble
                              simulator:(BPBreezyBubblesSimulator *)breezyBubblesSimulator
                         contractedSize:(CGSize)contractedSize
                       contractedCenter:(CGPoint)contractedCenter
{
    self = [super init];
    
    if (self) {
        self.videoFeedBubble = videoFeedBubble;
        self.breezyBubblesSimulator = breezyBubblesSimulator;
        self.transitionDuration = 1.5;
        self.contractedSize = contractedSize;
        self.contractedCenter = contractedCenter;
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
    BPFullScreenVideoFeedViewController *fullScreenController = (BPFullScreenVideoFeedViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *homeViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    CALayer *videoFeedLayer = [fullScreenController removeVideoFeedLayer];
    [self.videoFeedBubble installVideoFeedLayer:videoFeedLayer];

    [fullScreenController.view removeFromSuperview];
    homeViewController.view.frame = [transitionContext finalFrameForViewController:homeViewController];
    [containerView addSubview:homeViewController.view];
    
    [self.videoFeedBubble contractToSize:self.contractedSize
                                  center:self.contractedCenter
                            withDuration:self.transitionDuration
                              completion:^{
                                  [transitionContext completeTransition:YES];
                                  [self.breezyBubblesSimulator addBreezyItem:self.videoFeedBubble centeredAt:self.videoFeedBubble.center];
     }];
}

@end
