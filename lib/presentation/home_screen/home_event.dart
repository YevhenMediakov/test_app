part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {
  const HomeEvent();
}

class GetDataEvent extends HomeEvent {
  final Completer completer;

  const GetDataEvent(this.completer);
}

class LogOutEvent extends HomeEvent {}
