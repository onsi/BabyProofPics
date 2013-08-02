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
    [self moveToCenterWithDuration:duration];
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

- (CGPathRef)spiralToCenterPath
{
    CGPoint start = self.layer.position;
    CGPoint end = CGPointAtCenterOfRect(self.expandedBounds);

    CGFloat bottomOfSpiral = end.y + self.expandedBounds.size.height * 0.3;
    CGFloat edgeOfSpiral = end.x - 0.3 * (start.x - end.x);
    CGFloat topOfSpiral = end.y - self.expandedBounds.size.height * 0.15;
    
    CGPoint first_inflection = CGPointMake((start.x + edgeOfSpiral) / 2.0, bottomOfSpiral);
    CGPoint second_inflection = CGPointMake(edgeOfSpiral, end.y);
    CGPoint third_inflection = CGPointMake((end.x + edgeOfSpiral) / 2.0, topOfSpiral);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, start.x, start.y);
    CGPathAddQuadCurveToPoint(path, NULL, start.x, first_inflection.y, first_inflection.x, first_inflection.y);
    CGPathAddQuadCurveToPoint(path, NULL, second_inflection.x, first_inflection.y, second_inflection.x, second_inflection.y);
    CGPathAddQuadCurveToPoint(path, NULL, second_inflection.x, third_inflection.y, third_inflection.x, third_inflection.y);
    CGPathAddQuadCurveToPoint(path, NULL, end.x, second_inflection.y, end.x, end.y);
    
    return path;
}

- (void)moveToCenterWithDuration:(NSTimeInterval)duration
{
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.path = self.spiralToCenterPath;
    pathAnimation.calculationMode = @"paced";
    pathAnimation.duration = duration;
    
    self.layer.position = CGPathGetCurrentPoint(pathAnimation.path);
    [self.layer addAnimation:pathAnimation forKey:@"snapToCenter"];
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
