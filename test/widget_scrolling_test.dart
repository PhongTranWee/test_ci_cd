import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// void main() {
//   runApp(MyApp(items: List<String>.generate(10000, (i) => 'Item $i')));
// }

class MyApp extends StatelessWidget {
  final List<String> items;

  const MyApp({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    const title = 'Long List';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(title: const Text(title)),
        body: ListView.builder(
          // Add a key to the ListView. This makes it possible to
          // find the list and scroll through it in the tests.
          key: const Key('long_list'),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                items[index],
                // Add a key to the Text widget for each item. This makes
                // it possible to look for a particular item in the list
                // and verify that the text is correct
                key: Key('item_${index}_text'),
              ),
            );
          },
        ),
      ),
    );
  }
}

void main(){
  testWidgets('finds a deep item in a long list', (tester)async{
    await tester.pumpWidget(MyApp(items: List<String>.generate(10000, (i) => 'Item $i'),));

    final listFinder = find.byType(Scrollable);

    final itemFinder = find.byKey(Key('item_50_text'));

    await tester.scrollUntilVisible(itemFinder, 500, scrollable: listFinder);

    expect(itemFinder, findsOneWidget);
  });
}