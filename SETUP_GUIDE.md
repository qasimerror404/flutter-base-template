# Setup Guide 🚀

Follow these steps to set up the Flutter Core template for your new project.

## Step 1: Initial Setup

### 1.1 Copy Template
```bash
# Copy the template to your new project directory
cp -r flutter_core your_project_name
cd your_project_name
```

### 1.2 Install Dependencies
```bash
flutter pub get
```

## Step 2: Generate Required Files

### 2.1 Generate Localization Files
```bash
flutter gen-l10n
```

This will generate:
- `lib/.dart_tool/flutter_gen/gen_l10n/app_localizations.dart`
- `lib/.dart_tool/flutter_gen/gen_l10n/app_localizations_en.dart`
- `lib/.dart_tool/flutter_gen/gen_l10n/app_localizations_ar.dart`

### 2.2 Generate Isar Database Schemas
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

This will generate:
- `lib/core/providers/theme_provider.g.dart` (for AppSettings collection)
- `lib/features/products/data/models/product_model.g.dart`

**Note:** You'll see warnings about generated files - this is normal!

## Step 3: Add Custom Fonts

### 3.1 Add Your Font Files
Place your font files in `assets/fonts/`:
```
assets/fonts/
├── custom_font_regular.ttf
├── custom_font_medium.ttf
├── custom_font_semibold.ttf
└── custom_font_bold.ttf
```

### 3.2 Update Font Names
If you're using different font names, update `pubspec.yaml`:

```yaml
fonts:
  - family: YourFontName  # Change this
    fonts:
      - asset: assets/fonts/your_font_regular.ttf
        weight: 400
      - asset: assets/fonts/your_font_bold.ttf
        weight: 700
```

And update `lib/core/theme/app_theme.dart`:
```dart
fontFamily: 'YourFontName',  // Change this
```

## Step 4: Configure App Details

### 4.1 Update Package Name
Update the package name in:
- `pubspec.yaml` - change `name: flutter_core`
- Android: `android/app/build.gradle.kts` - change `applicationId`
- iOS: Update in Xcode

Or use a package:
```bash
flutter pub add change_app_package_name --dev
flutter pub run change_app_package_name:main com.your.package
```

### 4.2 Update App Name
Update in localization files:
- `lib/l10n/app_en.arb` - change `appName`
- `lib/l10n/app_ar.arb` - change `appName`

Then regenerate:
```bash
flutter gen-l10n
```

### 4.3 Update API URLs
In `lib/core/config/env_config.dart`:

```dart
static String get apiBaseUrl {
  switch (_current) {
    case Environment.dev:
      return 'https://api-dev.yourapp.com';  // Your dev API
    case Environment.prod:
      return 'https://api.yourapp.com';      // Your prod API
  }
}
```

## Step 5: Add App Icon & Splash Screen

### 5.1 Install Packages
```bash
flutter pub add flutter_launcher_icons --dev
flutter pub add flutter_native_splash --dev
```

### 5.2 Add Icon File
Place your app icon at `assets/icons/app_icon.png` (1024x1024)

### 5.3 Configure Icon
Add to `pubspec.yaml`:
```yaml
flutter_launcher_icons:
  android: true
  ios: true
  image_path: "assets/icons/app_icon.png"
```

Generate icons:
```bash
flutter pub run flutter_launcher_icons
```

### 5.4 Configure Splash Screen
Add to `pubspec.yaml`:
```yaml
flutter_native_splash:
  color: "#6750A4"  # Your primary color
  image: assets/icons/splash_icon.png
```

Generate splash:
```bash
flutter pub run flutter_native_splash:create
```

## Step 6: Firebase Setup (Optional)

If you want to add Firebase:

### 6.1 Install Firebase CLI
```bash
npm install -g firebase-tools
dart pub global activate flutterfire_cli
```

### 6.2 Login and Configure
```bash
firebase login
flutterfire configure
```

### 6.3 Uncomment Firebase Code
Uncomment Firebase-related code in:
- `lib/core/services/notification_service.dart`
- Add Firebase packages to `pubspec.yaml`

## Step 7: Test the App

### 7.1 Run the App
```bash
# Dev mode
flutter run

# Prod mode (update env in main.dart first)
flutter run --release
```

### 7.2 Verify Features
- ✅ Bottom navigation works
- ✅ Products page loads (from FakeStore API)
- ✅ Theme switching works
- ✅ Language switching works
- ✅ Add/Edit product works
- ✅ Favorites work
- ✅ Offline mode works (turn off network)

## Step 8: Clean Up Template Code

### 8.1 Remove Example Feature (Optional)
If you don't need the Products example:
```bash
rm -rf lib/features/products
rm -rf lib/features/favorites
```

Then remove related routes from `lib/core/router/app_router.dart`.

### 8.2 Update README
Replace `README.md` with your project-specific README.

## Common Issues & Solutions

### Issue: "AppSettings not found"
**Solution:** Run code generation:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Issue: "AppLocalizations not found"
**Solution:** Generate localization files:
```bash
flutter gen-l10n
```

### Issue: "Font not found"
**Solution:** 
1. Make sure font files exist in `assets/fonts/`
2. Make sure `pubspec.yaml` has correct font configuration
3. Run `flutter pub get`

### Issue: Isar error on first run
**Solution:** Delete app and reinstall:
```bash
flutter clean
flutter pub get
flutter run
```

### Issue: Build runner conflicts
**Solution:**
```bash
flutter pub run build_runner clean
flutter pub run build_runner build --delete-conflicting-outputs
```

## Development Workflow

### Making Changes to Models
After changing Isar models or localization:
```bash
# Regenerate everything
flutter pub run build_runner build --delete-conflicting-outputs
flutter gen-l10n
```

### Adding New Translations
1. Edit `lib/l10n/app_en.arb` and `lib/l10n/app_ar.arb`
2. Run `flutter gen-l10n`
3. Restart app

### Testing on Real Devices
```bash
# List devices
flutter devices

# Run on specific device
flutter run -d device_id
```

## Next Steps

1. ✅ Complete setup steps above
2. ✅ Test all features
3. ✅ Start building your features following the clean architecture pattern
4. ✅ Replace FakeStore API with your actual backend
5. ✅ Add authentication if needed
6. ✅ Write tests
7. ✅ Configure CI/CD
8. ✅ Deploy!

## Need Help?

- Check `README.md` for detailed documentation
- Review example code in `lib/features/products/`
- Read clean architecture resources
- Check Flutter & Riverpod documentation

---

**You're all set! Happy coding! 🎉**

