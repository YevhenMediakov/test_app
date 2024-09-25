import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_prj/domain/model/profile.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const HomeState._();

  const factory HomeState({
    required List<ProfileData> data,
    required bool hasRemovedToken,
    required Exception? exception,
    required bool isLoading,
  }) = _HomeState;

  factory HomeState.initial() {
    return const HomeState(
      data: [],
      exception: null,
      isLoading: false,
      hasRemovedToken: false,
    );
  }
}
