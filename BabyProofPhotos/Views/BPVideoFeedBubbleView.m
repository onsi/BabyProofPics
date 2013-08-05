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
    [CATransaction setAnimationDuration:duration];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    [self moveToPosition:CGPointAtCenterOfRect(self.expandedBounds) withDuration:duration];
    [self expandToFillSuperviewAndStraighenCornersWithDuration:duration];
    [self expandVideoFeedLayerWithDuration:duration];
    [CATransaction commit];
}

- (void)contractToSize:(CGSize)size center:(CGPoint)center withDuration:(NSTimeInterval)duration completion:(BPAnimationCompletion)completion
{
    [CATransaction begin];
    [CATransaction setCompletionBlock:completion];
    [CATransaction setAnimationDuration:duration];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
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
- (void)moveToPosition:(CGPoint)position withDuration:(NSTimeInterval)duration
{
    CABasicAnimation *positionAnimation = [BPAnimationSupport positionFrom:self.layer.position to:position withDuration:duration];
    
    self.layer.position = position;
    [self.layer addAnimation:positionAnimation forKey:@"moveToPosition"];
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
