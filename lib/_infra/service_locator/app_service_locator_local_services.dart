import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppServiceLocatorLocalServices {
  static Future<void> setup({required GetIt instance}) async {
    instance.registerSingleton(await SharedPreferences.getInstance());
  }
}
