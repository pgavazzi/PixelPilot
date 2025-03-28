#ifndef VIDEO_PROCESSOR_HPP
#define VIDEO_PROCESSOR_HPP

#import <Metal/Metal.h>

class VideoProcessor {
public:
    VideoProcessor(id<MTLDevice> device);
    ~VideoProcessor();
    
    void processFrame(const uint8_t* frameData, int width, int height);
    
private:
    id<MTLDevice> metalDevice;
    id<MTLCommandQueue> commandQueue;
    id<MTLTexture> videoTexture;
};

#endif // VIDEO_PROCESSOR_HPP 