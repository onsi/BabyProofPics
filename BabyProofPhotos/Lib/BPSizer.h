//
//  BPSizer.h
//  BabyProofPhotos
//
//  Created by Onsi Fakhouri on 8/10/13.
//  Copyright (c) 2013 Onsi Fakhouri. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BPSizer : NSObject

+ (CGFloat)aspectRatio;
+ (CGFloat)density;

+ (CGSize)videoFeedBubbleSize;
+ (CGPoint)videoFeedBubbleCenter;

@end
