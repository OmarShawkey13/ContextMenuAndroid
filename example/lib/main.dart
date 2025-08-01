import 'package:context_menu_android/features/context_menu/data/models/context_menu.dart';
import 'package:context_menu_android/features/context_menu/presentation/widget/ios_style_context_menu.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Context Menu Example',
      theme: ThemeData.light(),
      home: const ContextMenuDemo(),
    );
  }
}

class ContextMenuDemo extends StatelessWidget {
  const ContextMenuDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('iOS Style Context Menu')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onLongPress: () {
                showDialog(
                  context: context,
                  builder: (ctx) => IosStyleContextMenu(
                    actions: [
                      ContextMenuAndroid(
                        icon: Icons.share,
                        label: 'Share',
                        onTap: () => debugPrint('Share pressed'),
                      ),
                      ContextMenuAndroid(
                        icon: Icons.copy,
                        label: 'Copy',
                        onTap: () => debugPrint('Copy pressed'),
                      ),
                      ContextMenuAndroid(
                        icon: Icons.delete,
                        label: 'Delete',
                        onTap: () => debugPrint('Delete pressed'),
                      ),
                    ],
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        'Long press to open context menu',
                        style: Theme.of(ctx).textTheme.bodyLarge,
                      ),
                    ),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Long Press Me',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onLongPress: () {
                showDialog(
                  context: context,
                  builder: (ctx) => IosStyleContextMenu(
                    actions: [
                      ContextMenuAndroid(
                        icon: Icons.share,
                        label: 'Share',
                        onTap: () => debugPrint('Share pressed'),
                      ),
                      ContextMenuAndroid(
                        icon: Icons.delete,
                        label: 'Delete',
                        onTap: () => debugPrint('Delete pressed'),
                      ),
                      ContextMenuAndroid(
                        icon: Icons.arrow_forward_ios,
                        label: 'More',
                        subMenu: [
                          // ✅ Submenu هنا
                          ContextMenuAndroid(
                            icon: Icons.copy,
                            label: 'Copy',
                            onTap: () => debugPrint('Copy pressed'),
                          ),
                          ContextMenuAndroid(
                            icon: Icons.favorite_border,
                            label: 'Favorite',
                            onTap: () => debugPrint('Favorite pressed'),
                          ),
                        ],
                      ),
                    ],
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.all(14),
                      child: Text(
                        'Long press to open subMenu',
                        style: Theme.of(ctx).textTheme.bodyLarge,
                      ),
                    ),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Long Press to open subMenu',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
