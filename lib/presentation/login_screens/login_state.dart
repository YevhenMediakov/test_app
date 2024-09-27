import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.freezed.dart';

@freezed
class LoginState with _$LoginState {
  const LoginState._();

  const factory LoginState(
      {required String email,
      required String password,
      required bool isEmailValid,
      required bool isPasswordObscureText,
      required bool isPasswordValid,
      required bool isCheckboxValid,
      required bool isLogInComplete,
      required bool showSnackBar,
      required Exception? exception,
      required bool isLoading}) = _LoginState;

  factory LoginState.initial() {
    return const LoginState(
      email: '',
      password: '',
      isEmailValid: true,
      isPasswordValid: true,
      isCheckboxValid: false,
      isPasswordObscureText: true,
      showSnackBar: false,
      exception: null,
      isLoading: false,
      isLogInComplete: false,
    );
  }
}
