#ifndef MAVLINK_H
#define MAVLINK_H

#include <cstdint>
#include <functional>

typedef void (*MavlinkCallback)(void* context, const uint8_t* data, size_t length);

class MavlinkHandler {
public:
    MavlinkHandler();
    ~MavlinkHandler();
    
    void sendMessage(const uint8_t* data, size_t length);
    void setCallback(MavlinkCallback callback, void* context);
    
private:
    MavlinkCallback messageCallback;
    void* callbackContext;
};

#endif // MAVLINK_H 