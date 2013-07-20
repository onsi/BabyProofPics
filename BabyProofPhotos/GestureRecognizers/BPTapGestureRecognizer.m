//
//  BPTapGestureRecognizer.m
//  BabyProofPhotos
//
//  Created by Onsi Fakhouri on 7/18/13.
//  Copyright (c) 2013 Onsi Fakhouri. All rights reserved.
//

#import "BPTapGestureRecognizer.h"
#import <UIKit/UIGestureRecognizerSubclass.h>

@implementation BPTapGestureRecognizer

- (BOOL)viewContainsTouch:(UITouch *)touch
{
    return [self.view pointInside:[touch locationInView:self.view] withEvent:nil];
}

- (NSUInteger)numberOfTouchesInView:(NSSet *)touches
{
    return [[touches filteredSetUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(UITouch *touch, NSDictionary *bindings) {
        return [self viewContainsTouch:touch];
    }]] count];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([self numberOfTouchesInView:event.allTouches] == 0) {
        self.state = UIGestureRecognizerStateRecognized;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    int numberOfTouchesEndingInView = [self numberOfTouchesInView:touches];
    int numberOfTouchesInView = [self numberOfTouchesInView:event.allTouches];
   
    if (numberOfTouchesEndingInView > 0 && numberOfTouchesEndingInView == numberOfTouchesInView) {
        self.state = UIGestureRecognizerStateRecognized;
    }
}

@end
