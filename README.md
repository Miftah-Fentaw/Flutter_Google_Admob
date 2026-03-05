# Flutter AdMob Pro Integration

![Flutter AdMob Pro Header](admob_flutter_header.png)

A comprehensive, modular Flutter application demonstrating advanced Google AdMob integrations. This project supports both **Android** and **iOS** and includes a secure configuration system for production credentials.

## ✨ Key Features

- **🛡️ Modular Architecture**: Ad logic is cleanly separated from the UI for maximum maintainability.
- **📱 Comprehensive Ad Formats**:
  - **Banner Ads**: Persistent at the bottom of all screens.
  - **Interstitial Ads**: Shown during navigation transitions.
  - **Rewarded Ads**: Reward-gated content logic.
  - **Native Ads**: Integrated seamlessly into list views (Medium Rectangle style).
  - **App Open Ads**: Managed by `AppOpenAdManager`, triggering on app startup and resume.
  - **Rewarded Interstitial Ads**: Quick reward access on specific screens.
- **🔒 Secure Credentials**: Built-in system to prevent production IDs from being committed to public repositories.
- **🛠️ Cross-Platform**: Fully configured for both Android and iOS with ATT compliance and SKAdNetwork identifiers.

## 🚀 Getting Started

### 1. Prerequisites

- Flutter SDK (Latest Version)
- Android Studio / VS Code
- AdMob Account

### 2. Configure Credentials

This project uses a secure configuration system:

1. Copy `lib/ads/ad_config.dart.example` to `lib/ads/ad_config.dart`.
2. Fill in your real AdMob IDs in `lib/ads/ad_config.dart`.
3. Note: `lib/ads/ad_config.dart` is ignored by `.gitignore` to keep your keys private.

### 3. Setup Android

- Update `GADApplicationIdentifier` in `android/app/src/main/AndroidManifest.xml`.
- Ensure your `testDeviceIds` are configured in `lib/main.dart` if testing on real hardware.

### 4. Setup iOS

- Update `GADApplicationIdentifier` and `NSUserTrackingUsageDescription` in `ios/Runner/Info.plist`.
- The project includes 30+ SKAdNetwork identifiers for optimal attribution.

## 🧪 Testing

To verify the UI and logic immediately, utilize the `useTestAds` flag:

```dart
// lib/ads/ad_helper.dart
static const bool useTestAds = true; // Set to false for production
```

## 🏗️ Architecture

- `lib/ads/`: Ad management classes (`AdHelper`, `AppOpenAdManager`).
- `lib/screens/`: Individual modular screen implementations.
- `lib/widgets/`: Reusable UI components including the `MainScaffold`.

---

_Managed and maintained by Antigravity_
