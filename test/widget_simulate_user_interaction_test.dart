import 'package:flutter/material.dart';
import 'package:flutter_demo_3_32_5/main_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  testWidgets('Add and remove a todo', (tester) async {
    // Build the widget
    await tester.pumpWidget(const TodoList());

    // Enter 'hi' into the TextField.
    await tester.enterText(find.byType(TextField), 'hi');

    await tester.tap(find.byType(FloatingActionButton));

    await tester.pump();

    expect(find.text('hi'), findsOneWidget);


  });

  testWidgets('Add and remove a todo', (tester) async {
    // Enter text and add the item...
    await tester.pumpWidget(const TodoList());

    await tester.enterText(find.byType(TextField), 'hi');

    await tester.tap(find.byType(FloatingActionButton));

    await tester.pump();


    // Swipe the item to dismiss it.
    await tester.drag(find.byType(Dismissible), Offset(500.0, 0));

    await tester.pumpAndSettle();

    expect(find.text('hi'), findsNothing);

    // Build the widget until the dismiss animation ends.


    // Ensure that the item is no longer on screen.

  });
}