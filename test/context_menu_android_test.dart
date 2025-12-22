import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:context_menu_android/features/context_menu/presentation/screen/ios_style_context_menu.dart';

void main() {
  testWidgets('Context menu renders child correctly', (
    WidgetTester tester,
  ) async {
    final testKey = const Key('my_test_widget');

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            return Scaffold(
              body: Center(
                child: ElevatedButton(
                  onPressed: () {
                    showDialog<Widget>(
                      context: context,
                      builder: (_) => IosStyleContextMenu(
                        actions: const [],
                        child: Container(key: testKey),
                      ),
                    );
                  },
                  child: const Text('Open Menu'),
                ),
              ),
            );
          },
        ),
      ),
    );

    // اضغط على الزر لعرض القائمة
    await tester.tap(find.text('Open Menu'));
    await tester.pumpAndSettle();

    // تحقق من وجود الودجت داخل القائمة
    expect(find.byKey(testKey), findsOneWidget);
  });
}
