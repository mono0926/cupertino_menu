import 'package:cupertino_menu/cupertino_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'CupertinoPopupMenuButton renders and opens menu',
    (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Portal(
            child: Center(
              child: CupertinoPopupMenuButton(
                actions: [
                  CupertinoPopupMenuButtonAction(
                    child: const Text('Item 1'),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    expect(find.byType(CupertinoPopupMenuButton), findsOneWidget);
    expect(find.text('Item 1'), findsNothing);

    await tester.tap(find.byType(IconButton));
    await tester.pumpAndSettle();

    expect(find.text('Item 1'), findsOneWidget);
  });
}
