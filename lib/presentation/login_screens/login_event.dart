part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {
  const LoginEvent();
}

class GetTokenEvent extends LoginEvent {}

class UpdateEmail extends LoginEvent {}

class UpdatePassword extends LoginEvent {}

class ChangeSaveTokenEvent extends LoginEvent {}

class ChangePasswordVisibilityEvent extends LoginEvent {}

class LogInUserEvent extends LoginEvent {}
