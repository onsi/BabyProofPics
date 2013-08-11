//
//  BPMath.h
//  BabyProofPhotos
//
//  Created by Onsi Fakhouri on 7/20/13.
//  Copyright (c) 2013 Onsi Fakhouri. All rights reserved.
//

#import <Foundation/Foundation.h>

CGFloat BPRandom(CGFloat min, CGFloat max);
CGPoint CGPointAtCenterOfRect(CGRect rect);
CGRect CGRectMakeWithOriginAndSize(CGPoint origin, CGSize size);
CGRect CGRectMakeWithCenterAndSize(CGPoint center, CGSize size);
CGSize CGSizeBySubtractingOffset(CGSize size, CGFloat offset);
