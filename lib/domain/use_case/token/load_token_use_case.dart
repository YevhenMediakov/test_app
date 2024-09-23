import 'package:test_prj/domain/repository/local_storage_repository.dart';
import 'package:test_prj/domain/repository/login_repository.dart';

class LoadTokenUseCase {
  final LocalStorageRepository _localStorageRepository;

  LoadTokenUseCase({
    required LocalStorageRepository localStorageRepository,
  }): _localStorageRepository = localStorageRepository;


  Future<bool> execute() async {
    return _localStorageRepository.loadToken();
  }
}