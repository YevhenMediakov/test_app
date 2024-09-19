

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_prj/domain/use_case/login/login_use_case.dart';
import 'package:test_prj/domain/validators/email_validator.dart';
import 'package:test_prj/domain/validators/password_validator.dart';
import 'package:test_prj/presentation/login_screens/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final EmailValidator _emailValidator;
  final PasswordValidator _passwordValidator;
  final LoginUserUseCase _loginUserUseCase;

  LoginCubit({
    required final emailValidator,
    required final passwordValidator,
    required final loginUserUseCase,
  }): _emailValidator = emailValidator,
  _passwordValidator = passwordValidator,
        _loginUserUseCase = loginUserUseCase,
        super(LoginState.initial());

  updateEmail(String email) {
    emit(state.copyWith(email: email, isEmailValid: true));
  }

  isPasswordObscureText() {
    emit(state.copyWith(isPasswordObscureText: !state.isPasswordObscureText));
  }

  updatePassword(String password) {
    emit(state.copyWith(password: password, isPasswordValid: true));
  }


  bool _validateFields() {
    final emailValid = _emailValidator.validate(email: state.email);
    final passwordValid = _passwordValidator.validate(password: state.password);
    emit(state.copyWith(isEmailValid: emailValid, isPasswordValid: passwordValid));
    return emailValid && passwordValid && state.isCheckboxValid == true;
  }

  loginUser() async {

  }
}
