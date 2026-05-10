# Changelog

## [1.1.0] - 2025-01-21

### 🚀 Modern iOS 17+ Evolution

- 🎯 **Dynamic Positioning**: Menus now appear automatically above or below the target widget based on its screen position.
- 💨 **Modern Preview ("Pop" Effect)**: The original widget now stays in its screen position and scales slightly with an elastic animation when opening.
- ➡️ **Trailing Icons**: Icons moved to the right side (Trailing) to match the latest iOS design language.
- 📝 **Subtitles Support**: Added `subtitle` property to `ContextMenuItem` for secondary information.
- 🧊 **Enhanced Glassmorphism**: Added `BackdropFilter` and refined shadows to the menu container for a premium "Glassy" look.
- 🚫 **Disabled States**: Added `enabled` property to `ContextMenuItem` to handle non-interactive actions.
- ♿️ **Full Semantics**: Added proper semantic labels and hints for better accessibility support.
- 📏 **Adaptive Layout**: Refined horizontal centering and vertical spacing for various screen sizes.

## [1.0.9] - 2025-01-20

### 🚀 Major Enhancements & Refactoring

- ⚡️ **Haptic Feedback**: Added iOS-style haptic feedback (`mediumImpact` on open, `lightImpact` on interaction) for a more tactile experience.
- 🏗 **Architecture Core**: Introduced `ColorsManager` and `TextStylesManager` for better theme handling and code maintainability.
- 🔄 **Model Refactoring**: Renamed `ContextMenuAndroid` model to `ContextMenuItem` for better clarity and API naming conventions.
- 🛠 **New `ContextMenuWrapper`**: Added a dedicated wrapper widget to simplify integration. Just wrap your widget and pass actions!
- 🎨 **Adaptive Themes**: Improved dark/light mode detection using `Theme.of(context).brightness` as a fallback.
- ♿️ **Accessibility**: Added `Semantics` support (via standard widgets) and improved focus hierarchy.
- 📜 **Scrollable Menus**: Added `SingleChildScrollView` to the menu panel to prevent overflows on smaller screens or long lists.
- 🧪 **Destructive Actions**: Added explicit `isDestructive` property to `ContextMenuItem` with automatic label-based inference.
- 🧼 **Code Quality**: Switched to `withValues` for colors (Flutter 3.24+ standard) and optimized animation controllers.

---

## [1.0.8] - 2025-01-20

### 🚀 New Features & Enhancements

- 🌫 **New `blurSigma` parameter**: Added `blurSigma` to allow developers to control the intensity of the background blur (default is `10.0`). This gives more flexibility in achieving the desired visual effect.
- 📖 **Documentation Update**: Updated README with detailed customization options and better architecture overview.

---

## [1.0.7] - 2025-12-22

### 🚀 Enhancements & Fixes

- 🎨 **New `backgroundMenuColor` parameter**: Added a new parameter `backgroundMenuColor` to allow customizing the menu's background color independently.
- 🐛 **Fixed `backgroundColor`**: The `backgroundColor` parameter now correctly colors the background of the context menu panel as intended.
- 🧹 **Code Cleanup**: General code cleanup and improvements for better readability and maintainability.
- ⚡️ **Performance & Stability**: Enhanced performance and stability of the package.
- 🎯 **SDK Update**: Updated minimum Dart SDK requirement to **^3.10.4**.

---

## [1.0.6] - 2025-12-05

### 🛠 Bug fixes & Quality Improvements

- 🐛 **Fixed** layout overflow in nested submenus when used inside constrained parents (e.g., `Row`/`Column`) by improving parent-data checks and enforcing proper `Flexible` placement.
- 🧩 **Resolved** animation stutter caused by simultaneous `childController` / `menuController` conflicts — added improved sequencing and cancellation logic.
- ✅ **Guarded** navigation pops with extra `mounted` checks to prevent exceptions when widget tree is being disposed.
- 🔒 **Stabilized** internal state updates to avoid duplicate callbacks on fast successive taps.

### ✨ New Features

- 🔀 **New parameter: `menuAlignment`**
    - Adds flexible control over menu alignment and opening direction (e.g., `left`, `right`, `center`, `start`, `end`).
    - Works with screen-edge detection to flip direction automatically when needed.
    - Example: `ContextMenuAndroid(menuAlignment: MenuAlignment.right)` to force right alignment.

### 🚀 UX & Animation

- 🎞 Improved close animation timing to better match opening velocity (smoother reverse transitions).
- ↔️ Enhanced submenu slide transitions to better respect `menuAlignment` and RTL layouts.
- ✨ Slightly increased backdrop blur radius with adaptive opacity for clearer readability in bright/dark backgrounds.

### 🧭 API & Developer Experience

- 🎯 Updated minimum Dart SDK requirement to **^3.10.1** for improved performance, language features, and compatibility.


- 🧰 Added `MenuAlignment` enum to public API with clear docs and examples.
- 🧾 Updated example app showing `menuAlignment` usage and RTL support example.
- 🧪 Added additional unit tests around submenu stack restoration and alignment flipping.

### 🧹 Code Maintenance

- 🔁 Refactored `getResponsiveSize()` to centralize min/max clamps for consistent behavior across versions.
- 🧼 Removed deprecated internal helpers and improved doc comments (Arabic + English).
- 📦 Minor dependency bumps and lint fixes.

---

## [1.0.5] - 2025-11-05

### 🚀 Major Improvements

#### 🧩 Animation & Performance Enhancements
- ⚙️ **Optimized animation lifecycle** — old `AnimationController` instances are now properly disposed to prevent memory leaks.
- 🕒 Adjusted animation duration dynamically (`min(600, 80 * length)`) for smoother scaling on long action lists.
- 🔁 Added **reverse closing animation** when dismissing the menu for a more natural experience.
- 🧠 Improved animation sequencing between `childController` and `menuController` for iOS-like smooth transitions.

#### 🧭 Submenu UX Improvements
- ➕ Added **visual arrow indicator (`chevron_right`)** for items that contain submenus.
- 🔙 Enhanced back-navigation with animated slide transitions and proper stack restoration.

#### 🎨 UI / Layout Refinements
- 🪟 Added **SafeArea** to protect against notch and gesture areas.
- 🧱 Wrapped long menus in `SingleChildScrollView` with `Flexible` to prevent overflow on small devices.
- 💡 Improved background blur with a subtle dark overlay (`Colors.black.withOpacity(0.15)`) for better contrast.
- ⚖️ Refined menu width and padding using responsive scaling.

#### 🧮 Responsive Design Enhancements
- 📏 Improved `getResponsiveSize()` — now clamps width between `320.0` and `600.0` for better tablet support.
- 📱 Ensures consistent sizing across all devices, maintaining proportional text and padding.

#### 🧰 Codebase Cleanup & Reliability
- ✅ Added defensive checks for mounted state before popping navigation.
- 🧼 Refactored logic to make the widget **production-stable** for large projects.
- 📄 Preserved all inline documentation and bilingual comments for clarity.

---

## [1.0.4] - 2025-07-22

### 🆕 Features

#### 🍔 SubMenu Support
- ✅ Added support for nested `subMenu` items in context menu.
- 📱 Submenus open with **iOS-style sliding animation**.
- 🔙 Includes automatic "Back" button and navigation stack handling.
- 🎯 Fully animated using `AnimatedSwitcher` with slide transitions.
- 📦 Seamless integration with existing `ContextMenuAndroid` actions.

---

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
