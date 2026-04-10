import 'package:flutter/material.dart';
import 'package:context_menu_android/context_menu_android.dart';
import 'package:context_menu_android/core/theme/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Context Menu Example',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorSchemeSeed: ColorsManager.primary,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: ColorsManager.primary,
      ),
      themeMode: ThemeMode.system,
      home: const ContextMenuDemo(),
    );
  }
}

class ContextMenuDemo extends StatelessWidget {
  const ContextMenuDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('🍎 iOS Style Context Menu'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Try long-pressing the items below',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 40),

              /// 🚀 Example 1: Using ContextMenuWrapper (Enhanced Visuals)
              const Text('Using ContextMenuWrapper'),
              const SizedBox(height: 12),
              ContextMenuWrapper(
                actions: [
                  ContextMenuItem(
                    icon: Icons.share_rounded,
                    label: 'Share',
                    onTap: () => debugPrint('Share tapped'),
                  ),
                  ContextMenuItem(
                    icon: Icons.edit_rounded,
                    label: 'Edit',
                    onTap: () => debugPrint('Edit tapped'),
                  ),
                  ContextMenuItem(
                    icon: Icons.delete_rounded,
                    label: 'Delete',
                    isDestructive: true,
                    onTap: () => debugPrint('Delete tapped'),
                  ),
                ],
                child: Container(
                  width: 220,
                  height: 110,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [ColorsManager.blueAccent, Colors.blue],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: ColorsManager.blueAccent.withValues(alpha: 0.4),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      'Long Press Me',
                      style: TextStyle(
                        color: ColorsManager.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 50),

              /// 🚀 Example 2: Nested Sub-menus (Refined Colors)
              const Text('Nested Sub-menus'),
              const SizedBox(height: 12),
              ContextMenuWrapper(
                actions: [
                  ContextMenuItem(
                    icon: Icons.play_arrow_rounded,
                    label: 'Play Next',
                    onTap: () {},
                  ),
                  ContextMenuItem(
                    icon: Icons.more_horiz_rounded,
                    label: 'More Options',
                    subMenu: [
                      ContextMenuItem(
                        icon: Icons.info_outline_rounded,
                        label: 'View Details',
                        onTap: () {},
                      ),
                      ContextMenuItem(
                        icon: Icons.download_rounded,
                        label: 'Download High Quality',
                        onTap: () {},
                      ),
                      ContextMenuItem(
                        icon: Icons.playlist_add_rounded,
                        label: 'Add to Playlist',
                        onTap: () {},
                      ),
                    ],
                  ),
                  ContextMenuItem(
                    icon: Icons.remove_circle_outline_rounded,
                    label: 'Remove from Library',
                    isDestructive: true,
                    onTap: () {},
                  ),
                ],
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  color: isDark ? const Color(0xFF1E1E1E) : ColorsManager.white,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: ColorsManager.blueAccent.withValues(
                        alpha: 0.2,
                      ),
                      child: const Icon(
                        Icons.music_note,
                        color: ColorsManager.blueAccent,
                      ),
                    ),
                    title: const Text(
                      'Inception Soundtrack',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: const Text('Hans Zimmer'),
                    trailing: const Icon(Icons.more_vert),
                  ),
                ),
              ),

              const SizedBox(height: 50),

              /// 🚀 Example 3: Custom Styling
              const Text('Custom Styling'),
              const SizedBox(height: 12),
              ContextMenuWrapper(
                blurSigma: 15,
                backgroundColor: ColorsManager.indigo.withValues(alpha: 0.2),
                backgroundMenuColor: isDark
                    ? ColorsManager.black.withValues(alpha: 0.9)
                    : ColorsManager.white.withValues(alpha: 0.9),
                iconColor: ColorsManager.indigo,
                textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isDark ? ColorsManager.white : ColorsManager.black,
                ),
                actions: [
                  ContextMenuItem(
                    icon: Icons.star_rounded,
                    label: 'Custom Style 1',
                    onTap: () {},
                  ),
                  ContextMenuItem(
                    icon: Icons.bolt_rounded,
                    label: 'Custom Style 2',
                    onTap: () {},
                  ),
                ],
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: ColorsManager.indigo,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Text(
                    'Custom Styled Menu',
                    style: TextStyle(color: ColorsManager.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
