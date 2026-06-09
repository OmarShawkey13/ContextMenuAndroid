# 🍎 Context Menu Android

A **Flutter package** that brings the elegant **iOS-style context menu** experience to **Android** — complete with blur effects, fluid animations, and nested sub-menus.  
Perfect for creating beautiful **long-press menus** on any widget, such as cards, images, or list items — all with the finesse of Apple design.

<p align="center">
  <img src="https://raw.githubusercontent.com/OmarShawkey13/ContextMenuAndroid/main/assets/images/example.png" width="270" alt="iOS-style context menu on Android"/>
  &nbsp;&nbsp;&nbsp;&nbsp;
  <img src="https://raw.githubusercontent.com/OmarShawkey13/ContextMenuAndroid/main/assets/images/preview.gif" width="270" alt="iOS-style context menu animation"/>
</p>

---

## ✨ Features (v1.2.0)

| Feature                        | Description                                                                           |
|--------------------------------|---------------------------------------------------------------------------------------|
| 🍏 **True iOS 17+ Feel**       | Replicates the latest iOS smooth interaction, animations, and visual hierarchy.       |
| 🎯 **Dynamic Positioning**     | Menus automatically appear **above or below** the widget based on screen space.       |
| 💨 **Modern Preview (Pop)**    | The target widget stays in place and scales with a smooth elastic "Pop" effect.       |
| 🧊 **Glassmorphism UI**        | Real-time background blur and refined shadows for a premium glassy look.              |
| 📳 **Haptic Feedback**         | Built-in tactile feedback (vibration) on opening and interaction.                     |
| 🛠 **Easy Wrapper**            | `ContextMenuWrapper` widget for effortless integration in seconds.                    |
| 🪄 **Native Sub-Menus**        | Sub-menus smoothly pan horizontally with dynamic height resizing for a true iOS feel. |
| 🌗 **Adaptive Themes**         | Automatically detects system theme or use `isDark` to override.                       |
| 🧠 **Smart Actions**           | Supports **Subtitles**, **Disabled states**, and **Destructive** (red) styling.       |
| 📱 **Scrollable & Responsive** | Menus are scrollable for long lists and adapt to all screen sizes perfectly.          |
| ♿️ **Accessibility**           | Full `Semantics` support for screen readers and inclusive design.                     |

---

## 🚀 Getting Started

Add to your project's `pubspec.yaml`:

```yaml
dependencies:
  context_menu_android: ^1.2.0
```

Import it in your code:

```dart
import 'package:context_menu_android/context_menu_android.dart';
```

---

## 🧠 Basic Usage (The Easy Way)

Simply wrap your widget with `ContextMenuWrapper`:

```dart
ContextMenuWrapper(
  child: Image.network('https://picsum.photos/200'),
  actions: [
    ContextMenuItem(
      icon: Icons.share,
      label: 'Share',
      subtitle: 'Send link to others',
      onTap: () => print('Shared!'),
    ),
    ContextMenuItem(
      icon: Icons.copy,
      label: 'Copy',
      onTap: () => print('Copied!'),
    ),
    ContextMenuItem(
      icon: Icons.delete,
      label: 'Delete', 
      subtitle: 'Permanent action',
      isDestructive: true, // Highlights in red
      onTap: () => print('Deleted!'),
    ),
  ],
);
```

---

## 🌿 Advanced Example with Sub-Menus

```dart
ContextMenuWrapper(
  child: Card(
    child: ListTile(
      leading: Icon(Icons.movie),
      title: Text('Inception'),
    ),
  ),
  actions: [
    ContextMenuItem(
      icon: Icons.play_arrow,
      label: 'Play',
      onTap: () => print('Playing...'),
    ),
    ContextMenuItem(
      icon: Icons.more_horiz,
      label: 'More',
      subMenu: [
        ContextMenuItem(
          icon: Icons.info_outline,
          label: 'Details',
          onTap: () => print('Opening details...'),
        ),
        ContextMenuItem(
          icon: Icons.download,
          label: 'Download',
          subtitle: 'HD Quality',
          onTap: () => print('Downloading...'),
        ),
      ],
    ),
  ],
);
```

---

## ⚙️ Customization Options

### `ContextMenuWrapper`

| Property              | Type                    | Description                                                           |
|-----------------------|-------------------------|-----------------------------------------------------------------------|
| `child`               | `Widget`                | **Required.** The widget that triggers the context menu.              |
| `actions`             | `List<ContextMenuItem>` | **Required.** A list of action items.                                 |
| `childBorderRadius`   | `BorderRadiusGeometry?` | Border radius of the cloned preview. Defaults to `BorderRadius.zero`. |
| `isDark`              | `bool?`                 | Forces dark mode (if not set, it follows system theme).               |
| `blurSigma`           | `double?`               | Controls the intensity of the background blur (default: 10).          |
| `backgroundMenuColor` | `Color?`                | Background color of the menu container itself.                        |
| `iconColor`           | `Color?`                | Default color for icons.                                              |
| `textStyle`           | `TextStyle?`            | Custom text style for action labels.                                  |
| `menuAlignment`       | `AlignmentGeometry?`    | Alignment of the menu relative to the child (Start/Center/End)        |

### `ContextMenuItem`

| Property        | Type                     | Description                                               |
|-----------------|--------------------------|-----------------------------------------------------------|
| `icon`          | `IconData`               | **Required.** The icon displayed next to the label.       |
| `label`         | `String`                 | **Required.** The main text for the action.               |
| `subtitle`      | `String?`                | Optional secondary text below the label.                  |
| `onTap`         | `VoidCallback?`          | Function executed when the action is tapped.              |
| `subMenu`       | `List<ContextMenuItem>?` | Optional list of items for a nested menu.                 |
| `isDestructive` | `bool?`                  | If true, colors the item red. Auto-detected for "Delete". |
| `enabled`       | `bool`                   | If false, the item is greyed out and non-interactive.     |

---

## 🧱 Architecture Overview

The project follows a Clean Architecture inspired structure:

```
lib/
├── core/
│   └── theme/                  # Color and Text Style managers
└── features/
    └── context_menu/
        ├── data/
        │   └── models/
        │       └── context_menu_item.dart    # Data model for actions
        └── presentation/
            ├── screen/
            │   └── ios_style_context_menu.dart # Main overlay widget
            ├── utils/
            │   └── responsive_size.dart        # Sizing utilities
            └── widget/
                ├── context_menu_wrapper.dart   # Easy integration widget
                ├── context_menu_panel.dart     # Menu container
                ├── context_menu_child.dart     # Animated preview widget
                └── ...
```

---

## 📄 License

This project is licensed under the [MIT License](https://github.com/OmarShawkey13/ContextMenuAndroid/blob/main/LICENSE).

---

## ❤️ Credits

Developed and maintained with 💙 by  
**[Omar Shawkey](https://github.com/OmarShawkey13)**
