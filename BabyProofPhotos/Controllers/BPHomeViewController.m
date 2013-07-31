//
//  BPHomeViewController.m
//  BabyProofPhotos
//
//  Created by Onsi Fakhouri on 7/16/13.
//  Copyright (c) 2013 Onsi Fakhouri. All rights reserved.
//

#import "BPHomeViewController.h"
#import "BPVideoFeedBubbleView.h"
#import "BPVideoFeedProvider.h"
#import "BPFullScreenVideoFeedViewController.h"
#import "BPBreezyBubblesSimulator.h"
#import "BPExpandVideoFeedAnimatedTransitioning.h"

@interface BPHomeViewController ()

@property (nonatomic, weak) IBOutlet BPVideoFeedBubbleView *videoFeedBubble;
@property (nonatomic, strong) CALayer *videoFeedLayer;
@property (nonatomic, strong) BPBreezyBubblesSimulator *breezyBubblesSimulator;

@end

@implementation BPHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.delegate = self;
    [self setUpTapHandlers];
    [self setUpVideoFeed];
    [self setUpBreezyBubblesSimulator];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.videoFeedBubble installVideoFeedLayer:self.videoFeedLayer];
}

#pragma mark - View SetUp

- (void)setUpVideoFeed
{
    self.videoFeedLayer = [[BPVideoFeedProvider provider] videoFeedLayer];
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
    }
    return nil;
}

@end
