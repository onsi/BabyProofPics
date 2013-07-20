//
//  BPScratch.m
//  BabyProofPhotos
//
//  Created by Onsi Fakhouri on 7/19/13.
//  Copyright (c) 2013 Onsi Fakhouri. All rights reserved.
//

#import "BPScratch.h"

@implementation BPScratch

+ (NSString *)describeIfView:(UIView *)view containsTouch:(UITouch *)touch
{
    return [view pointInside:[touch locationInView:view] withEvent:nil] ? @"IN" : @"OUT";
}


+ (void)logTouches:(NSSet *)touches andEvent:(UIEvent *)event inView:(UIView *)view withMessage:(NSString *)message
{
    NSArray *phases = @[@"Began", @"Moved", @"Stationary", @"Ended", @"Cancelled"];
    
    NSLog(@"==== %@ ====", message);
    for (UITouch *touch in touches) {
        NSLog(@"\t%p %@ (%@) - %@", touch, NSStringFromCGPoint([touch locationInView:view]), [self describeIfView:view containsTouch:touch], phases[touch.phase]);
    }
    
    NSLog(@"\t--------------------");
    for (UITouch *touch in event.allTouches) {
        NSLog(@"\t%p %@ (%@) - %@", touch, NSStringFromCGPoint([touch locationInView:view]), [self describeIfView:view containsTouch:touch], phases[touch.phase]);
    }
    NSLog(@"\n");
}

@end
