//
//  BPAnimationSupport.h
//  BabyProofPhotos
//
//  Created by Onsi Fakhouri on 8/3/13.
//  Copyright (c) 2013 Onsi Fakhouri. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BPAnimationSupport : NSObject

+ (CAAnimationGroup *)groupAnimations:(NSArray *)animations
                         withDuration:(NSTimeInterval)duration;

+ (CABasicAnimation *)cornerRadiusFrom:(CGFloat)fromValue
                                    to:(CGFloat)toValue
                          withDuration:(NSTimeInterval)duration;

+ (CABasicAnimation *)boundsFrom:(CGRect)fromValue
                              to:(CGRect)toValue
                    withDuration:(NSTimeInterval)duration;

+ (CAKeyframeAnimation *)positionAlongPath:(UIBezierPath *)path
                              withDuration:(NSTimeInterval)duration;

@end
