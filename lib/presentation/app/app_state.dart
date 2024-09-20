import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_state.freezed.dart';

@freezed
class AppState with _$AppState {
  const AppState._();

  const factory AppState({
    required Exception? exception,
  }) = _AppState;

  factory AppState.initial() {
    return const AppState(
      exception: null,
    );
  }
}
