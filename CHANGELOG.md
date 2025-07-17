# Changelog

## [1.0.2] - 2025-07-17

### ✅ Fixes & Improvements

- ✅ **Improved widget API**: `iOSStyleContextMenu` is now a stateless functional widget for cleaner syntax.
- 🧱 **Switched to `AnimatedScale`** instead of `StatefulWidget` for smooth scaling transitions.
- 🔁 **Optimized action builder** using `List.generate()` to reduce boilerplate.
- 🎨 **Customization options added**:
    - `backgroundColor`
    - `dividerColor`
    - `iconColor`
    - `textStyle`
    - `contentPadding`
- 🗑 **Smart delete detection**: automatically highlights delete actions with red, bold text.
- 🧪 **Test coverage**: Added unit tests with `flutter_test`.
- 📚 Enhanced inline documentation and comments.
- 🧩 Updated example app to reflect new customization features and API usage.

---

## [1.0.1] - 2025-07-17

🎉 Initial release of `ContextMenuAndroid` — an iOS-style context menu for Android built using Flutter.

### ✨ Highlights

- iOS-style context menu with blurred background.
- Customizable actions with support for icons, colors, and labels.
- Dark mode support.
- Delete actions are highlighted automatically.
- Responsive and smooth UI animations.
- Easily integratable with any widget.

### 🛠 Improvements

- Enabled full **null safety**.
- Optimized widget trees using `const` constructors for better performance.
- Enhanced **linter rules** in `analysis_options.yaml` to follow best practices.
- Refactored code for readability and maintainability.
- Added example image hosted via GitHub for consistent preview on pub.dev.

---

## [0.0.1] - 2025-07-16

- 🎉 Initial draft release of `ContextMenuAndroid` package.
- Added basic iOS-style blurred context menu.
- Supports customizable actions (icon, label, onTap).
- Initial design implementation with shadow and animation support.
