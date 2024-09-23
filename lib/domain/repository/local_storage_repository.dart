
abstract class LocalStorageRepository {
  Future<bool> loadToken();
  Future saveToken({required String token});
  Future removeToken();
}