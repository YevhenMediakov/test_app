import 'package:get_it/get_it.dart';
import 'package:test_prj/data/repository/login_repository_impl.dart';
import 'package:test_prj/domain/repository/login_repository.dart';

class AppServiceLocatorRepositories {
  static Future<void> setup({required GetIt instance}) async {
    instance.registerLazySingleton<LoginRepository>(
      () => LoginRepositoryImpl(),
    );
  }
}
