import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:context_menu_android/context_menu_android.dart';

void main() {
  testWidgets('Context menu renders and opens on long press', (
    WidgetTester tester,
  ) async {
    final testKey = const Key('my_test_widget');

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: ContextMenuWrapper(
              actions: [
                ContextMenuItem(
                  icon: Icons.share,
                  label: 'Share',
                  onTap: () {},
                ),
              ],
              child: Container(
                key: testKey,
                width: 100,
                height: 100,
                color: Colors.blue,
              ),
            ),
          ),
        ),
      ),
    );

    // Ensure the child is visible
    expect(find.byKey(testKey), findsOneWidget);

    // Long press to open the menu
    await tester.longPress(find.byKey(testKey));
    await tester.pumpAndSettle();

    // Verify the menu action is shown
    expect(find.text('Share'), findsOneWidget);
  });
}
