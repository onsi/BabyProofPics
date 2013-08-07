//
//  BPTappableCircularView.h
//  BabyProofPhotos
//
//  Created by Onsi Fakhouri on 7/17/13.
//  Copyright (c) 2013 Onsi Fakhouri. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BPTappableCircularView : UIView

- (CALayer *)contentLayer;
- (CALayer *)circularMask;
- (void)setTapTarget:(id)target action:(SEL)action;

@end
