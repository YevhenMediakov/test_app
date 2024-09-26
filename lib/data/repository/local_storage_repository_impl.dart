import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_prj/domain/repository/local_storage_repository.dart';

class LocalStorageRepositoryImpl implements LocalStorageRepository {
  static const String userTokenKey = "APP_USER_TOKEN";
  static const String userPasswordKey = "APP_USER_PASSWORD";
  static const String userEmailKey = "APP_USER_EMAIL";

  final _sharedPreferences = SharedPreferences.getInstance();

  @override
  Future<bool> loadToken() async {
    final sharedPreferences = await _sharedPreferences;
    return sharedPreferences.getString(userTokenKey)?.isNotEmpty ?? false;
  }

  @override
  Future<void> removeToken() async {
    final sharedPreferences = await _sharedPreferences;
    await sharedPreferences.remove(userTokenKey);
  }

  @override
  Future<void> saveToken({
    required String token,
    required String email,
    required String password,
  }) async {
    final sharedPreferences = await _sharedPreferences;
    await sharedPreferences.setString(userTokenKey, token);
    await sharedPreferences.setString(userPasswordKey, password);
    await sharedPreferences.setString(userPasswordKey, email);
  }
}
