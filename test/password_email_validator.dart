
import 'package:flutter_test/flutter_test.dart';
import 'package:notes_app/validation/my_validator.dart';

void main() {
  test('empty email test', () {
    String result = MyValidator.emailValidator('');
    expect(result, 'Please enter email');
  });
  test('valid email test', () {
    String result = MyValidator.emailValidator('myflutterscholl@gmail.com');
    expect(result, 'Email is valid');
  });
  test('empty password test', () {
    String result = MyValidator.passwordValidator('');
    expect(result, 'Please enter password');
  });

  test('valid password test', () {
    String result = MyValidator.passwordValidator('sfaasdassgd');
    expect(result, 'Password is valid');
  });

  test('valid password test', () {
    String result = MyValidator.passwordValidator('sfgd');
    expect(result, 'Password must be more than 7 characters');
  });
}
