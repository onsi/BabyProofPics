//
//  BPVideoFeedBubbleView.m
//  BabyProofPhotos
//
//  Created by Onsi Fakhouri on 7/26/13.
//  Copyright (c) 2013 Onsi Fakhouri. All rights reserved.
//

#import "BPVideoFeedBubbleView.h"
#import "BPMath.h"
#import "BPAnimationSupport.h"

@interface BPVideoFeedBubbleView ()

@property (nonatomic, strong) CALayer *videoFeedLayer;

@end

@implementation BPVideoFeedBubbleView

#pragma mark - Adding and removing the video feed

- (void)installVideoFeedLayer:(CALayer *)videoFeedLayer
{
    self.videoFeedLayer = videoFeedLayer;
    [self.videoFeedLayer removeFromSuperlayer];
    
    self.videoFeedLayer.anchorPoint = CGPointMake(0,0);
    self.videoFeedLayer.position = CGPointMake(0, 0);

    CGFloat height = self.contentView.bounds.size.height;
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

- (void)expandToFillSuperviewWithDuration:(NSTimeInterval)duration completion:(BPAnimationCompletion)completion
{
    [CATransaction begin];
    [CATransaction setCompletionBlock:completion];
    [self moveToCenterWithDuration:duration];
    [self expandToFillSuperviewAndStraighenCornersWithDuration:duration];
    [self expandVideoFeedLayerWithDuration:duration];
    [CATransaction commit];
}

- (void)contractToSize:(CGSize)size center:(CGPoint)center withDuration:(NSTimeInterval)duration completion:(BPAnimationCompletion)completion
{
    //PASS ME A COMPLETION BLOCK!
    [CATransaction begin];
    [CATransaction setCompletionBlock:completion];
    [self moveToPosition:center withDuration:duration];
    [self contractToSize:size andCircularizeWithDuration:duration];
    [self contractVideoFeedLayerToSize:size withDuration:duration];
    [CATransaction commit];
}

#pragma mark - Expansion

- (CGRect)expandedBounds
{
    return self.superview.bounds;
}

- (UIBezierPath *)spiralFromOuterPoint:(CGPoint)outerPoint toCenterPoint:(CGPoint)centerPoint
{
    CGFloat bottomOfSpiral = centerPoint.y + self.expandedBounds.size.height * 0.3;
    CGFloat edgeOfSpiral = centerPoint.x - 0.3 * (outerPoint.x - centerPoint.x);
    CGFloat topOfSpiral = centerPoint.y - self.expandedBounds.size.height * 0.15;
    
    CGPoint firstInflection = CGPointMake((outerPoint.x + edgeOfSpiral) / 2.0, bottomOfSpiral);
    CGPoint secondInflection = CGPointMake(edgeOfSpiral, centerPoint.y);
    CGPoint thirdInflection = CGPointMake((centerPoint.x + edgeOfSpiral) / 2.0, topOfSpiral);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:outerPoint];
    [path addQuadCurveToPoint:firstInflection
                 controlPoint:CGPointMake(outerPoint.x, firstInflection.y)];
    [path addQuadCurveToPoint:secondInflection
                 controlPoint:CGPointMake(secondInflection.x, firstInflection.y)];
    [path addQuadCurveToPoint:thirdInflection
                 controlPoint:CGPointMake(secondInflection.x, thirdInflection.y)];
    [path addQuadCurveToPoint:centerPoint
                 controlPoint:CGPointMake(centerPoint.x, secondInflection.y)];
    
    return path;
}

- (UIBezierPath *)spiralFromCenterPoint:(CGPoint)centerPoint toOuterPoint:(CGPoint)outerPoint
{
    return [[self spiralFromOuterPoint:outerPoint toCenterPoint:centerPoint] bezierPathByReversingPath];
}

- (void)moveToCenterWithDuration:(NSTimeInterval)duration
{
    UIBezierPath *path = [self spiralFromOuterPoint:self.layer.position
                                      toCenterPoint:CGPointAtCenterOfRect(self.expandedBounds)];
    
    CAKeyframeAnimation *pathAnimation = [BPAnimationSupport positionAlongPath:path
                                                                  withDuration:duration];

    self.layer.position = CGPointAtCenterOfRect(self.expandedBounds);
    [self.layer addAnimation:pathAnimation forKey:@"spiralToCenter"];
}

- (void)expandToFillSuperviewAndStraighenCornersWithDuration:(NSTimeInterval)duration
{
    CABasicAnimation *cornerRadiusAnimation = [BPAnimationSupport cornerRadiusFrom:self.contentView.layer.cornerRadius to:0 withDuration:duration];

    CABasicAnimation *boundsAnimation = [BPAnimationSupport boundsFrom:self.contentView.layer.bounds to:self.expandedBounds withDuration:duration];
    
    CAAnimationGroup *animationGroup = [BPAnimationSupport groupAnimations:@[cornerRadiusAnimation, boundsAnimation]
                                                              withDuration:duration];

    self.contentView.layer.cornerRadius = 0;
    self.contentView.layer.bounds = self.expandedBounds;
    [self.contentView.layer addAnimation:animationGroup forKey:@"expandToFill"];
}


- (void)expandVideoFeedLayerWithDuration:(NSTimeInterval)duration
{
    CABasicAnimation *boundsAnimation = [BPAnimationSupport boundsFrom:self.videoFeedLayer.bounds to:self.expandedBounds withDuration:duration];

    self.videoFeedLayer.bounds = self.expandedBounds;
    [self.videoFeedLayer addAnimation:boundsAnimation forKey:@"expandToFill"];
}

#pragma mark - Contraction

- (void)moveToPosition:(CGPoint)position withDuration:(NSTimeInterval)duration
{
    UIBezierPath *path = [self spiralFromCenterPoint:CGPointAtCenterOfRect(self.expandedBounds)
                                        toOuterPoint:position];
    
    CAKeyframeAnimation *pathAnimation = [BPAnimationSupport positionAlongPath:path
                                                                  withDuration:duration];
    
    self.layer.position = position;
    [self.layer addAnimation:pathAnimation forKey:@"spiralToEdge"];
}

- (void)contractToSize:(CGSize)size andCircularizeWithDuration:(NSTimeInterval)duration
{
    CGRect contractedBounds = CGRectMakeWithOriginAndSize(CGPointZero, size);
    
    CABasicAnimation *cornerRadiusAnimation = [BPAnimationSupport cornerRadiusFrom:0 to:size.width / 2.0 withDuration:duration];
    
    CABasicAnimation *boundsAnimation = [BPAnimationSupport boundsFrom:self.contentView.layer.bounds to:contractedBounds withDuration:duration];
    
    CAAnimationGroup *animationGroup = [BPAnimationSupport groupAnimations:@[cornerRadiusAnimation, boundsAnimation]
                                                              withDuration:duration];
    
    self.contentView.layer.cornerRadius = size.width / 2.0;
    self.contentView.layer.bounds = contractedBounds;
    [self.contentView.layer addAnimation:animationGroup forKey:@"contract"];
}

- (void)contractVideoFeedLayerToSize:(CGSize)size withDuration:(NSTimeInterval)duration
{
    CGFloat height = size.height;
    CGFloat width = height * 4.0 / 3.0;
    CGRect contractedBounds = CGRectMake(0,0,width,height);

    CABasicAnimation *boundsAnimation = [BPAnimationSupport boundsFrom:self.videoFeedLayer.bounds to:contractedBounds withDuration:duration];
    
    self.videoFeedLayer.bounds = contractedBounds;
    [self.videoFeedLayer addAnimation:boundsAnimation forKey:@"contract"];
}

@end
