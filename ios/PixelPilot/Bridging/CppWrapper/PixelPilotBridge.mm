#import "PixelPilotBridge.h"
#import <Metal/Metal.h>

// Include C++ headers
#include "videonative/video_processor.hpp"
#include "mavlink/mavlink.h"
#include "wfbngrtl8812/telemetry.hpp"

@interface PixelPilotBridge ()
{
    VideoProcessor* videoProcessor;
    MavlinkHandler* mavlinkHandler;
    TelemetryHandler* telemetryHandler;
    
    void (^mavlinkCallback)(NSData *);
}
@end

@implementation PixelPilotBridge

- (instancetype)init {
    self = [super init];
    if (self) {
        videoProcessor = nullptr;
        mavlinkHandler = nullptr;
        telemetryHandler = nullptr;
    }
    return self;
}

#pragma mark - Video Processing

- (void)initializeVideoProcessing {
    // Initialize Metal device and command queue
    id<MTLDevice> device = MTLCreateSystemDefaultDevice();
    if (!device) {
        NSLog(@"Failed to create Metal device");
        return;
    }
    
    // Initialize C++ video processor
    videoProcessor = new VideoProcessor(device);
}

- (void)processVideoFrame:(NSData *)frameData width:(int)width height:(int)height {
    if (!videoProcessor) return;
    
    const uint8_t* frameBytes = (const uint8_t*)[frameData bytes];
    videoProcessor->processFrame(frameBytes, width, height);
}

- (void)cleanupVideoProcessing {
    if (videoProcessor) {
        delete videoProcessor;
        videoProcessor = nullptr;
    }
}

#pragma mark - MAVLink Communication

- (void)initializeMavlink {
    mavlinkHandler = new MavlinkHandler();
}

- (void)sendMavlinkMessage:(NSData *)message {
    if (!mavlinkHandler) return;
    
    const uint8_t* messageBytes = (const uint8_t*)[message bytes];
    mavlinkHandler->sendMessage(messageBytes, [message length]);
}

static void handleMavlinkMessage(void* context, const uint8_t* data, size_t length) {
    PixelPilotBridge* bridge = (__bridge PixelPilotBridge*)context;
    if (bridge && bridge->mavlinkCallback) {
        NSData* message = [NSData dataWithBytes:data length:length];
        bridge->mavlinkCallback(message);
    }
}

- (void)registerMavlinkCallback:(void (^)(NSData *))callback {
    mavlinkCallback = callback;
    
    if (mavlinkHandler) {
        mavlinkHandler->setCallback(handleMavlinkMessage, (__bridge void*)self);
    }
}

- (void)cleanupMavlink {
    if (mavlinkHandler) {
        delete mavlinkHandler;
        mavlinkHandler = nullptr;
    }
}

#pragma mark - Telemetry

- (void)initializeTelemetry {
    telemetryHandler = new TelemetryHandler();
}

- (void)startTelemetryStream {
    if (telemetryHandler) {
        telemetryHandler->startStream();
    }
}

- (void)stopTelemetryStream {
    if (telemetryHandler) {
        telemetryHandler->stopStream();
    }
}

- (void)cleanupTelemetry {
    if (telemetryHandler) {
        delete telemetryHandler;
        telemetryHandler = nullptr;
    }
}

- (void)dealloc {
    [self cleanupVideoProcessing];
    [self cleanupMavlink];
    [self cleanupTelemetry];
}

@end 