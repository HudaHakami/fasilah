import 'package:fasilah_m1/features/registration/login/view.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Empty Email', () {
    expect(validateEmail(''), 'please enter your email');
  });

  test('Email without @', () {
    expect(validateEmail('testexamplegmail.com'), 'email must contain @');
  });

  test('Valid Email', () {
    expect(validateEmail('sara@gmail.com'), null);
  });
}
