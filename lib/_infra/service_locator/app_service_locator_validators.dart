import 'package:get_it/get_it.dart';
import 'package:test_prj/data/validators/email_validator.dart';
import 'package:test_prj/data/validators/password_validator.dart';
import 'package:test_prj/domain/validators/email_validator.dart';
import 'package:test_prj/domain/validators/password_validator.dart';

class AppServiceLocatorValidators {
  static Future<void> setup({required GetIt instance}) async {
    instance.registerLazySingleton<EmailValidator>(() => EmailValidatorImpl());
    instance.registerLazySingleton<PasswordValidator>(
        () => PasswordValidatorImpl());
  }
}
