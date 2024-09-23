import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_prj/_infra/enviroment/enviroment_keys.dart';
import 'package:test_prj/_infra/service_locator/app_service_locator.dart';
import 'package:test_prj/domain/repository/local_storage_repository.dart';



class LocalStorageRepositoryImpl extends LocalStorageRepository {
  LocalStorageRepositoryImpl();
  final SharedPreferences _sharedPreferences = getIt<SharedPreferences>();

  @override
  Future<bool> loadToken() async {
    try{
     return _sharedPreferences.getString(AppKeys.userTokenKey)?.isNotEmpty ?? false;
    } catch(e){
      rethrow;
    }
  }

  @override
  Future removeToken() async{
    try{
      await _sharedPreferences.remove(AppKeys.userTokenKey);
    } catch(e){
      rethrow;
    }
  }

  @override
  Future saveToken({required String token}) async {
    try{
       await _sharedPreferences.setString(AppKeys.userTokenKey, token);
    } catch(e){
      rethrow;
    }
  }
}
