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

@interface BPHomeViewController ()

@property (nonatomic, weak) IBOutlet BPTappableCircularView *videoFeedContainer;
@property (nonatomic, strong) CALayer *videoFeedLayer;

@end

@implementation BPHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpTapHandlers];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self setUpVideoFeed];
}

#pragma mark - View SetUp

- (void)setUpVideoFeed
{
    [self.videoFeedLayer removeFromSuperlayer];

    self.videoFeedLayer = [[BPVideoFeedProvider provider] videoFeedLayer];
    CGFloat height = self.videoFeedContainer.bounds.size.height;
    CGFloat width = height * 1024.0 / 768.0;
    self.videoFeedLayer.frame = CGRectMake(0,0,width,height);
    [self.videoFeedContainer.layer addSublayer:self.videoFeedLayer];
}

- (void)setUpTapHandlers
{
    [self.videoFeedContainer setTapTarget:self action:@selector(didTapVideoFeed:)];
}

- (void)didTapVideoFeed:(BPTappableCircularView *)view
{
    BPFullScreenVideoFeedViewController *fullScreenVideoFeedController = [BPFullScreenVideoFeedViewController new];
    [self.navigationController pushViewController:fullScreenVideoFeedController
                                         animated:YES];
}

@end
