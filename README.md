# AAB to APK Conversion Script

This script automates the process of converting an Android App Bundle (AAB) to an APK and installing it on a connected device. It uses `bundletool` to perform the conversion steps and `adb` to install the APK on a physical device. This version also includes a feature to download `bundletool` if it does not exist locally.

## Prerequisites

- **Java**: Make sure Java is installed. You can verify by running `java -version`.
- **ADB (Android Debug Bridge)**: Ensure ADB is installed and available in your system's PATH.

## Setup

1. **Clone or Copy the Script**: Place the script (`run.sh`) in a convenient location on your machine.

2. **Make the Script Executable**:
   ```sh
   chmod +x /path/to/run.sh
   ```

3. **Add an Alias (Optional)**:
   To make it easier to run the script, you can create an alias. Add the following line to your `.bashrc`, `.zshrc`, or equivalent shell configuration file:
   ```sh
   alias run_aab_to_device="/path/to/run.sh"
   ```
   Then, run:
   ```sh
   source ~/.zshrc
   ```

## Usage

To run the script, use the following command:
```sh
./run.sh
```
Or, if you have set up the alias:
```sh
run_aab_to_device
```

### Script Steps
1. **Check for `bundletool`**: If `bundletool-all-1.17.2.jar` does not exist in the current directory, the script will automatically download it from the official GitHub repository.
2. **Ask for Output Path (Optional)**: The script will ask if you want to specify an output directory for the generated files. If you choose "yes", you'll need to enter the desired path.
3. **Prompt for AAB Path**: If the AAB path is not set in the script, it will prompt you to enter the path to the AAB file.
4. **Remove Existing Files**: To avoid errors, the script removes any existing files for the device spec, APK set, and extracted APKs.
5. **Generate Device Spec JSON**: The script generates a JSON file that describes the connected device.
6. **Build APK Set from AAB**: The script uses `bundletool` to create an APK set from the provided AAB.
7. **Extract APKs**: The APKs are extracted from the APK set, and a universal APK is created.
8. **Install APK**: Finally, the script installs the generated universal APK onto the connected device.

## Notes
- Make sure the device is connected and recognized by ADB before running the script. You can verify the device connection by running:
  ```sh
  adb devices
  ```
- The default output path for generated files is the current directory where the script is run.
- Ensure that the paths specified in the script (e.g., `BUNDLETOOL_PATH`, `AAB_PATH`) are updated to match your environment.
- If you do not specify an output path during execution, the default output path (`.`) will be used.

## Author
- **Faustin Kagabo**: [GitHub Profile](https://github.com/kagabof)

## Troubleshooting
- **File Already Exists**: If you encounter errors about files already existing, the script automatically removes previous files before running.
- **ADB Not Recognized**: Ensure that ADB is installed and properly configured in your PATH.
- **Java Errors**: Make sure Java is installed and accessible from the command line.
- **Bundletool Download Issues**: If the script fails to download `bundletool`, ensure you have a stable internet connection.

