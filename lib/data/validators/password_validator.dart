
import 'package:test_prj/domain/validators/password_validator.dart';

class PasswordValidatorImpl extends PasswordValidator{
  @override
  bool validate({required String password}) {
    return  RegExp(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$')
        .hasMatch(password);
  }

}