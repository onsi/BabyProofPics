//
//  BPFullScreenVideoFeedViewController.m
//  BabyProofPhotos
//
//  Created by Onsi Fakhouri on 7/17/13.
//  Copyright (c) 2013 Onsi Fakhouri. All rights reserved.
//

#import "BPFullScreenVideoFeedViewController.h"

@interface BPFullScreenVideoFeedViewController ()

@property (nonatomic, strong) CALayer *videoFeedLayer;

@end

@implementation BPFullScreenVideoFeedViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpGestureRecognizers];
}

- (void)installVideoFeedLayer:(CALayer *)layer;
{
    self.videoFeedLayer = layer;
    self.videoFeedLayer.frame = self.view.bounds;
    [self.view.layer addSublayer:self.videoFeedLayer];
}

- (void)setUpGestureRecognizers
{
    UISwipeGestureRecognizer *swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipe:)];
    swipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:swipeGestureRecognizer];
}

- (void)didSwipe:(UISwipeGestureRecognizer *)swipeGestureRecognizer
{
    CGPoint swipeStartLocation = [swipeGestureRecognizer locationInView:self.view];
    CGFloat viewHeight = self.view.bounds.size.height;
    if ((swipeStartLocation.y / viewHeight) > 0.8) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
