# iOS Permission Localization Setup

## Overview
This document explains how iOS permission prompts are now localized to support both English and Arabic languages.

## Setup

### 1. Localization Structure
The following directory structure has been created:

```
ios/Runner/
├── en.lproj/
│   └── InfoPlist.strings
├── ar.lproj/
│   └── InfoPlist.strings
└── Info.plist
```

### 2. InfoPlist.strings Files

#### English (`ios/Runner/en.lproj/InfoPlist.strings`)
Contains English translations for all permission usage descriptions.

#### Arabic (`ios/Runner/ar.lproj/InfoPlist.strings`)
Contains Arabic translations for all permission usage descriptions.

### 3. Info.plist Configuration
The `Info.plist` file now references the localized strings using variable substitution:

```xml
<key>NSCameraUsageDescription</key>
<string>$(NSCameraUsageDescription)</string>
```

## Supported Permissions

The following permissions are now localized:

1. **Camera** (`NSCameraUsageDescription`)
   - English: "This app needs access to your camera to let you upload photos on your account"
   - Arabic: "نحتاج إلى الوصول إلى الكاميرا لتمكينك من التقاط الصور."

2. **Photo Library** (`NSPhotoLibraryUsageDescription`)
   - English: "This app needs access to your photo library to let you upload photos on your account"
   - Arabic: "نحتاج إلى الوصول إلى مكتبة الصور لاختيار صورة."

3. **Photo Library Add** (`NSPhotoLibraryAddUsageDescription`)
   - English: "This app needs access to your photo library to let you upload photos on your account"
   - Arabic: "نحتاج إلى الوصول إلى مكتبة الصور لحفظ الصور."

4. **Microphone** (`NSMicrophoneUsageDescription`)
   - English: "Your app needs access to the microphone to record audio."
   - Arabic: "نحتاج إلى الوصول إلى الميكروفون لتسجيل الصوت."

5. **Apple Music/Media Library** (`NSAppleMusicUsageDescription`)
   - English: "This app needs access to your photo library to let you upload photos on your account"
   - Arabic: "نحتاج إلى الوصول إلى مكتبة الصور لرفع الصور على حسابك."

6. **Motion** (`NSMotionUsageDescription`)
   - English: "Motion usage description"
   - Arabic: "نحتاج إلى الوصول إلى حساسات الحركة لتتبع نشاطك البدني."

## Removed Permissions

The following permission keys were **removed** because the app doesn't use the corresponding APIs:

- **NSLocationWhenInUseUsageDescription** - Removed because the app doesn't use location services
- **NSUserTrackingUsageDescription** - Removed because the app doesn't use tracking/advertising identifiers (IDFA)

> **Important**: Including unused permission keys in Info.plist will cause App Store Connect warnings and rejection. Only include permissions your app actually uses.

## How It Works

1. **Language Detection**: iOS automatically detects the device language
2. **String Resolution**: When a permission is requested, iOS looks for the corresponding `InfoPlist.strings` file based on the device language
3. **Fallback**: If the device language is not supported, iOS falls back to the default language (English)

## Testing

To test the localization:

1. **English**: Set device language to English
   - Go to Settings → General → Language & Region → iPhone Language
   - Select English
   - Trigger any permission request

2. **Arabic**: Set device language to Arabic
   - Go to Settings → General → Language & Region → iPhone Language
   - Select العربية (Arabic)
   - Trigger any permission request

## Important Notes

1. **Xcode Project Configuration**: You may need to add the Arabic localization in Xcode:
   - Open `ios/Runner.xcworkspace` in Xcode
   - Select the Runner project
   - Go to Project Info → Localizations
   - Add Arabic if not already present

2. **Build Clean**: After adding localization files, clean and rebuild:
   ```bash
   flutter clean
   cd ios
   rm -rf Pods/ Podfile.lock
   cd ..
   flutter pub get
   cd ios
   pod install
   cd ..
   flutter run
   ```

3. **File Encoding**: Make sure all `.strings` files are saved in UTF-8 encoding to properly display Arabic text.

## Maintenance

When adding new permission types:

1. Add the key to `Info.plist` with variable substitution: `$(YourNewKey)`
2. Add the English translation to `en.lproj/InfoPlist.strings`
3. Add the Arabic translation to `ar.lproj/InfoPlist.strings`
4. Test on both English and Arabic devices 