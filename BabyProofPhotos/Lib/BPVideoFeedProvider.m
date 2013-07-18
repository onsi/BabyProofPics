//
//  BPVideoFeedProvider.m
//  BabyProofPhotos
//
//  Created by Onsi Fakhouri on 7/16/13.
//  Copyright (c) 2013 Onsi Fakhouri. All rights reserved.
//

#import "BPVideoFeedProvider.h"
#import <AVFoundation/AVFoundation.h>

@implementation BPVideoFeedProvider

+ (instancetype)provider
{
    return [[BPVideoFeedProvider alloc] init];
}

- (CALayer *)videoFeedLayer
{
    AVCaptureSession *session = [[AVCaptureSession alloc] init];
    AVCaptureDeviceInput *frontCaptureDeviceInput = [self getFrontCaptureDeviceInputForSession:session];
    if (frontCaptureDeviceInput) {
        [session addInput:frontCaptureDeviceInput];
        [session startRunning];

        return [self videoFeedLayerForSession:session];
    } else {
        return [self missingVideoFeedLayer];
    }
}

- (AVCaptureDeviceInput *)getFrontCaptureDeviceInputForSession:(AVCaptureSession *)session
{
    AVCaptureDevice *frontDevice = nil;
    
    for (AVCaptureDevice *device in [AVCaptureDevice devices]) {
        if (device.position == AVCaptureDevicePositionFront) {
            frontDevice = device;
            break;
            
        }
    }
    
    if (frontDevice) {
        AVCaptureDeviceInput *frontDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:frontDevice
                                                                                       error:NULL];
        if (frontDeviceInput && [session canAddInput:frontDeviceInput]) {
            return frontDeviceInput;
        }
    }
    
    return nil;
}

- (AVCaptureVideoPreviewLayer *)videoFeedLayerForSession:(AVCaptureSession *)session
{
    AVCaptureVideoPreviewLayer *videoFeedLayer = [AVCaptureVideoPreviewLayer layerWithSession:session];
    videoFeedLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    AVCaptureConnection *connection = videoFeedLayer.connection;
    connection.videoOrientation = AVCaptureVideoOrientationLandscapeLeft;
    connection.automaticallyAdjustsVideoMirroring = NO;
    connection.videoMirrored = YES;

    return videoFeedLayer;
}

- (CAGradientLayer *)missingVideoFeedLayer
{
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.colors = @[(id)[[UIColor blueColor] CGColor], (id)[[UIColor whiteColor] CGColor]];
    layer.locations = @[@0.2, @1];
    return layer;
}

@end
