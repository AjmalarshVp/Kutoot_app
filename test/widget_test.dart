import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:kutoot_app/app.dart';
import 'package:kutoot_app/injection_container.dart';

void main() {
  setUpAll(() async {
    await initDependencies();
  });

  testWidgets('Kutoot app boots', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(375, 913);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const KutootApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 800));
    await tester.pump(const Duration(milliseconds: 800));
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
