#ifndef TELEMETRY_HPP
#define TELEMETRY_HPP

class TelemetryHandler {
public:
    TelemetryHandler();
    ~TelemetryHandler();
    
    void startStream();
    void stopStream();
    
private:
    bool isStreaming;
};

#endif // TELEMETRY_HPP 