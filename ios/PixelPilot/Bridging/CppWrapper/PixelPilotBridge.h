#ifndef PixelPilotBridge_h
#define PixelPilotBridge_h

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PixelPilotBridge : NSObject

// Video Processing
- (void)initializeVideoProcessing;
- (void)processVideoFrame:(NSData *)frameData width:(int)width height:(int)height;
- (void)cleanupVideoProcessing;

// MAVLink Communication
- (void)initializeMavlink;
- (void)sendMavlinkMessage:(NSData *)message;
- (void)registerMavlinkCallback:(void (^)(NSData *message))callback;
- (void)cleanupMavlink;

// Telemetry
- (void)initializeTelemetry;
- (void)startTelemetryStream;
- (void)stopTelemetryStream;
- (void)cleanupTelemetry;

@end

NS_ASSUME_NONNULL_END

#endif /* PixelPilotBridge_h */ 