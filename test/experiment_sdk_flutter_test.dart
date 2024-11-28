import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:experiment_sdk_flutter/experiment_sdk_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomBindings extends AutomatedTestWidgetsFlutterBinding {
  @override
  bool get overrideHttpClient => false;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    // ↓ required to avoid HTTP error 400 mocked returns
    HttpOverrides.global = null;
    SharedPreferences.setMockInitialValues({});
  });

  test('Should throw error if called with wrong apikey', () {
    final experiment = Experiment.initialize(apiKey: '');

    expect(experiment.fetch(userId: 'testing'),
        throwsA(const TypeMatcher<Exception>()));
  });

  test('Should succesfull fetch with a valid apiKey', () async {
    final experiment = Experiment.initialize(
        apiKey: 'client-SyuVa4OF1vMBD5F59JMRwcZJutII4gZ2');

    expect(experiment.fetch(userId: 'testing'), completion(null));
  });

  test('Should has one variant', () async {
    final experiment = Experiment.initialize(
        apiKey: 'client-SyuVa4OF1vMBD5F59JMRwcZJutII4gZ2');

    await experiment.fetch(userId: 'testing');

    expect(experiment.variant('testing-sdk')?.value, 'control');
  });

  test('Should return a map with variant on all method', () async {
    final experiment = Experiment.initialize(
        apiKey: 'client-SyuVa4OF1vMBD5F59JMRwcZJutII4gZ2');

    await experiment.fetch(userId: 'testing');
    final all = experiment.all();

    expect(all['testing-sdk']!.value, 'control');
  });

  test('Should succesfully clear cache', () async {
    final experiment = Experiment.initialize(
        apiKey: 'client-SyuVa4OF1vMBD5F59JMRwcZJutII4gZ2');

    await experiment.fetch(userId: 'testing');
    var all = experiment.all();

    expect(all['testing-sdk']!.value, 'control');

    experiment.clear();
    all = experiment.all();

    expect(all, {});
  });
}
