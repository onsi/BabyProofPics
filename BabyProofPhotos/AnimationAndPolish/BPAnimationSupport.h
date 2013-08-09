//
//  BPAnimationSupport.h
//  BabyProofPhotos
//
//  Created by Onsi Fakhouri on 8/3/13.
//  Copyright (c) 2013 Onsi Fakhouri. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BPAnimationSupport : NSObject

+ (CABasicAnimation *)animateLayer:(CALayer *)layer keyPath:(NSString *)keyPath toValue:(id)toValue withDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay;

+ (CABasicAnimation *)animateLayer:(CALayer *)layer keyPath:(NSString *)keyPath toFloatValue:(CGFloat)toValue withDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay;
+ (CABasicAnimation *)animateLayer:(CALayer *)layer keyPath:(NSString *)keyPath toPointValue:(CGPoint)toValue withDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay;
+ (CABasicAnimation *)animateLayer:(CALayer *)layer keyPath:(NSString *)keyPath toRectValue:(CGRect)toValue withDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay;

+ (CABasicAnimation *)animateLayer:(CALayer *)layer keyPath:(NSString *)keyPath toFloatValue:(CGFloat)toValue withDuration:(NSTimeInterval)duration;
+ (CABasicAnimation *)animateLayer:(CALayer *)layer keyPath:(NSString *)keyPath toPointValue:(CGPoint)toValue withDuration:(NSTimeInterval)duration;
+ (CABasicAnimation *)animateLayer:(CALayer *)layer keyPath:(NSString *)keyPath toRectValue:(CGRect)toValue withDuration:(NSTimeInterval)duration;

@end
