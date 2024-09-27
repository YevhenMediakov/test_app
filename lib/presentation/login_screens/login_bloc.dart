import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:test_prj/presentation/login_screens/login_state.dart';
import 'package:test_prj/repository/local_storage_repository.dart';
import 'package:test_prj/repository/login_repository.dart';
import 'package:test_prj/validators/email_validator.dart';
import 'package:test_prj/validators/password_validator.dart';

part 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final EmailValidator _emailValidator;
  final PasswordValidator _passwordValidator;
  final LoginRepository _loginRepository;
  final LocalStorageRepository _localStorageRepository;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  LoginBloc({
    required final emailValidator,
    required final passwordValidator,
    required final loginRepository,
    required final localStorageRepository,
  })  : _emailValidator = emailValidator,
        _passwordValidator = passwordValidator,
        _localStorageRepository = localStorageRepository,
        _loginRepository = loginRepository,
        super(LoginState.initial()) {
    on<GetTokenEvent>((event, emit) async {
      await _addToken(emit);
    });
    on<ChangePasswordVisibilityEvent>((event, emit) {
      _changePasswordVisibility(emit);
    });
    on<ChangeSaveTokenEvent>((event, emit) {
      _changeCheckbox(emit);
    });
    on<LogInUserEvent>((event, emit) async {
      await _loginUser(emit);
    });
    on<UpdateEmail>((event, emit) {
      _updateEmail(emit);
    });
    on<UpdatePassword>((event, emit) {
      _updatePassword(emit);
    });
    add(GetTokenEvent());
    emailController.addListener(() {
      add(UpdateEmail());
    });
    passwordController.addListener(() {
      add(UpdatePassword());
    });
  }

  Future<void> _addToken(Emitter<LoginState> emit) async {
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

  void _updateEmail(Emitter<LoginState> emit) {
    emit(state.copyWith(email: emailController.text, isEmailValid: true));
  }

  void _changePasswordVisibility(Emitter<LoginState> emit) {
    emit(state.copyWith(isPasswordObscureText: !state.isPasswordObscureText));
  }

  void _changeCheckbox(Emitter<LoginState> emit) {
    emit(state.copyWith(isCheckboxValid: !state.isCheckboxValid));
  }

  void _updatePassword(Emitter<LoginState> emit) {
    emit(state.copyWith(
        password: passwordController.text, isPasswordValid: true));
  }

  bool _validateFields(Emitter<LoginState> emit) {
    final emailValid = _emailValidator.validate(email: state.email);
    final passwordValid = _passwordValidator.validate(password: state.password);
    emit(state.copyWith(
        isEmailValid: emailValid, isPasswordValid: passwordValid));
    return emailValid && passwordValid == true;
  }

  Future<void> _loginUser(Emitter<LoginState> emit) async {
    if (!_validateFields(emit)) {
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
