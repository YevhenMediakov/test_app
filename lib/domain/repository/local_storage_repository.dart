abstract class LocalStorageRepository {
  Future<bool> loadToken();

  Future saveToken({
    required String token,
    required String email,
    required String password,
  });

  Future removeToken();
}
