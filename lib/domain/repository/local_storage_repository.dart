abstract class LocalStorageRepository {
  Future<bool> loadToken();

  Future<void> saveToken({
    required String token,
    required String email,
    required String password,
  });

  Future<void> removeToken();
}
