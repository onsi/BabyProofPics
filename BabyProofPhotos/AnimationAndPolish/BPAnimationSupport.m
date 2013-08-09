//
//  BPAnimationSupport.m
//  BabyProofPhotos
//
//  Created by Onsi Fakhouri on 8/3/13.
//  Copyright (c) 2013 Onsi Fakhouri. All rights reserved.
//

#import "BPAnimationSupport.h"

@implementation BPAnimationSupport

+ (NSString *)animationNameForKeyPath:(NSString *)keyPath
{
    return [NSString stringWithFormat:@"BP%@Animation", keyPath.capitalizedString];
}

+ (CABasicAnimation *)animateLayer:(CALayer *)layer keyPath:(NSString *)keyPath toValue:(id)toValue withDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:keyPath];
    animation.fromValue = [layer valueForKey:keyPath];
    animation.toValue = toValue;
    animation.duration = duration;
    animation.fillMode = kCAFillModeBackwards;
    animation.beginTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil] + delay;

    [layer setValue:toValue forKey:keyPath];
    [layer addAnimation:animation forKey:[self animationNameForKeyPath:keyPath]];
    
    return animation;
}

+ (CABasicAnimation *)animateLayer:(CALayer *)layer keyPath:(NSString *)keyPath toFloatValue:(CGFloat)toValue withDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay
{
    return [self animateLayer:layer keyPath:keyPath toValue:@(toValue) withDuration:duration delay:delay];
}

+ (CABasicAnimation *)animateLayer:(CALayer *)layer keyPath:(NSString *)keyPath toPointValue:(CGPoint)toValue withDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay
{
    return [self animateLayer:layer keyPath:keyPath toValue:[NSValue valueWithCGPoint:toValue] withDuration:duration delay:delay];
}

+ (CABasicAnimation *)animateLayer:(CALayer *)layer keyPath:(NSString *)keyPath toRectValue:(CGRect)toValue withDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay
{
    return [self animateLayer:layer keyPath:keyPath toValue:[NSValue valueWithCGRect:toValue] withDuration:duration delay:delay];
}

+ (CABasicAnimation *)animateLayer:(CALayer *)layer keyPath:(NSString *)keyPath toFloatValue:(CGFloat)toValue withDuration:(NSTimeInterval)duration
{
    return [self animateLayer:layer keyPath:keyPath toFloatValue:toValue withDuration:duration delay:0];
}

+ (CABasicAnimation *)animateLayer:(CALayer *)layer keyPath:(NSString *)keyPath toPointValue:(CGPoint)toValue withDuration:(NSTimeInterval)duration
{
    return [self animateLayer:layer keyPath:keyPath toPointValue:toValue withDuration:duration delay:0];
}

+ (CABasicAnimation *)animateLayer:(CALayer *)layer keyPath:(NSString *)keyPath toRectValue:(CGRect)toValue withDuration:(NSTimeInterval)duration
{
    return [self animateLayer:layer keyPath:keyPath toRectValue:toValue withDuration:duration delay:0];
}

+ (void)animateBoundsOfFinickyLayer:(CALayer *)layer toValue:(CGRect)toValue withDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay
{
    // This is for AVCaptureVideoPreviewLayer which does not correctly scale
    // the underlying video when assigned an explicit bounds animation
    // but does correctly scale the video when assigned an implicit bounds animation
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [CATransaction begin];
        [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [CATransaction setAnimationDuration:duration];
        [CATransaction setDisableActions:NO];
        
        layer.bounds = toValue;
        
        [CATransaction commit];
    });
}


@end
