#!/bin/bash

# Test script for iOS Permission Localization
# This script helps verify that the InfoPlist.strings files are correctly formatted

echo "🔍 Testing iOS Permission Localization Setup..."
echo ""

# Check if localization directories exist
if [ -d "Runner/en.lproj" ]; then
    echo "✅ English localization directory exists"
else
    echo "❌ English localization directory missing"
    exit 1
fi

if [ -d "Runner/ar.lproj" ]; then
    echo "✅ Arabic localization directory exists"
else
    echo "❌ Arabic localization directory missing"
    exit 1
fi

# Check if InfoPlist.strings files exist
if [ -f "Runner/en.lproj/InfoPlist.strings" ]; then
    echo "✅ English InfoPlist.strings file exists"
else
    echo "❌ English InfoPlist.strings file missing"
    exit 1
fi

if [ -f "Runner/ar.lproj/InfoPlist.strings" ]; then
    echo "✅ Arabic InfoPlist.strings file exists"
else
    echo "❌ Arabic InfoPlist.strings file missing"
    exit 1
fi

# Check if Info.plist has the correct variable substitution format
if grep -q '$(NSCameraUsageDescription)' Runner/Info.plist; then
    echo "✅ Info.plist uses variable substitution for NSCameraUsageDescription"
else
    echo "❌ Info.plist does not use variable substitution for NSCameraUsageDescription"
fi

if grep -q '$(NSPhotoLibraryUsageDescription)' Runner/Info.plist; then
    echo "✅ Info.plist uses variable substitution for NSPhotoLibraryUsageDescription"
else
    echo "❌ Info.plist does not use variable substitution for NSPhotoLibraryUsageDescription"
fi

# Verify that unused permission keys are NOT present
if ! grep -q 'NSUserTrackingUsageDescription' Runner/Info.plist; then
    echo "✅ NSUserTrackingUsageDescription correctly removed (not needed)"
else
    echo "⚠️  NSUserTrackingUsageDescription still present (may cause App Store issues)"
fi

if ! grep -q 'NSLocationWhenInUseUsageDescription' Runner/Info.plist; then
    echo "✅ NSLocationWhenInUseUsageDescription correctly removed (not needed)"
else
    echo "⚠️  NSLocationWhenInUseUsageDescription still present (may cause App Store issues)"
fi

# Check for Arabic content in Arabic InfoPlist.strings
if grep -q "نحتاج إلى الوصول" Runner/ar.lproj/InfoPlist.strings; then
    echo "✅ Arabic InfoPlist.strings contains Arabic text"
else
    echo "❌ Arabic InfoPlist.strings does not contain Arabic text"
fi

echo ""
echo "🎯 Localization setup verification complete!"
echo ""
echo "📱 To test on device:"
echo "1. Build and install the app on an iOS device/simulator"
echo "2. Change device language to Arabic (Settings → General → Language & Region)"
echo "3. Trigger a permission request (camera, photo library, etc.)"
echo "4. Verify the permission dialog shows Arabic text"
echo "5. Change device language back to English and test again"
echo ""
echo "🔧 If localization doesn't work:"
echo "1. Open ios/Runner.xcworkspace in Xcode"
echo "2. Select the Runner project → Project Info → Localizations"
echo "3. Add Arabic localization if not present"
echo "4. Clean and rebuild the project" 