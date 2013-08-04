//
//  BPAnimationSupport.m
//  BabyProofPhotos
//
//  Created by Onsi Fakhouri on 8/3/13.
//  Copyright (c) 2013 Onsi Fakhouri. All rights reserved.
//

#import "BPAnimationSupport.h"

@implementation BPAnimationSupport

+ (CAAnimationGroup *)groupAnimations:(NSArray *)animations
                         withDuration:(NSTimeInterval)duration
{
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = animations;
    animationGroup.duration = duration;

    return animationGroup;
}

+ (CABasicAnimation *)cornerRadiusFrom:(CGFloat)fromValue
                                    to:(CGFloat)toValue
                          withDuration:(NSTimeInterval)duration
{
    CABasicAnimation *cornerRadiusAnimation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    cornerRadiusAnimation.fromValue = @(fromValue);
    cornerRadiusAnimation.toValue = @(toValue);
    cornerRadiusAnimation.duration = duration;
    
    return cornerRadiusAnimation;
}

+ (CABasicAnimation *)boundsFrom:(CGRect)fromValue
                              to:(CGRect)toValue
                    withDuration:(NSTimeInterval)duration
{
    CABasicAnimation *boundsAnimation = [CABasicAnimation animationWithKeyPath:@"bounds"];
    boundsAnimation.fromValue = [NSValue valueWithCGRect:fromValue];
    boundsAnimation.toValue = [NSValue valueWithCGRect:toValue];
    boundsAnimation.duration = duration;
    
    return boundsAnimation;
}

+ (CAKeyframeAnimation *)positionAlongPath:(UIBezierPath *)path
                              withDuration:(NSTimeInterval)duration
{
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.path = path.CGPath;
    pathAnimation.calculationMode = @"cubicPaced";
    pathAnimation.duration = duration;

    return pathAnimation;
}

@end
