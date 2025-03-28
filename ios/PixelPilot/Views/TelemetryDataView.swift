import SwiftUI

struct TelemetryDataView: View {
    @State private var altitude: Double = 0.0
    @State private var speed: Double = 0.0
    @State private var battery: Double = 85.0
    @State private var signalStrength: Double = 95.0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Flight Status Card
                TelemetryCard(title: "Flight Status") {
                    HStack {
                        TelemetryValue(title: "Altitude", value: "\(Int(altitude))m", icon: "arrow.up")
                        Divider()
                        TelemetryValue(title: "Speed", value: "\(Int(speed))km/h", icon: "speedometer")
                        Divider()
                        TelemetryValue(title: "Battery", value: "\(Int(battery))%", icon: "battery.100")
                    }
                }
                
                // Signal Strength Card
                TelemetryCard(title: "Signal Strength") {
                    VStack {
                        HStack {
                            Image(systemName: "antenna.radiowaves.left.and.right")
                                .foregroundColor(.blue)
                            Text("Signal Quality")
                                .font(.headline)
                            Spacer()
                            Text("\(Int(signalStrength))%")
                                .font(.title2)
                                .foregroundColor(.blue)
                        }
                        
                        ProgressView(value: signalStrength, total: 100)
                            .tint(.blue)
                    }
                }
                
                // Flight Controls Card
                TelemetryCard(title: "Flight Controls") {
                    VStack(spacing: 15) {
                        HStack {
                            ControlButton(systemName: "arrow.up", action: {})
                            ControlButton(systemName: "arrow.down", action: {})
                        }
                        
                        HStack {
                            ControlButton(systemName: "arrow.left", action: {})
                            ControlButton(systemName: "arrow.right", action: {})
                        }
                    }
                }
                
                // System Status Card
                TelemetryCard(title: "System Status") {
                    VStack(alignment: .leading, spacing: 10) {
                        StatusRow(title: "GPS", status: "Connected", satellites: 12)
                        StatusRow(title: "IMU", status: "Calibrated", value: "Ready")
                        StatusRow(title: "Camera", status: "Active", value: "1080p")
                        StatusRow(title: "Storage", status: "Available", value: "2.5GB")
                    }
                }
            }
            .padding()
        }
    }
}

struct TelemetryCard<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)
                .foregroundColor(.blue)
            
            content
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}

struct TelemetryValue: View {
    let title: String
    let value: String
    let icon: String
    
    var body: some View {
        VStack {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.blue)
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
            Text(value)
                .font(.title3)
                .bold()
        }
    }
}

struct ControlButton: View {
    let systemName: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: systemName)
                .font(.title)
                .foregroundColor(.white)
                .frame(width: 60, height: 60)
                .background(Color.blue)
                .clipShape(Circle())
        }
    }
}

struct StatusRow: View {
    let title: String
    let status: String
    var satellites: Int? = nil
    var value: String? = nil
    
    var body: some View {
        HStack {
            Text(title)
                .font(.subheadline)
            Spacer()
            if let satellites = satellites {
                Text("\(satellites) satellites")
                    .foregroundColor(.green)
            } else if let value = value {
                Text(value)
                    .foregroundColor(.gray)
            }
            Text(status)
                .foregroundColor(.green)
        }
    }
}

#Preview {
    TelemetryDataView()
} 