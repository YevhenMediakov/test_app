import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:test_prj/presentation/home_screen/home_state.dart';
import 'package:test_prj/repository/local_storage_repository.dart';
import 'package:test_prj/repository/profile_data_repository.dart';

part 'home_event.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final LocalStorageRepository _localStorageRepository;
  final ProfileDataRepository _profileDataRepository;
  final completer = Completer();

  HomeBloc({
    required final profileDataRepository,
    required final localStorageRepository,
  })  : _localStorageRepository = localStorageRepository,
        _profileDataRepository = profileDataRepository,
        super(HomeState.initial()) {
    on<GetDataEvent>((event, emit) async {
      await _getData(emit, event.completer);
    });
    on<LogOutEvent>((event, emit) async {
      await _logOut(emit);
    });
    add(GetDataEvent(completer));
  }

  Future<void> _getData(Emitter<HomeState> emit, Completer completer) async {
    try {
      if (state.data.isEmpty) {
        emit(state.copyWith(isLoading: true));
      }
      final data = await _profileDataRepository.getData();
      if (data.isEmpty) {
        emit(state.copyWith(exception: true));
        emit(state.copyWith(exception: false));
      } else {
        emit(state.copyWith(data: data));
      }
    } finally {
      completer.complete();
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _logOut(Emitter<HomeState> emit) async {
    await _localStorageRepository.removeToken();
    emit(state.copyWith(hasRemovedToken: true));
  }
}
