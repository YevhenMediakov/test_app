import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_prj/domain/repository/local_storage_repository.dart';
import 'package:test_prj/domain/repository/login_repository.dart';
import 'package:test_prj/domain/validators/email_validator.dart';
import 'package:test_prj/domain/validators/password_validator.dart';
import 'package:test_prj/presentation/login_screens/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final EmailValidator _emailValidator;
  final PasswordValidator _passwordValidator;
  final LoginRepository
      _loginRepository; // todo replace uses cases with repository
  final LocalStorageRepository
      _localStorageRepository; // todo remove one time used use cases// todo remove one time used use cases

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
  }

  _initial() async {
    emit(state.copyWith(isLoading: true));
    bool isTokenSaved = await _localStorageRepository.loadToken();
    if (isTokenSaved) {
      emit(state.copyWith(isLogInComplete: isTokenSaved, isLoading: false));
    }
    emit(state.copyWith(isLoading: false));
  }

  updateEmail(String email) {
    emit(state.copyWith(email: email, isEmailValid: true));
  }

  changePasswordVisibility() {
    emit(state.copyWith(
        isPasswordObscureText: !state.isPasswordObscureText));
  }

  changeCheckbox() {
    emit(state.copyWith(isCheckboxValid: !state.isCheckboxValid));
  }

  updatePassword(String password) {
    emit(state.copyWith(password: password, isPasswordValid: true));
  }

  bool _validateFields() {
    final emailValid = _emailValidator.validate(email: state.email);
    final passwordValid = _passwordValidator.validate(password: state.password);
    emit(state.copyWith(
        isEmailValid: emailValid, isPasswordValid: passwordValid));
    return emailValid && passwordValid == true;
  }

  loginUser() async {
    emit(state.copyWith(isLoading: true));
    if (_validateFields()) {
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
    } else {
      Future.delayed(const Duration(seconds: 2)).then((_) {
        emit(state.copyWith(isLoading: false));
      });
    }
  }
}
