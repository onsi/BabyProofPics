//
//  BPMath.m
//  BabyProofPhotos
//
//  Created by Onsi Fakhouri on 7/20/13.
//  Copyright (c) 2013 Onsi Fakhouri. All rights reserved.
//

#import "BPMath.h"

CGFloat BPRandom(CGFloat min, CGFloat max) {
    CGFloat unscaled = (CGFloat)arc4random() / UINT_MAX;
    return unscaled * (max - min) + min;
}

CGPoint CGPointAtCenterOfRect(CGRect rect) {
    return CGPointMake(rect.origin.x + rect.size.width / 2.0, rect.origin.y + rect.size.height / 2.0);
}

CGRect CGRectMakeWithOriginAndSize(CGPoint origin, CGSize size) {
    return CGRectMake(origin.x, origin.y, size.width, size.height);
}