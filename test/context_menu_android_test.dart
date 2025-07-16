import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:context_menu_android/context_menu_android.dart';

void main() {
  testWidgets('Context menu renders child correctly', (WidgetTester tester) async {
    final testKey = Key('my_test_widget');

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            return iOSStyleContextMenu(
              context,
              child: Container(key: testKey),
              actions: [],
            );
          },
        ),
      ),
    );

    expect(find.byKey(testKey), findsOneWidget);
  });
}
