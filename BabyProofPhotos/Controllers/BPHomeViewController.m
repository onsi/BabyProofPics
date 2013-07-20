//
//  BPHomeViewController.m
//  BabyProofPhotos
//
//  Created by Onsi Fakhouri on 7/16/13.
//  Copyright (c) 2013 Onsi Fakhouri. All rights reserved.
//

#import "BPHomeViewController.h"
#import "BPVideoFeedProvider.h"
#import "BPTappableCircularView.h"
#import "BPFullScreenVideoFeedViewController.h"
#import "BPBreezyBubblesSimulator.h"

@interface BPHomeViewController ()

@property (nonatomic, weak) IBOutlet BPTappableCircularView *videoFeedContainer;
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
    [self installVideoFeed];
}

#pragma mark - View SetUp

- (void)setUpVideoFeed
{
    self.videoFeedLayer = [[BPVideoFeedProvider provider] videoFeedLayer];
}

- (void)installVideoFeed
{
    [self.videoFeedLayer removeFromSuperlayer];
    CGFloat height = self.videoFeedContainer.bounds.size.height;
    CGFloat width = height * 4.0 / 3.0;
    self.videoFeedLayer.frame = CGRectMake(0,0,width,height);
    [self.videoFeedContainer.layer addSublayer:self.videoFeedLayer];
}

- (void)setUpTapHandlers
{
    [self.videoFeedContainer setTapTarget:self action:@selector(didTapVideoFeed:)];
}

- (void)setUpBreezyBubblesSimulator
{
    if (NSClassFromString(@"UIDynamicAnimator")) {
        self.breezyBubblesSimulator = [[BPBreezyBubblesSimulator alloc] initWithReferenceFrame:self.view
                                                                                         views:@[self.videoFeedContainer]];
    }
}

#pragma mark - Tap Handlers

- (void)didTapVideoFeed:(BPTappableCircularView *)view
{
    BPFullScreenVideoFeedViewController *fullScreenVideoFeedController = [[BPFullScreenVideoFeedViewController alloc] initWithVideoFeedLayer:self.videoFeedLayer];
    [self.navigationController pushViewController:fullScreenVideoFeedController
                                         animated:YES];
}

@end
