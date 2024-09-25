import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_prj/domain/repository/local_storage_repository.dart';
import 'package:test_prj/domain/repository/profile_data_repository.dart';
import 'package:test_prj/presentation/home_screen/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final LocalStorageRepository _localStorageRepository;
  final ProfileDataRepository _profileDataRepository;

  HomeCubit({
    required final profileDataRepository,
    required final localStorageRepository,
  })  : _localStorageRepository = localStorageRepository,
        _profileDataRepository = profileDataRepository,
        super(HomeState.initial()) {
    _initial();
  }

  void _initial() async {
    final data = await _profileDataRepository.getData();
    emit(state.copyWith(isLoading: false, data: data));
  }

  void logOut() async {
    await _localStorageRepository.removeToken();
    emit(state.copyWith(hasRemovedToken: true));
    print(state);
  }
}
