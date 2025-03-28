#include "mavlink/mavlink.h"

MavlinkHandler::MavlinkHandler() : messageCallback(nullptr), callbackContext(nullptr) {
}

MavlinkHandler::~MavlinkHandler() {
    messageCallback = nullptr;
    callbackContext = nullptr;
}

void MavlinkHandler::sendMessage(const uint8_t* data, size_t length) {
    // Implementation for sending MAVLink messages
    // This will be implemented when we integrate with the actual MAVLink library
}

void MavlinkHandler::setCallback(MavlinkCallback callback, void* context) {
    messageCallback = callback;
    callbackContext = context;
} 