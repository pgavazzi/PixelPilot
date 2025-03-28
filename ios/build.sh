#!/bin/bash

# Exit on error
set -e

# Check if xcodegen is installed
if ! command -v xcodegen &> /dev/null; then
    echo "Installing xcodegen..."
    brew install xcodegen
fi

# Generate Xcode project
echo "Generating Xcode project..."
xcodegen generate

# Build the project
echo "Building project..."
xcodebuild -project PixelPilot.xcodeproj -scheme PixelPilot -configuration Debug -sdk iphonesimulator

echo "Build complete!" 