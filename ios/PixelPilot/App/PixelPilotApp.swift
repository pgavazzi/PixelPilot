import SwiftUI

@main
struct PixelPilotApp: App {
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(appState)
        }
    }
}

class AppState: ObservableObject {
    @Published var isConnected = false
    @Published var videoStreamActive = false
    @Published var telemetryActive = false
    
    private let bridge = PixelPilotBridge()
    
    init() {
        setupBridge()
    }
    
    private func setupBridge() {
        bridge.initializeVideoProcessing()
        bridge.initializeMavlink()
        bridge.initializeTelemetry()
        
        bridge.registerMavlinkCallback { [weak self] message in
            // Handle incoming MAVLink messages
            self?.handleMavlinkMessage(message)
        }
    }
    
    private func handleMavlinkMessage(_ message: Data) {
        // Process MAVLink messages
    }
    
    func startVideoStream() {
        videoStreamActive = true
    }
    
    func stopVideoStream() {
        videoStreamActive = false
    }
    
    func startTelemetry() {
        bridge.startTelemetryStream()
        telemetryActive = true
    }
    
    func stopTelemetry() {
        bridge.stopTelemetryStream()
        telemetryActive = false
    }
    
    deinit {
        bridge.cleanupVideoProcessing()
        bridge.cleanupMavlink()
        bridge.cleanupTelemetry()
    }
} 