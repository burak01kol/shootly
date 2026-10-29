/// [ProLockChip] widget testi.
/// Kilitli seçeneğin kilit simgesi gösterdiğini ve dokunulabildiğini doğrular.
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vitrin/core/widgets/pro_lock_chip.dart';

void main() {
  testWidgets('kilitli seçenek kilit simgesi gösterir ve dokunulabilir',
      (tester) async {
    var tapped = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ProLockChip(
            label: 'Amazon',
            selected: false,
            locked: true,
            onSelected: () => tapped = true,
          ),
        ),
      ),
    );

    expect(find.text('Amazon'), findsOneWidget);
    expect(find.byIcon(Icons.lock_outline_rounded), findsOneWidget);

    await tester.tap(find.text('Amazon'));
    expect(tapped, isTrue);
  });
}
