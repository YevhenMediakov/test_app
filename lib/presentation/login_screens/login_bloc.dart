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
    on<ChangePasswordVisibilityEvent>((event, emit) async {
      await _changePasswordVisibility(emit);
    });
    on<ChangeSaveTokenEvent>((event, emit) async {
      await _changeCheckbox(emit);
    });
    on<LogInUserEvent>((event, emit) async {
      await _loginUser(emit);
    });
    on<UpdateEmail>((event, emit) async {
      await _updateEmail(emit);
    });
    on<UpdatePassword>((event, emit) async {
      await _updatePassword(emit);
    });
    add(GetTokenEvent());
    _addListeners();
  }

  Future<void> _addListeners() async {
    emailController.addListener(() async {
      add(UpdateEmail());
    });
    passwordController.addListener(() async {
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

  Future<void> _updateEmail(Emitter<LoginState> emit) async {
    emit(state.copyWith(email: emailController.text, isEmailValid: true));
  }

  Future<void> _changePasswordVisibility(Emitter<LoginState> emit) async {
    emit(state.copyWith(isPasswordObscureText: !state.isPasswordObscureText));
  }

  Future<void> _changeCheckbox(Emitter<LoginState> emit) async {
    emit(state.copyWith(isCheckboxValid: !state.isCheckboxValid));
  }

  Future<void> _updatePassword(Emitter<LoginState> emit) async {
    emit(state.copyWith(
        password: passwordController.text, isPasswordValid: true));
  }

  Future<bool> _validateFields(Emitter<LoginState> emit) async {
    final emailValid = _emailValidator.validate(email: state.email);
    final passwordValid = _passwordValidator.validate(password: state.password);
    emit(state.copyWith(
        isEmailValid: emailValid, isPasswordValid: passwordValid));
    return emailValid && passwordValid == true;
  }

  Future<void> _loginUser(Emitter<LoginState> emit) async {
    final valid = await _validateFields(emit);
    if (!valid) {
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
