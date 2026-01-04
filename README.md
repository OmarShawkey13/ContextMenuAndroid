# 🍎 Context Menu Android

A **Flutter package** that brings the elegant **iOS-style context menu** experience to **Android** — complete with blur effects, fluid animations, and nested sub-menus.  
Perfect for creating beautiful **long-press menus** on any widget, such as cards, images, or list items — all with the finesse of Apple design.

<p align="center">
  <img src="https://raw.githubusercontent.com/OmarShawkey13/ContextMenuAndroid/main/assets/images/example.jpg" width="270" alt="iOS-style context menu on Android"/>
</p>

---

## ✨ Features

| Feature                       | Description                                                                         |
|-------------------------------|-------------------------------------------------------------------------------------|
| 🍏 **True iOS Feel**          | Replicates iOS’s smooth context menu interaction, animations, and visual hierarchy. |
| 🧩 **Fully Customizable**     | Adjust text, icons, colors, padding, and animation curves — effortlessly.           |
| 💫 **Smooth Transitions**     | Powered by Flutter animations and `BackdropFilter` for silky blur effects.          |
| 🪄 **Nested Menus Support**   | Easily create sub-menus with back navigation — ideal for complex actions.           |
| 🌗 **Dark & Light Themes**    | Automatically adapts to the system theme or use `isDark` to override.               |
| 🧠 **Smart Delete Detection** | Destructive actions (like “Delete”) are automatically highlighted in red.           |
| 📱 **Responsive Design**      | Adapts sizes and layout based on screen dimensions for a consistent look.           |

---

## 🚀 Getting Started

Add to your project's `pubspec.yaml`:

```yaml
dependencies:
  context_menu_android: ^1.0.8
```

Then run:

```bash
flutter pub get
```

Import it in your code:

```dart
import 'package:context_menu_android/context_menu_android.dart';
```
*(Note: Ensure you are importing the correct package path as per your project structure, typically `package:context_menu_android/features/context_menu/presentation/screen/ios_style_context_menu.dart` or via a barrel file if available)*

---

## 🧠 Basic Usage

Wrap any widget with `IosStyleContextMenu` and pass a list of actions:

```dart
IosStyleContextMenu(
  child: Image.network('https://picsum.photos/200'),
  actions: [
    ContextMenuAndroid(
      icon: Icons.share,
      label: 'Share',
      onTap: () => print('Shared!'),
    ),
    ContextMenuAndroid(
      icon: Icons.favorite,
      label: 'Add to Favorites',
      onTap: () => print('Added to favorites!'),
    ),
    ContextMenuAndroid(
      icon: Icons.delete,
      label: 'Delete', // Automatically highlighted in red
      onTap: () => print('Deleted!'),
    ),
  ],
);
```

---

## 🌿 Advanced Example with Sub-Menus

```dart
IosStyleContextMenu(
  child: Card(
    elevation: 6,
    child: ListTile(
      leading: Icon(Icons.movie),
      title: Text('Inception'),
      subtitle: Text('Tap & hold for menu'),
    ),
  ),
  actions: [
    ContextMenuAndroid(
      icon: Icons.play_arrow,
      label: 'Play',
      onTap: () => print('Playing Inception...'),
    ),
    ContextMenuAndroid(
      icon: Icons.more_horiz,
      label: 'More',
      subMenu: [
        ContextMenuAndroid(
          icon: Icons.info_outline,
          label: 'Details',
          onTap: () => print('Opening details...'),
        ),
        ContextMenuAndroid(
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

## ⚙️ Customization Options

| Property              | Type                       | Description                                                                |
|-----------------------|----------------------------|----------------------------------------------------------------------------|
| `child`               | `Widget`                   | **Required.** The widget that triggers the context menu.                   |
| `actions`             | `List<ContextMenuAndroid>` | **Required.** A list of action items, each with icon, label, and callback. |
| `isDark`              | `bool?`                    | Forces dark mode (if not set, it follows system theme).                    |
| `textStyle`           | `TextStyle?`               | Custom text style for action labels.                                       |
| `backgroundColor`     | `Color?`                   | Background color of the whole overlay.                                     |
| `backgroundMenuColor` | `Color?`                   | Background color of the menu container itself.                             |
| `dividerColor`        | `Color?`                   | Divider color between menu items.                                          |
| `iconColor`           | `Color?`                   | Icon color (automatically turns red for “Delete” actions).                 |
| `contentPadding`      | `EdgeInsetsGeometry?`      | Padding around the menu container.                                         |
| `textSize`            | `double?`                  | Font size for text, scales responsively.                                   |
| `iconSize`            | `double?`                  | Optional icon size.                                                        |
| `menuAlignment`       | `AlignmentGeometry?`       | Alignment of the menu relative to the screen.                              |
| `blurSigma`           | `double?`                  | Controls the intensity of the background blur (default: 10).               |

---

## 📸 Live Preview

<p align="center">
  <img src="https://raw.githubusercontent.com/OmarShawkey13/ContextMenuAndroid/main/assets/images/preview.gif" width="300" alt="Animated iOS-style context menu preview"/>
</p>

---

## 🧱 Architecture Overview

The project follows a Clean Architecture inspired structure:

```
lib/
└── features/
    └── context_menu/
        ├── data/
        │   └── models/
        │       └── context_menu.dart           # Data model for menu actions
        └── presentation/
            ├── screen/
            │   └── ios_style_context_menu.dart # Main entry widget
            ├── utils/
            │   └── responsive_size.dart        # Responsive design utilities
            └── widget/
                ├── blur_background.dart        # Blur effect layer
                ├── context_menu_action_tile.dart # Individual action items
                ├── context_menu_child.dart     # Animated child wrapper
                └── context_menu_panel.dart     # Menu container and layout
```

---

## 💡 Pro Tips

- ✅ Use `Navigator.pop(context)` manually only if you wrap custom dialogs inside.
- 🔁 You can open nested sub-menus dynamically using `subMenu` property.
- 🎨 Combine with `Theme.of(context)` for adaptive color matching.
- 🕹 Long-press gesture wrappers can be added for auto-open menus.

---

## 📄 License

This project is licensed under the [MIT License](https://github.com/OmarShawkey13/ContextMenuAndroid/blob/main/LICENSE).  
You’re free to use, modify, and distribute it with proper attribution.

---

## ❤️ Credits

Developed and maintained with 💙 by  
**[Omar Shawkey](https://github.com/OmarShawkey13)**

> _"Design like Apple. Animate like Flutter."_ 🍏
