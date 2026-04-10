# 🍎 Context Menu Android

A **Flutter package** that brings the elegant **iOS-style context menu** experience to **Android** — complete with blur effects, fluid animations, and nested sub-menus.  
Perfect for creating beautiful **long-press menus** on any widget, such as cards, images, or list items — all with the finesse of Apple design.

<p align="center">
  <img src="https://raw.githubusercontent.com/OmarShawkey13/ContextMenuAndroid/main/assets/images/example.jpg" width="270" alt="iOS-style context menu on Android"/>
</p>

---

## ✨ Features (v1.0.9)

| Feature                       | Description                                                                         |
|-------------------------------|-------------------------------------------------------------------------------------|
| 🍏 **True iOS Feel**          | Replicates iOS’s smooth context menu interaction, animations, and visual hierarchy. |
| 📳 **Haptic Feedback**        | Built-in tactile feedback (vibration) on opening and interaction.                  |
| 🛠 **Easy Wrapper**            | New `ContextMenuWrapper` widget for effortless integration.                        |
| 💫 **Smooth Transitions**     | Powered by Flutter animations and `BackdropFilter` for silky blur effects.          |
| 🪄 **Nested Menus Support**   | Easily create sub-menus with back navigation — ideal for complex actions.           |
| 🌗 **Adaptive Themes**        | Automatically detects system theme or use `isDark` to override.                     |
| 🧠 **Smart Destructive Actions** | Explicit `isDestructive` property or automatic "Delete" keyword detection.         |
| 📱 **Scrollable & Responsive** | Menus are now scrollable and adapt to all screen sizes perfectly.                  |

---

## 🚀 Getting Started

Add to your project's `pubspec.yaml`:

```yaml
dependencies:
  context_menu_android: ^1.0.9
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
      onTap: () => print('Shared!'),
    ),
    ContextMenuItem(
      icon: Icons.delete,
      label: 'Delete', 
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
          onTap: () => print('Downloading...'),
        ),
      ],
    ),
  ],
);
```

---

## ⚙️ Customization Options (`ContextMenuWrapper`)

| Property              | Type                       | Description                                                                |
|-----------------------|----------------------------|----------------------------------------------------------------------------|
| `child`               | `Widget`                   | **Required.** The widget that triggers the context menu.                   |
| `actions`             | `List<ContextMenuItem>`    | **Required.** A list of action items.                                     |
| `isDark`              | `bool?`                    | Forces dark mode (if not set, it follows system theme).                    |
| `blurSigma`           | `double?`                  | Controls the intensity of the background blur (default: 10).               |
| `backgroundMenuColor` | `Color?`                   | Background color of the menu container itself.                             |
| `iconColor`           | `Color?`                   | Default color for icons.                                                  |
| `textStyle`           | `TextStyle?`               | Custom text style for action labels.                                       |

---

## 🧱 Architecture Overview

The project follows a Clean Architecture inspired structure:

```
lib/
├── core/
│   └── managers/               # Color and Font managers
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
                └── ...
```

---

## 📄 License

This project is licensed under the [MIT License](https://github.com/OmarShawkey13/ContextMenuAndroid/blob/main/LICENSE).

---

## ❤️ Credits

Developed and maintained with 💙 by  
**[Omar Shawkey](https://github.com/OmarShawkey13)**
