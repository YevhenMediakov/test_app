import 'package:test_prj/domain/validators/email_validator.dart';

class EmailValidatorImpl extends EmailValidator {
  @override
  bool validate({required String? email}) {
    if (email == null) {
      return false;
    }
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }
}
