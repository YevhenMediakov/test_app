import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'login_state.freezed.dart';

@freezed
class LoginState with _$LoginState {
  const LoginState._();

  const factory LoginState({
    required String email,
    required String password,
    required bool? isEmailValid,
    required bool isPasswordObscureText,
    required bool? isPasswordValid,
    required bool? isCheckboxValid,
    required Exception? exception,
    required bool isLoading
  }) = _LoginState;

  factory LoginState.initial() {
    return const LoginState(
      email: '',
      password: '',
      isEmailValid: null,
      isPasswordValid: null,
      isCheckboxValid: null,
      isPasswordObscureText: true,
      exception: null,
      isLoading: false,
    );
  }
}
