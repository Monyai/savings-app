import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:savings_goal/main.dart';

void main() {
  testWidgets('アプリ起動テスト', (WidgetTester tester) async {
    await tester.pumpWidget(const SavingsGoalApp());

    expect(find.text('目標貯金'), findsOneWidget);
    expect(find.text('貯金ゲージがここに表示されます'), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
  });
}
