//
//  BPHomeViewController.m
//  BabyProofPhotos
//
//  Created by Onsi Fakhouri on 7/16/13.
//  Copyright (c) 2013 Onsi Fakhouri. All rights reserved.
//

#import "BPHomeViewController.h"
#import "BPRandomColorView.h"
#import "BPVideoFeedBubbleView.h"
#import "BPVideoFeedProvider.h"
#import "BPFullScreenVideoFeedViewController.h"
#import "BPBreezyBubblesSimulator.h"
#import "BPMath.h"
#import "BPSizer.h"

#import "BPExpandVideoFeedAnimatedTransitioning.h"
#import "BPContractVideoFeedAnimatedTransitioning.h"

@interface BPHomeViewController ()

@property (nonatomic, strong) BPVideoFeedBubbleView *videoFeedBubble;
@property (nonatomic, strong) CALayer *videoFeedLayer;
@property (nonatomic, strong) BPBreezyBubblesSimulator *breezyBubblesSimulator;

@property (nonatomic, assign) CGSize videoFeedBubbleSize;
@property (nonatomic, assign) CGPoint videoFeedBubbleCenter;

@end

@implementation BPHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    self.navigationController.delegate = self;
    [self setUpVideoFeedBubble];
    [self setUpTapHandlers];
    [self setUpRandomColorBackground];
    [self setUpBreezyBubblesSimulator];
}

#pragma mark - View SetUp

- (void)setUpVideoFeedBubble
{
    self.videoFeedBubbleSize = [BPSizer videoFeedBubbleSize];
    self.videoFeedBubbleCenter = [BPSizer videoFeedBubbleCenter];
    self.videoFeedBubble = [[BPVideoFeedBubbleView alloc] initWithFrame:CGRectMakeWithCenterAndSize(self.videoFeedBubbleCenter, self.videoFeedBubbleSize)];
    [self.view addSubview:self.videoFeedBubble];

    self.videoFeedLayer = [[BPVideoFeedProvider provider] videoFeedLayer];
    [self.videoFeedBubble installVideoFeedLayer:self.videoFeedLayer];
}

- (void)setUpRandomColorBackground
{
    BPRandomColorView *randomColorView =[[BPRandomColorView alloc] initWithFrame:self.view.bounds];
    [self.view insertSubview:randomColorView atIndex:0];
}

- (void)setUpTapHandlers
{
    [self.videoFeedBubble setTapTarget:self action:@selector(didTapVideoFeedBubble:)];
}

- (void)setUpBreezyBubblesSimulator
{
    if (NSClassFromString(@"UIDynamicAnimator")) {
        self.breezyBubblesSimulator = [[BPBreezyBubblesSimulator alloc] initWithReferenceFrame:self.view];
        [self.breezyBubblesSimulator addBreezyItem:self.videoFeedBubble
                                        centeredAt:self.videoFeedBubble.center];
    }
}

#pragma mark - Tap Handlers

- (void)didTapVideoFeedBubble:(BPTappableCircularView *)view
{
    BPFullScreenVideoFeedViewController *fullScreenVideoFeedController = [BPFullScreenVideoFeedViewController new];
    [self.navigationController pushViewController:fullScreenVideoFeedController
                                         animated:YES];
}

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPush && [toVC isKindOfClass:[BPFullScreenVideoFeedViewController class]]) {
        return [[BPExpandVideoFeedAnimatedTransitioning alloc] initWithVideoFeedBubble:self.videoFeedBubble
                                                                             simulator:self.breezyBubblesSimulator];
    } else if (operation == UINavigationControllerOperationPop && [fromVC isKindOfClass:[BPFullScreenVideoFeedViewController class]]) {
        return [[BPContractVideoFeedAnimatedTransitioning alloc] initWithVideoFeedBubble:self.videoFeedBubble
                                                                               simulator:self.breezyBubblesSimulator
                                                                          contractedSize:self.videoFeedBubbleSize
                                                                        contractedCenter:self.videoFeedBubbleCenter];
    }
    return nil;
}

@end
