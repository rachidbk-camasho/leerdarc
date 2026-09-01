import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:leer_darija/main.dart';

void main() {
  testWidgets('Home screen shows app title and levels', (tester) async {
    await tester.pumpWidget(const LeerDarijaApp());
    await tester.pumpAndSettle();

    expect(find.text('Leer Darija'), findsOneWidget);
    expect(find.text('Basis'), findsOneWidget);
    expect(find.text('A1'), findsOneWidget);
    expect(find.text('A2'), findsOneWidget);
  });
}
