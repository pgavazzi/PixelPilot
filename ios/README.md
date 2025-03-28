# PixelPilot iOS

This is the iOS port of PixelPilot, using SwiftUI for the interface and sharing core C++ components with the Android version.

## Project Structure

```
PixelPilot/
├── App/
│   ├── PixelPilotApp.swift
│   └── AppDelegate.swift
├── Views/
│   ├── MainView.swift
│   ├── VideoView.swift
│   └── TelemetryView.swift
├── Models/
│   └── ViewModels/
├── Services/
│   ├── MavlinkService.swift
│   ├── VideoService.swift
│   └── TelemetryService.swift
└── Resources/
Shared/
├── mavlink/
├── videonative/
└── wfbngrtl8812/
Bridging/
└── CppWrapper/
```

## Setup Instructions

1. Open the project in Xcode 15.0 or later
2. Install required dependencies using Swift Package Manager
3. Build and run the project

## Dependencies

- SwiftUI
- Metal (for video processing)
- CoreBluetooth (for telemetry)
- Shared C++ components from the main project

## Building from Source

1. Clone the repository
2. Open `PixelPilot.xcodeproj` in Xcode
3. Build the project (⌘B)
4. Run on your device or simulator (⌘R)

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request 