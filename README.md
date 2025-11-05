# 🍎 ios_style_context_menu

A **Flutter package** that brings the elegant **iOS-style context menu** experience to **Android** — complete with blur effects, fluid animations, and nested sub-menus.  
Perfect for creating beautiful **long-press menus** on any widget, such as cards, images, or list items — all with the finesse of Apple design.

<p align="center">
  <img src="https://raw.githubusercontent.com/OmarShawkey13/ContextMenuAndroid/main/assets/images/example.jpg" width="270" alt="iOS-style context menu on Android"/>
</p>

---

## ✨ Why ios_style_context_menu?

| Feature                       | Description                                                                         |
|-------------------------------|-------------------------------------------------------------------------------------|
| 🍏 **True iOS Feel**          | Replicates iOS’s smooth context menu interaction, animations, and visual hierarchy. |
| 🧩 **Fully Customizable**     | Adjust text, icons, colors, padding, and animation curves — effortlessly.           |
| 💫 **Smooth Transitions**     | Powered by Flutter animations and `BackdropFilter` for silky blur effects.          |
| 🪄 **Nested Menus Support**   | Easily create sub-menus with back navigation — ideal for complex actions.           |
| 🌗 **Dark & Light Themes**    | Automatically adapts to the system theme or use `isDark` to override.               |
| 🧠 **Smart Delete Detection** | Destructive actions (like “Delete”) are automatically highlighted in red.           |
| ⚙️ **Performance-Optimized**  | Uses efficient animation controllers and responsive sizing for any screen.          |

---

## 🚀 Getting Started

Add to your project:

```yaml
dependencies:
  ios_style_context_menu: ^1.0.5
```

Then run:

```bash
flutter pub get
```

Import it in your code:

```dart
import 'package:ios_style_context_menu/ios_style_context_menu.dart';
```

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
      label: 'Delete',
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

| Property          | Type                       | Description                                                                |
|-------------------|----------------------------|----------------------------------------------------------------------------|
| `child`           | `Widget`                   | **Required.** The widget that triggers the context menu.                   |
| `actions`         | `List<ContextMenuAndroid>` | **Required.** A list of action items, each with icon, label, and callback. |
| `isDark`          | `bool?`                    | Forces dark mode (if not set, it follows system theme).                    |
| `textStyle`       | `TextStyle?`               | Custom text style for action labels.                                       |
| `backgroundColor` | `Color?`                   | Background color of the menu container (defaults based on theme).          |
| `dividerColor`    | `Color?`                   | Divider color between menu items.                                          |
| `iconColor`       | `Color?`                   | Icon color (automatically turns red for “Delete” actions).                 |
| `contentPadding`  | `EdgeInsetsGeometry?`      | Padding around the menu container.                                         |
| `textSize`        | `double?`                  | Font size for text, scales responsively.                                   |
| `iconSize`        | `double?`                  | Optional icon size (currently unused by default).                          |

---

## 📸 Live Preview

<p align="center">
  <img src="https://raw.githubusercontent.com/OmarShawkey13/ContextMenuAndroid/main/assets/images/preview.gif" width="300" alt="Animated iOS-style context menu preview"/>
</p>

---

## 🧱 Architecture Overview

```
lib/
├── ios_style_context_menu.dart    # Core widget and animations
├── context_menu.dart              # Data model for menu actions
└── src/
    ├── animations/
    ├── widgets/
    └── utils/
```

---

## 💡 Pro Tips

- ✅ Use `Navigator.pop(context)` manually only if you wrap custom dialogs inside.
- 🔁 You can open nested sub-menus dynamically using `subMenu` property.
- 🎨 Combine with `Theme.of(context)` for adaptive color matching.
- 🕹 Long-press gesture wrappers can be added for auto-open menus.

---

## 🧰 Planned Add-ons (v2.0)

- ✨ Built-in **long-press wrapper** (`IosContextMenuWrapper`).
- 🔊 **Haptic feedback** for tap and open events.
- 🎬 Custom **animation styles** (fade, slide, scale).
- 🧩 Public **theme configuration class** (`ContextMenuThemeData`).

---

## 📄 License

This project is licensed under the [MIT License](https://github.com/OmarShawkey13/ContextMenuAndroid/blob/main/LICENSE).  
You’re free to use, modify, and distribute it with proper attribution.

---

## ❤️ Credits

Developed and maintained with 💙 by  
**[Omar Shawkey](https://github.com/OmarShawkey13)**

> _"Design like Apple. Animate like Flutter."_ 🍏
