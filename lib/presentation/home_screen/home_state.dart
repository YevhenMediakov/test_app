import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_prj/models/profile.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const HomeState._();

  const factory HomeState({
    required List<ProfileData> data,
    required bool hasRemovedToken,
    required bool exception,
  }) = _HomeState;

  factory HomeState.initial() {
    return const HomeState(
      data: [],
      exception: false,
      hasRemovedToken: false,
    );
  }
}
