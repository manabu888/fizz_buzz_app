import 'package:fizz_buzz_app/src/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget createHomeScreen() => const MaterialApp(home: HomePage());


void main() {
  group('Home Page Widget Tests', () {
    testWidgets('Testing if Header shows up', (tester) async {
      await tester.pumpWidget(createHomeScreen());
      expect(find.text('FizzBuzz App'), findsOneWidget);
    });
    testWidgets('Testing if TextField shows up', (tester) async{
      await tester.pumpWidget(createHomeScreen());
      expect(find.byType(TextField), findsOneWidget);
    });
    testWidgets('Testing if ElevatedButton shows up', (tester) async{
      await tester.pumpWidget(createHomeScreen());
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('Testing IconButtons', (tester) async {
      // Create Home Screen
      await tester.pumpWidget(createHomeScreen());
      // Make sure there's no Floating Button
      expect(find.byIcon(Icons.start), findsNothing);
      // Input Limit number
      await tester.enterText(find.byType(TextField), '50');
      // Tap List Numbers Button
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      // Make sure ListView is shown
      expect(find.byType(ListView), findsOneWidget);
      // Make sure Floating Button is shown
      expect(find.byIcon(Icons.start), findsOneWidget);
      // Tap Button to replace with FizzBuzz
      await tester.tap(find.byIcon(Icons.start));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      // Make sure Floating Icon for resetting is shown
      expect(find.byIcon(Icons.restart_alt), findsOneWidget);
    });

    testWidgets('User Input Validation', (tester) async {
      // Create Home Screen
      await tester.pumpWidget(createHomeScreen());
      // Input Non Numeric Value
      await tester.enterText(find.byType(TextField), 'Hello');
      // Tap Submit button
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      // Make sure error message is shown
      expect(find.text('Must be a number'), findsOneWidget);
    });

  });


  group('Fizz Buzz Logic tests', () {
    test('It should return "1" when 1', () {
      expect(Util.doFizzBuzz(1), '1');
    });
    test('It should return "Fizz" when 3', () {
      expect(Util.doFizzBuzz(3), 'Fizz');
    });
    test('It should return "Buzz" when 5', () {
      expect(Util.doFizzBuzz(5), 'Buzz');
    });
    test('It should return "FizzBuzz" when 30', () {
      expect(Util.doFizzBuzz(30), 'FizzBuzz');
    });
    test('It should return "Buzz" when 1000', () {
      expect(Util.doFizzBuzz(1000), 'Buzz');
    });
  });
}