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
@property (nonatomic, assign) CGRect contractedBounds;

@end

@implementation BPVideoFeedBubbleView

#pragma mark - Adding and removing the video feed

- (void)installVideoFeedLayer:(CALayer *)videoFeedLayer
{
    self.videoFeedLayer = videoFeedLayer;
    [self.videoFeedLayer removeFromSuperlayer];
    
    self.videoFeedLayer.anchorPoint = CGPointMake(0,0);
    self.videoFeedLayer.position = CGPointMake(0, 0);

    CGFloat height = self.bounds.size.height;
    CGFloat width = height * 4.0 / 3.0;
    self.videoFeedLayer.bounds = CGRectMake(0,0,width,height);
    [self.contentView.layer addSublayer:self.videoFeedLayer];
}

- (CALayer *)removeVideoFeedLayer
{
    CALayer *layer = self.videoFeedLayer;
    [self.videoFeedLayer removeFromSuperlayer];
    self.videoFeedLayer = nil;
    return layer;
}

#pragma mark - Animation

- (void)expandToFillSuperviewWithDuration:(NSTimeInterval)duration
{
    self.contractedBounds = self.bounds;
    [self expandToFillSuperviewAndStraighenCornersWithDuration:duration];
    [self centerAndExpandVideoFeedLayerWithDuration:duration];
}

- (void)contractWithDuration:(NSTimeInterval)duration
{
    [self contractAndCircularizeWithDuration:duration];
    [self contractVideoFeedLayerWithDuration:duration];
}

#pragma mark - Expansion

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
    group.animations = @[bounds, cornerRadius];
    group.duration = duration;

    [self.contentView.layer addAnimation:group forKey:@"expandToFill"];
    self.contentView.layer.cornerRadius = 0;
    self.contentView.layer.bounds = self.expandedBounds;
}

- (void)centerAndExpandVideoFeedLayerWithDuration:(NSTimeInterval)duration
{
    CABasicAnimation *bounds = [CABasicAnimation animationWithKeyPath:@"bounds"];
    bounds.toValue = [NSValue valueWithCGRect:self.expandedBounds];
    bounds.duration = duration;

    [self.videoFeedLayer addAnimation:bounds forKey:@"expandToFill"];
    self.videoFeedLayer.bounds = self.expandedBounds;
}

#pragma mark - Contraction

- (void)contractAndCircularizeWithDuration:(NSTimeInterval)duration
{
    CABasicAnimation *cornerRadius = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    cornerRadius.toValue = @(self.contractedBounds.size.width / 2.0);
    
    CABasicAnimation *bounds = [CABasicAnimation animationWithKeyPath:@"bounds"];
    bounds.toValue = [NSValue valueWithCGRect:self.contractedBounds];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[bounds, cornerRadius];
    group.duration = duration;
    
    [self.contentView.layer addAnimation:group forKey:@"contract"];
    self.contentView.layer.cornerRadius = [cornerRadius.toValue floatValue];
    self.contentView.layer.bounds = self.contractedBounds;
}

- (void)contractVideoFeedLayerWithDuration:(NSTimeInterval)duration
{
    CABasicAnimation *bounds = [CABasicAnimation animationWithKeyPath:@"bounds"];
    CGFloat height = self.contractedBounds.size.height;
    CGFloat width = height * 4.0 / 3.0;
    CGRect contractedBounds = CGRectMake(0,0,width,height);

    bounds.toValue = [NSValue valueWithCGRect:contractedBounds];
    bounds.duration = duration;
    
    [self.videoFeedLayer addAnimation:bounds forKey:@"contract"];
    self.videoFeedLayer.bounds = contractedBounds;
}

@end
