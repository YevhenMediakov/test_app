interface class PasswordValidator {
  bool validate({required String password}) {
    return RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$')
        .hasMatch(password);
  }
}
