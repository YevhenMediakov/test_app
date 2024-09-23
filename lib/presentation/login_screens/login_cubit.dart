import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_prj/domain/use_case/login/login_use_case.dart';
import 'package:test_prj/domain/use_case/token/load_token_use_case.dart';
import 'package:test_prj/domain/use_case/token/save_token_use_case.dart';
import 'package:test_prj/domain/validators/email_validator.dart';
import 'package:test_prj/domain/validators/password_validator.dart';
import 'package:test_prj/presentation/login_screens/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final EmailValidator _emailValidator;
  final PasswordValidator _passwordValidator;
  final LoginUserUseCase _loginUserUseCase;
  final SaveTokenUseCase _saveTokenUseCase;
  final LoadTokenUseCase _loadTokenUseCase;

  LoginCubit(
      {required final emailValidator,
      required final passwordValidator,
      required final loginUserUseCase,
      required final saveTokenUseCase,
      required final loadTokenUseCase})
      : _emailValidator = emailValidator,
        _passwordValidator = passwordValidator,
        _loginUserUseCase = loginUserUseCase,
        _saveTokenUseCase = saveTokenUseCase,
        _loadTokenUseCase = loadTokenUseCase,
        super(LoginState.initial()) {
    _initial();
  }

  _initial() async {
    emit(state.copyWith(isLoading: true));
    bool isTokenSaved = await _loadTokenUseCase.execute();
    if (isTokenSaved) {
      emit(state.copyWith(isLogInComplete: isTokenSaved, isLoading: false));
    }
  }

  updateEmail(String email) {
    emit(state.copyWith(email: email, isEmailValid: true));
  }

  isPasswordObscureText() {
    emit(state.copyWith(isPasswordObscureText: !state.isPasswordObscureText));
  }

  isCheckboxValid() {
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
      Future.delayed(const Duration(seconds: 2)).then((_) async {
        String token = await _loginUserUseCase.execute(
            email: state.email, password: state.password);
        if (state.isCheckboxValid) {
          _saveTokenUseCase.execute(token: token);
        }
        emit(state.copyWith(isLogInComplete: true, isLoading: false));
      });
    } else {
      Future.delayed(const Duration(seconds: 2)).then((_) {
        emit(state.copyWith(isLoading: false));
      });
    }
  }
}
