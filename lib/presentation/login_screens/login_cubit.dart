import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_prj/presentation/login_screens/login_state.dart';
import 'package:test_prj/repository/local_storage_repository.dart';
import 'package:test_prj/repository/login_repository.dart';
import 'package:test_prj/validators/email_validator.dart';
import 'package:test_prj/validators/password_validator.dart';

class LoginCubit extends Cubit<LoginState> {
  final EmailValidator _emailValidator;
  final PasswordValidator _passwordValidator;
  final LoginRepository _loginRepository;
  final LocalStorageRepository _localStorageRepository;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // text ed contr

  LoginCubit({
    required final emailValidator,
    required final passwordValidator,
    required final loginRepository,
    required final localStorageRepository,
  })  : _emailValidator = emailValidator,
        _passwordValidator = passwordValidator,
        _localStorageRepository = localStorageRepository,
        _loginRepository = loginRepository,
        super(LoginState.initial()) {
    _initial();
    _addListeners();
  }

  void _initial() async {
    emit(state.copyWith(isLoading: true));
    try {
      bool isTokenSaved = await _localStorageRepository.loadToken();
      if (isTokenSaved) {
        emit(state.copyWith(isLogInComplete: isTokenSaved, isLoading: false));
      }
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  void _addListeners() {
    emailController.addListener(() {
      updateEmail(emailController.text);
    });
    passwordController.addListener(() {
      updatePassword(passwordController.text);
    });
  }

  void updateEmail(String email) {
    emit(state.copyWith(email: email, isEmailValid: true));
  }

  void changePasswordVisibility() {
    emit(state.copyWith(isPasswordObscureText: !state.isPasswordObscureText));
  }

  void changeCheckbox() {
    emit(state.copyWith(isCheckboxValid: !state.isCheckboxValid));
  }

  void updatePassword(String password) {
    emit(state.copyWith(password: password, isPasswordValid: true));
  }

  bool _validateFields() {
    final emailValid = _emailValidator.validate(email: state.email);
    final passwordValid = _passwordValidator.validate(password: state.password);
    emit(state.copyWith(
        isEmailValid: emailValid, isPasswordValid: passwordValid));
    return emailValid && passwordValid == true;
  }

  void loginUser() async {
    if (!_validateFields()) {
      return;
    }

    emit(state.copyWith(isLoading: true));
    try {
      final token = await _loginRepository.loginUser(
        email: state.email,
        password: state.password,
      );
      if (state.isCheckboxValid) {
        await _localStorageRepository.saveToken(
          token: token,
          email: state.email,
          password: state.password.hashCode.toString(),
        );
      }
      emit(state.copyWith(isLogInComplete: true, isLoading: false));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }
}
