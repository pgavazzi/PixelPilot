#import <Metal/Metal.h>
#include "videonative/video_processor.hpp"

VideoProcessor::VideoProcessor(id<MTLDevice> device) : metalDevice(device) {
    commandQueue = [device newCommandQueue];
}

VideoProcessor::~VideoProcessor() {
    commandQueue = nil;
    videoTexture = nil;
}

void VideoProcessor::processFrame(const uint8_t* frameData, int width, int height) {
    @autoreleasepool {
        // Create texture descriptor
        MTLTextureDescriptor* textureDescriptor = [MTLTextureDescriptor texture2DDescriptorWithPixelFormat:MTLPixelFormatRGBA8Unorm
                                                                                                    width:width
                                                                                                   height:height
                                                                                                mipmapped:NO];
        textureDescriptor.usage = MTLTextureUsageShaderRead | MTLTextureUsageShaderWrite;
        
        // Create texture from frame data
        videoTexture = [metalDevice newTextureWithDescriptor:textureDescriptor];
        [videoTexture replaceRegion:MTLRegionMake2D(0, 0, width, height)
                       mipmapLevel:0
                         withBytes:frameData
                       bytesPerRow:width * 4];
        
        // Create command buffer and encoder
        id<MTLCommandBuffer> commandBuffer = [commandQueue commandBuffer];
        id<MTLComputeCommandEncoder> computeEncoder = [commandBuffer computeCommandEncoder];
        
        // End encoding and commit
        [computeEncoder endEncoding];
        [commandBuffer commit];
    }
} 