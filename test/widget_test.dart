// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sudoku/main.dart';

void main() {
  testWidgets('Sudoku test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const SudokuApp());

    // Verify that we have 9x9 tiles and 81 empty text fields.
    expect(find.byType(GridView), findsNWidgets(10));
    expect(find.text(''), findsNWidgets(81));

    // Enter '1' into the first text field.
    await tester.enterText(find.byType(TextField).first, '1');
    await tester.pump();

    // Verify that the first text field contains '1' and the rest are empty.
    expect(find.text('1'), findsOneWidget);
    expect(find.text(''), findsNWidgets(80));
  });
}
