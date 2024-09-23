import 'package:test_prj/domain/repository/local_storage_repository.dart';

class SaveTokenUseCase {
  final LocalStorageRepository _localStorageRepository;

  SaveTokenUseCase({
    required LocalStorageRepository localStorageRepository,
  }) : _localStorageRepository = localStorageRepository;

  Future execute({
    required String token,
    required String email,
    required String password,
  }) async {
    _localStorageRepository.saveToken(token: token, email: email, password: password);
  }
}
