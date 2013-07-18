//
//  BPVideoFeedProvider.h
//  BabyProofPhotos
//
//  Created by Onsi Fakhouri on 7/16/13.
//  Copyright (c) 2013 Onsi Fakhouri. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BPVideoFeedProvider : NSObject

+ (instancetype)provider;

- (CALayer *)videoFeedLayer;

@end
