// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:practice01/app.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // GlobalKey 생성 (const 아님)
    final navigatorKey = GlobalKey<NavigatorState>();

    // Build our app and trigger a frame.
    await tester.pumpWidget(HiteenApp(navigatorKey: navigatorKey));

    // 이하 동일
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
