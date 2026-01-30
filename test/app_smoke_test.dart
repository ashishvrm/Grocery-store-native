import 'package:flutter_test/flutter_test.dart';
import 'package:grocery_store_native/app/app.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('App loads with navigation shell', (tester) async {
    await tester.pumpWidget(const GroceryStoreApp());
    expect(find.byType(BottomNavigationBar), findsNothing);
    expect(find.text('Home'), findsOneWidget);
  });
}
