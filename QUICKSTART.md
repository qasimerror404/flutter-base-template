# Quick Start Guide ⚡

Get your Flutter Core template up and running in 5 minutes!

## Prerequisites ✅

- Flutter SDK (3.11.0+)
- Dart SDK  
- VS Code or Android Studio

## Quick Setup (3 Steps)

### Step 1: Install Dependencies
```bash
cd /Users/qasimabbas/flutter_projects/flutter_core
flutter pub get
```

### Step 2: Generate Required Files
```bash
# Generate localization
flutter gen-l10n

# Generate Isar database schemas
flutter pub run build_runner build --delete-conflicting-outputs
```

### Step 3: Run the App
```bash
flutter run
```

That's it! The app should now be running. 🎉

## What You'll See

✅ **Bottom Navigation** with 4 tabs:
- Home (Welcome screen)
- Products (CRUD example using FakeStore API)
- Favorites (Saved products)
- Profile (Settings, theme, language)

✅ **Features to Try:**
1. Browse products (fetched from https://fakestoreapi.com)
2. Search products
3. Add products to favorites
4. Switch between light/dark theme
5. Switch between English/Arabic
6. Turn off internet to see offline mode
7. Add/edit/delete products

## Troubleshooting

### "AppSettings not found" error
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### "AppLocalizations not found" error
```bash
flutter gen-l10n
```

### Font not loading
The placeholder font files are empty. Replace them with real fonts or comment out font configuration in `pubspec.yaml` temporarily.

### Isar error on first run
```bash
flutter clean
flutter pub get
flutter run
```

## Next Steps 🚀

1. **Read the Documentation**
   - Check `README.md` for full documentation
   - Check `SETUP_GUIDE.md` for detailed setup

2. **Customize the Template**
   - Update app name
   - Add your app icon
   - Replace fonts
   - Update colors in `lib/core/constants/app_colors.dart`

3. **Connect Your Backend**
   - Update API URLs in `lib/core/config/env_config.dart`
   - Replace FakeStore API with your endpoints

4. **Start Building**
   - Follow the Products feature as an example
   - Use clean architecture pattern
   - Add your own features

## Project Structure Overview

```
lib/
├── core/              # Shared code (theme, network, services, etc.)
├── features/          # Feature modules (clean architecture)
│   ├── home/
│   ├── products/      # 👈 Example feature - Study this!
│   ├── favorites/
│   └── profile/
├── l10n/              # Localization files
└── main.dart          # App entry point
```

## Key Files to Check

- `lib/main.dart` - App initialization
- `lib/core/config/env_config.dart` - Environment config
- `lib/core/router/app_router.dart` - Routing setup
- `lib/core/theme/app_theme.dart` - Theme configuration
- `lib/features/products/` - Complete example feature

## Useful Commands

```bash
# Run app
flutter run

# Run tests
flutter test

# Generate code
flutter pub run build_runner build --delete-conflicting-outputs

# Generate localization
flutter gen-l10n

# Clean build
flutter clean

# Get dependencies
flutter pub get

# Check for updates
flutter pub outdated
```

## Need Help?

- 📖 Read `README.md` for detailed docs
- 📋 Check `SETUP_GUIDE.md` for setup help
- 💡 Study `lib/features/products/` for examples
- 🐛 Check troubleshooting section above

---

**Happy Coding! 🎉**

You now have a production-ready Flutter template with:
✅ Clean Architecture
✅ Offline-first with Isar
✅ State management with Riverpod
✅ Material Design 3 themes
✅ Multi-language support
✅ Responsive design
✅ And much more!

Start building your amazing app! 🚀

