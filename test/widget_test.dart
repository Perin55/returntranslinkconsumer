import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:translink_customer/features/auth/presentation/screens/customer_registration_screen.dart';

void main() {
  testWidgets('Customer registration screen renders existing form', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: CustomerRegistrationScreen(phoneNumber: '+919999999999'),
        ),
      ),
    );

    expect(find.text('Complete Profile'), findsOneWidget);
    expect(find.text('Full Name *'), findsOneWidget);
    expect(find.text('Email Address (Optional)'), findsOneWidget);
    expect(find.text('Gender *'), findsOneWidget);
    expect(find.text('Save & Continue'), findsOneWidget);
  });

  testWidgets('Customer registration validates required name without network call', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: CustomerRegistrationScreen(phoneNumber: '+919999999999'),
        ),
      ),
    );

    await tester.tap(find.text('Save & Continue'));
    await tester.pump();

    expect(find.text('Kripya apna naam dalein'), findsOneWidget);
  });

  testWidgets('Customer registration requires gender after name is entered', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: CustomerRegistrationScreen(phoneNumber: '+919999999999'),
        ),
      ),
    );

    await tester.enterText(find.byType(TextField).first, 'Test Customer');
    await tester.tap(find.text('Save & Continue'));
    await tester.pump();

    expect(find.text('Kripya apna gender select karein'), findsOneWidget);
  });
}
