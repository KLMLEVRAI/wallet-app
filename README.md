# Flutter Crypto Wallet

A complete cross-platform crypto wallet app built with Flutter.

## Features

- Create new wallet with seed phrase
- Import wallet from private key or seed phrase
- View balance
- Send and receive crypto
- Transaction history
- Basic security settings

## Getting Started

1. Install Flutter: https://flutter.dev/docs/get-started/install
2. Clone or copy the `flutter_wallet` folder.
3. Run `flutter pub get` in the project directory.
4. Run `flutter run` to start on emulator/simulator.

## Building APK (Android)

On Windows, you can build APK:

1. Connect an Android device or start emulator.
2. Run `flutter build apk`
3. The APK will be in `build/app/outputs/flutter-apk/app-release.apk`

## Building for iOS

### Option 1: Using macOS locally
1. On macOS, run `flutter build ios`
2. Open the project in Xcode: `open ios/Runner.xcworkspace`
3. Build and archive in Xcode to get IPA.

### Option 2: Using Codemagic (Cloud Build)
You can build iOS IPA without macOS using Codemagic CI/CD:

#### Setup GitHub Repo:
1. Go to https://github.com and create a new repository
2. Copy the `flutter_wallet` folder contents to a local git repo:
   ```
   git init
   git add .
   git commit -m "Initial commit"
   git branch -M main
   git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git
   git push -u origin main
   ```

#### Codemagic Setup:
1. Sign up at https://codemagic.io/
2. Connect your GitHub account
3. Select the repo you just created
4. Codemagic will detect the `codemagic.yaml` file and use it for build configuration
5. For iOS signing, you'll need to add certificates/keys in Codemagic settings
6. Start a build - it will compile the IPA remotely and provide download link

The `codemagic.yaml` file is already configured for iOS release build.

This allows compiling iOS apps on Windows via cloud service.

## Notes

- This is a simulated wallet. For real crypto, integrate with web3 libraries.
- Balances and transactions are mocked.