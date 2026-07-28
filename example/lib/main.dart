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
        scaffoldBackgroundColor: const Color(
          0xFFF2F2F7,
        ), // iOS default grey background
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: ColorsManager.primary,
        scaffoldBackgroundColor: Colors.black,
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
        title: const Text(
          '🍏 iOS Style Context Menu',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Interactive Showcase',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Long-press the items below to see the context menus in action.',
              style: TextStyle(
                fontSize: 16,
                color: isDark ? Colors.grey[400] : Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),

            /// 🚀 Example 1: Standard Button with Subtitles
            _SectionTitle('Standard iOS Action Menu'),
            ContextMenuWrapper(
              actions: [
                ContextMenuItem(
                  icon: Icons.share_rounded,
                  label: 'Share',
                  subtitle: 'Send to friends or social media',
                  onTap: () => debugPrint('Share tapped'),
                ),
                ContextMenuItem(
                  icon: Icons.copy_rounded,
                  label: 'Copy Link',
                  subtitle: 'Copy to clipboard',
                  onTap: () => debugPrint('Copy tapped'),
                ),
                ContextMenuItem(
                  icon: Icons.archive_outlined,
                  label: 'Archive Item',
                  enabled: false,
                  onTap: () {},
                ),
                ContextMenuItem(
                  icon: Icons.delete_rounded,
                  label: 'Delete',
                  subtitle: 'This action cannot be undone',
                  isDestructive: true,
                  onTap: () => debugPrint('Delete tapped'),
                ),
              ],
              child: Container(
                height: 110,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF007AFF), Color(0xFF0056B3)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF007AFF).withValues(alpha: 0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    'Long Press Me',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 48),

            /// 🚀 Example 2: Deeply Nested Sub-menus
            _SectionTitle('Deeply Nested Sub-menus'),
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
                      icon: Icons.settings_rounded,
                      label: 'Advanced Settings',
                      subMenu: [
                        ContextMenuItem(
                          icon: Icons.equalizer_rounded,
                          label: 'Audio Equalizer',
                          onTap: () {},
                        ),
                        ContextMenuItem(
                          icon: Icons.spatial_audio_off_rounded,
                          label: 'Spatial Audio',
                          onTap: () {},
                        ),
                      ],
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
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                color: isDark ? const Color(0xFF1C1C1E) : Colors.white,
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF007AFF).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.music_note_rounded,
                      color: Color(0xFF007AFF),
                    ),
                  ),
                  title: const Text(
                    'Inception Soundtrack',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  subtitle: const Text('Hans Zimmer'),
                  trailing: const Icon(Icons.more_horiz),
                ),
              ),
            ),

            const SizedBox(height: 48),

            /// 🚀 Example 3: Perfect Circular Clipping
            _SectionTitle('Perfect Circular Clipping'),
            Text(
              'Showcasing the precision GlobalKey dimensions and unforced border radius on a perfectly circular widget.',
              style: TextStyle(
                fontSize: 14,
                color: isDark ? Colors.grey[500] : Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Center(
              child: ContextMenuWrapper(
                childBorderRadius: BorderRadius.circular(
                  100,
                ), // Forces exact circular clip if needed
                actions: [
                  ContextMenuItem(
                    icon: Icons.person_add_rounded,
                    label: 'Add Friend',
                    onTap: () {},
                  ),
                  ContextMenuItem(
                    icon: Icons.message_rounded,
                    label: 'Send Message',
                    onTap: () {},
                  ),
                  ContextMenuItem(
                    icon: Icons.block_rounded,
                    label: 'Block User',
                    isDestructive: true,
                    onTap: () {},
                  ),
                ],
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.network(
                      'https://picsum.photos/200',
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(child: CircularProgressIndicator());
                      },
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.person, size: 50),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 48),

            /// 🚀 Example 4: Customized Theme & Timings
            _SectionTitle('Customized Theme & Timings'),
            ContextMenuWrapper(
              isDark: true, // Force dark mode
              backgroundMenuColor: Colors.deepPurple.shade900.withValues(
                alpha: 0.8,
              ),
              backgroundColor: Colors.black.withValues(alpha: 0.6),
              dividerColor: Colors.white24,
              iconColor: Colors.amber,
              textStyle: const TextStyle(
                color: Colors.white,
                fontFamily: 'monospace',
              ),
              openDuration: const Duration(
                milliseconds: 800,
              ), // Very slow for demo
              closeDuration: const Duration(milliseconds: 600),
              actions: [
                ContextMenuItem(
                  icon: Icons.dark_mode,
                  label: 'Force Dark Mode',
                  onTap: () {},
                ),
                ContextMenuItem(
                  icon: Icons.timer,
                  label: 'Slow Animation',
                  onTap: () {},
                ),
              ],
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    'Custom Themed Menu',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 48),

            /// 🚀 Example 5: Leading Icons & Custom Alignment
            _SectionTitle('Leading Icons & Custom Alignment'),
            ContextMenuWrapper(
              iconPosition: IconPosition.leading, // Icons on the left
              menuAlignment: Alignment.topRight, // Open from top right
              textSize: 20, // Larger text
              iconSize: 28, // Larger icons
              actions: [
                ContextMenuItem(
                  icon: Icons.format_align_left,
                  label: 'Leading Icon',
                  onTap: () {},
                ),
                ContextMenuItem(
                  icon: Icons.text_fields,
                  label: 'Large Text',
                  onTap: () {},
                ),
                ContextMenuItem(
                  icon: Icons.settings,
                  label: 'Sub Menu',
                  subMenu: [
                    ContextMenuItem(
                      icon: Icons.wifi,
                      label: 'Network',
                      onTap: () {},
                    ),
                  ],
                ),
              ],
              child: Container(
                padding: const EdgeInsets.all(16),
                color: Colors.teal,
                child: const Center(
                  child: Text(
                    'Right-Aligned Leading Icons',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 48),

            /// 🚀 Example 6: Heavy Blur & Desktop Right-Click
            _SectionTitle('Heavy Blur & Desktop Ready'),
            ContextMenuWrapper(
              blurSigma: 20.0, // Intense blur
              actions: [
                ContextMenuItem(
                  icon: Icons.mouse,
                  label: 'Right-Click (Web/Desktop)',
                  onTap: () {},
                ),
                ContextMenuItem(
                  icon: Icons.blur_on,
                  label: 'Intense Blur Sigma',
                  onTap: () {},
                ),
              ],
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    'Long Press or Right Click',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }
}
