#!/bin/bash

# Paths (Update these paths as needed)
BUNDLETOOL_PATH="./bundletool-all-1.17.2.jar"
AAB_PATH=""
OUTPUT_DIR="."
DEVICE_SPEC_FILE="$OUTPUT_DIR/device-spec.json"
APKS_FILE="$OUTPUT_DIR/app-release.apks"
EXTRACTED_APK_DIR="$OUTPUT_DIR/output"

# Download bundletool if it doesn't exist
if [ ! -f "$BUNDLETOOL_PATH" ]; then
  echo "bundletool.jar not found. Downloading..."
  curl -L -o "$BUNDLETOOL_PATH" "https://github.com/google/bundletool/releases/download/1.17.2/bundletool-all-1.17.2.jar"
  if [ $? -ne 0 ]; then
    echo "Failed to download bundletool. Please check your internet connection and try again."
    exit 1
  fi
  echo "bundletool.jar downloaded successfully."
fi

# Ask if user wants to specify an output path
read -p "Do you want to specify an output path? (yes/no): " user_choice
if [ "$user_choice" = "yes" ]; then
  read -p "Enter the output path: " OUTPUT_DIR
  DEVICE_SPEC_FILE="$OUTPUT_DIR/device-spec.json"
  APKS_FILE="$OUTPUT_DIR/app-release.apks"
  EXTRACTED_APK_DIR="$OUTPUT_DIR/output"
fi

# Prompt for AAB_PATH if it is empty
if [ -z "$AAB_PATH" ]; then
  read -p "Enter the path to the AAB file: " AAB_PATH
fi

# Remove existing files to avoid errors
if [ -f "$DEVICE_SPEC_FILE" ]; then
  rm "$DEVICE_SPEC_FILE"
fi

if [ -f "$APKS_FILE" ]; then
  rm "$APKS_FILE"
fi

if [ -d "$EXTRACTED_APK_DIR" ]; then
  rm -r "$EXTRACTED_APK_DIR"
fi

# Generate Device Spec JSON
java -jar "$BUNDLETOOL_PATH" get-device-spec --output="$DEVICE_SPEC_FILE"

# Build APK Set from AAB
java -jar "$BUNDLETOOL_PATH" build-apks --bundle="$AAB_PATH" --output="$APKS_FILE" --mode=universal

# Extract APKs using Device Spec
java -jar "$BUNDLETOOL_PATH" extract-apks --apks="$APKS_FILE" --output-dir="$EXTRACTED_APK_DIR" --device-spec="$DEVICE_SPEC_FILE"

# Install the Universal APK on Device
adb install "$EXTRACTED_APK_DIR/universal.apk"

echo "APK installed successfully on the device."
