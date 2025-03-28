import SwiftUI

struct MainView: View {
    @EnvironmentObject private var appState: AppState
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            VideoView()
                .tabItem {
                    Label("Video", systemImage: "video.fill")
                }
                .tag(0)
            
            TelemetryView()
                .tabItem {
                    Label("Telemetry", systemImage: "antenna.radiowaves.left.and.right")
                }
                .tag(1)
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
                .tag(2)
        }
        .accentColor(.blue)
    }
}

struct VideoView: View {
    @EnvironmentObject private var appState: AppState
    
    var body: some View {
        NavigationView {
            VStack {
                if appState.videoStreamActive {
                    VideoPreviewView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    VStack {
                        Image(systemName: "video.slash.fill")
                            .font(.system(size: 50))
                            .foregroundColor(.gray)
                        Text("Video Stream Inactive")
                            .font(.headline)
                        Button("Start Stream") {
                            appState.startVideoStream()
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
            }
            .navigationTitle("Video Stream")
        }
    }
}

struct TelemetryView: View {
    @EnvironmentObject private var appState: AppState
    
    var body: some View {
        NavigationView {
            VStack {
                if appState.telemetryActive {
                    TelemetryDataView()
                } else {
                    VStack {
                        Image(systemName: "antenna.radiowaves.left.and.right.slash")
                            .font(.system(size: 50))
                            .foregroundColor(.gray)
                        Text("Telemetry Inactive")
                            .font(.headline)
                        Button("Start Telemetry") {
                            appState.startTelemetry()
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
            }
            .navigationTitle("Telemetry")
        }
    }
}

struct SettingsView: View {
    var body: some View {
        NavigationView {
            List {
                Section("Connection") {
                    Toggle("Auto-Connect", isOn: .constant(true))
                    Text("Connection Status: Connected")
                        .foregroundColor(.green)
                }
                
                Section("Video") {
                    Toggle("HD Quality", isOn: .constant(true))
                    Toggle("Low Latency Mode", isOn: .constant(false))
                }
                
                Section("Telemetry") {
                    Toggle("Enable Logging", isOn: .constant(true))
                    Toggle("Save Raw Data", isOn: .constant(false))
                }
                
                Section("About") {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.0.0")
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    MainView()
        .environmentObject(AppState())
} 