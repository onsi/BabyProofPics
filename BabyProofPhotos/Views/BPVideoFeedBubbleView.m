//
//  BPVideoFeedBubbleView.m
//  BabyProofPhotos
//
//  Created by Onsi Fakhouri on 7/26/13.
//  Copyright (c) 2013 Onsi Fakhouri. All rights reserved.
//

#import "BPVideoFeedBubbleView.h"
#import "BPMath.h"

@interface BPVideoFeedBubbleView ()

@property (nonatomic, strong) CALayer *videoFeedLayer;

@end

@implementation BPVideoFeedBubbleView

#pragma mark - Adding and removing the video feed

- (void)installVideoFeedLayer:(CALayer *)videoFeedLayer
{
    self.videoFeedLayer = videoFeedLayer;
    [self.videoFeedLayer removeFromSuperlayer];
    CGFloat height = self.bounds.size.height;
    CGFloat width = height * 4.0 / 3.0;
    self.videoFeedLayer.frame = CGRectMake(0,0,width,height);
    [self.contentView.layer addSublayer:self.videoFeedLayer];
}

- (void)removeVideoFeedLayer
{
    [self.videoFeedLayer removeFromSuperlayer];
    self.videoFeedLayer = nil;
}

- (void)expandToFillSuperviewWithDuration:(NSTimeInterval)duration
{
    [UIView animateWithDuration:duration animations:^{
        [self expandToFillSuperviewAndStraighenCornersWithDuration:duration];
        [self centerAndExpandVideoFeedLayerWithDuration:duration];
    }];
}

- (CGRect)expandedBounds
{
    return self.superview.bounds;
}

- (void)expandToFillSuperviewAndStraighenCornersWithDuration:(NSTimeInterval)duration
{
    CABasicAnimation *cornerRadius = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    cornerRadius.toValue = 0;
    
    CABasicAnimation *bounds = [CABasicAnimation animationWithKeyPath:@"bounds"];
    bounds.toValue = [NSValue valueWithCGRect:self.expandedBounds];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[cornerRadius, bounds];
    group.duration = duration;

    [self.contentView.layer addAnimation:group forKey:@"expandToFill"];
    self.contentView.layer.cornerRadius = 0;
    self.contentView.layer.bounds = self.expandedBounds;
}

- (void)centerAndExpandVideoFeedLayerWithDuration:(NSTimeInterval)duration
{
    CABasicAnimation *bounds = [CABasicAnimation animationWithKeyPath:@"bounds"];
    bounds.toValue = [NSValue valueWithCGRect:self.expandedBounds];
    
    CGPoint expandedCenter = CGPointAtCenterOfRect(self.expandedBounds);

    CABasicAnimation *position = [CABasicAnimation animationWithKeyPath:@"position"];
    position.toValue = [NSValue valueWithCGPoint:expandedCenter];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[bounds, position];
    group.duration = duration;
    
    [self.videoFeedLayer addAnimation:group forKey:@"expandToFill"];
    
    self.videoFeedLayer.bounds = self.expandedBounds;
    self.videoFeedLayer.position = expandedCenter;
}

@end
