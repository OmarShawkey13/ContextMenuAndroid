# Changelog

## [1.0.3] - 2025-07-18

### 🎯 Enhancements

#### 📏 Responsive Sizing Added
- ✅ New `textSize` and `iconSize` properties allow for per-device scaling.
- ✅ Sizes are automatically adjusted using `getResponsiveSize()` to match screen width for consistent appearance across devices.

#### 🧠 Smarter Style Composition
- ✨ Introduced `getTextStyle()` helper to merge user-defined `textStyle` with fallback logic and responsive sizing.
- ✨ Introduced `getIconColor()` for consistent icon coloring logic (including automatic detection of delete actions).

#### 🧾 Internal Improvements
- 💬 Added inline documentation and bilingual comments (Arabic + English) for better clarity and future maintenance.
- 📦 Padding is now responsive by default using `getResponsiveSize()` (e.g., horizontal padding `16 → getResponsiveSize(16)`).

---

## [1.0.2] - 2025-07-17

### ✅ Fixes & Improvements

- 🧼 **API Refactor**: `iOSStyleContextMenu` is now a stateless functional widget for cleaner syntax.
- 🔁 **Smooth Transitions**: Replaced `StatefulWidget` with `AnimatedScale` for animation.
- ⚙️ **Action Builder Optimization**: Utilized `List.generate()` to streamline context menu actions.
- 🎨 **Customization Enhancements**:
  - `backgroundColor`
  - `dividerColor`
  - `iconColor`
  - `textStyle`
  - `contentPadding`
- 🗑 **Smart Delete Detection**: Automatically highlights delete actions with red, bold text.
- 🧪 **Testing**: Added unit tests using `flutter_test`.
- 📚 **Documentation**: Improved inline comments and updated the example app to reflect new features.

---

## [1.0.1] - 2025-07-17

🎉 Initial release of `ContextMenuAndroid` — an iOS-style context menu for Android built using Flutter.

### ✨ Features

- iOS-style blurred context menu.
- Customizable actions with icons, labels, and colors.
- Smart delete detection.
- Dark mode support.
- Smooth and responsive UI animations.
- Easily embeddable in any widget.

### 🛠 Technical Improvements

- ✅ Enabled full **null safety**.
- ✅ Optimized with `const` constructors for performance.
- ✅ Enforced strong linter rules via `analysis_options.yaml`.
- ✅ Refactored code for readability and reusability.
- ✅ Included preview image hosted on GitHub for `pub.dev` display.

---

## [0.0.1] - 2025-07-16

- 🧪 First draft release of `ContextMenuAndroid` package.
- 🎨 Basic iOS-style blurred context menu implementation.
- 🧩 Supports customizable icons, labels, and actions.
- 🎬 Initial animation, shadow, and structure setup.
