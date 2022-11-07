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
    testWidgets('Testing if ListView shows up', (tester) async {
      await tester.pumpWidget(createHomeScreen());
      expect(find.byType(ListView), findsOneWidget);
    });
    testWidgets('Testing if FloatingActionButton shows up', (tester) async {
      await tester.pumpWidget(createHomeScreen());
      expect(find.byType(FloatingActionButton), findsOneWidget);
    });
    testWidgets('Testing IconButtons', (tester) async {
      await tester.pumpWidget(createHomeScreen());
      expect(find.byIcon(Icons.restart_alt), findsNothing);

      await tester.tap(find.byIcon(Icons.check));
      await tester.pumpAndSettle(const Duration(seconds: 1));

      expect(find.byIcon(Icons.restart_alt), findsOneWidget);
      expect(find.byIcon(Icons.check), findsNothing);
      expect(find.byType(ListView), findsOneWidget);
      expect(find.text('Fizz'), findsAtLeastNWidgets(1));
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