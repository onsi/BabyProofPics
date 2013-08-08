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
    
    CGFloat height = self.contentLayer.bounds.size.height;
    CGFloat width = height * 4.0 / 3.0;
    
    self.videoFeedLayer.bounds = CGRectMake(0,0,width,height);
    [self.contentLayer addSublayer:self.videoFeedLayer];
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
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [CATransaction setDisableActions:YES];
    
    CGRect expandedBounds = self.superview.bounds;
    CGPoint centerOfExpandedBounds = CGPointAtCenterOfRect(expandedBounds);
    
    CGFloat expandedMaskRadius = sqrtf(powf(expandedBounds.size.width / 2.0, 2.0) + powf(expandedBounds.size.height / 2.0, 2.0));
    CGRect expandedMaskBounds = CGRectMakeWithOriginAndSize(CGPointZero, CGSizeMake(expandedMaskRadius * 2, expandedMaskRadius * 2));
    CGPoint expandedMaskPosition = centerOfExpandedBounds;
    
    CGFloat maskExpansionDuration = duration;
    CGFloat contentExpansionDuration = duration * (expandedBounds.size.height / expandedMaskRadius / 2.0) / 1.2;
    

    [BPAnimationSupport animateLayer:self.layer keyPath:@"position" toPointValue:centerOfExpandedBounds withDuration:contentExpansionDuration];
    [BPAnimationSupport animateLayer:self.contentLayer keyPath:@"bounds" toRectValue:expandedBounds withDuration:contentExpansionDuration];
    [BPAnimationSupport animateLayer:self.videoFeedLayer keyPath:@"bounds" toRectValue:expandedBounds withDuration:contentExpansionDuration];

    [BPAnimationSupport animateLayer:self.circularMask keyPath:@"position" toPointValue:expandedMaskPosition withDuration:contentExpansionDuration];
    [BPAnimationSupport animateLayer:self.circularMask keyPath:@"bounds" toRectValue:expandedMaskBounds withDuration:maskExpansionDuration];
    [BPAnimationSupport animateLayer:self.circularMask keyPath:@"cornerRadius" toFloatValue:expandedMaskRadius withDuration:maskExpansionDuration];
    
    [CATransaction commit];
}

- (void)contractToSize:(CGSize)size center:(CGPoint)center withDuration:(NSTimeInterval)duration completion:(BPAnimationCompletion)completion
{
    [CATransaction begin];
    [CATransaction setCompletionBlock:completion];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [CATransaction setDisableActions:YES];
    
    CGRect contractedBounds = CGRectMakeWithOriginAndSize(CGPointZero, size);
    CGRect contractedVideoFeedBounds = CGRectMakeWithOriginAndSize(CGPointZero, CGSizeMake(size.height * 4.0 / 3.0, size.height));
    
    CGSize contractedMaskSize = CGSizeBySubtractingOffset(contractedBounds.size, self.circularMask.shadowRadius);
    CGRect contractedMaskBounds = CGRectMakeWithOriginAndSize(CGPointZero, contractedMaskSize);
    CGFloat contractedMaskRadius = contractedMaskSize.width / 2.0;
    CGPoint contractedMaskPosition = CGPointAtCenterOfRect(contractedBounds);
    
    CGFloat maskContractionDuration = duration;
    CGFloat contentContractionDuration = duration * (self.contentLayer.bounds.size.height / self.circularMask.cornerRadius / 2.0) / 1.2;
    CGFloat contentContractionBeginTime = maskContractionDuration - contentContractionDuration;
    
    [BPAnimationSupport animateLayer:self.layer keyPath:@"position" toPointValue:center withDuration:contentContractionDuration delay:contentContractionBeginTime];
    [BPAnimationSupport animateLayer:self.contentLayer keyPath:@"bounds" toRectValue:contractedBounds withDuration:contentContractionDuration delay:contentContractionBeginTime];
    [BPAnimationSupport animateLayer:self.videoFeedLayer keyPath:@"bounds" toRectValue:contractedVideoFeedBounds withDuration:contentContractionDuration delay:contentContractionBeginTime];
    
    [BPAnimationSupport animateLayer:self.circularMask keyPath:@"position" toPointValue:contractedMaskPosition withDuration:contentContractionDuration delay:contentContractionBeginTime];
    [BPAnimationSupport animateLayer:self.circularMask keyPath:@"bounds" toRectValue:contractedMaskBounds withDuration:maskContractionDuration];
    [BPAnimationSupport animateLayer:self.circularMask keyPath:@"cornerRadius" toFloatValue:contractedMaskRadius withDuration:maskContractionDuration];
 
    [CATransaction commit];
}

@end
