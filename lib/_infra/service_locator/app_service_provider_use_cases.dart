import 'package:get_it/get_it.dart';
import 'package:test_prj/domain/repository/login_repository.dart';
import 'package:test_prj/domain/use_case/login/login_use_case.dart';

class AppServiceLocatorUseCases {
  static Future<void> setup({required GetIt instance}) async {
    instance.registerFactory<LoginUserUseCase>(() => LoginUserUseCase(
          loginRepository: instance<LoginRepository>(),
        ));
  }
}
