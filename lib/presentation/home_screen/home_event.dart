part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {
  const HomeEvent();
}

class GetDataEvent extends HomeEvent {}

class LogOutEvent extends HomeEvent {}
