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

@interface BPHomeViewController ()

@property (nonatomic, weak) IBOutlet BPVideoFeedBubbleView *videoFeedBubble;
@property (nonatomic, strong) CALayer *videoFeedLayer;
@property (nonatomic, strong) BPBreezyBubblesSimulator *breezyBubblesSimulator;

@end

@implementation BPHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
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
        self.breezyBubblesSimulator = [[BPBreezyBubblesSimulator alloc] initWithReferenceFrame:self.view
                                                                                         views:@[self.videoFeedBubble]];
    }
}

#pragma mark - Tap Handlers

- (void)didTapVideoFeedBubble:(BPTappableCircularView *)view
{
    BPFullScreenVideoFeedViewController *fullScreenVideoFeedController = [[BPFullScreenVideoFeedViewController alloc] initWithVideoFeedLayer:self.videoFeedLayer];
    [self.navigationController pushViewController:fullScreenVideoFeedController
                                         animated:YES];
}

@end
