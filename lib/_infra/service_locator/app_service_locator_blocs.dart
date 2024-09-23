import 'package:get_it/get_it.dart';
import 'package:test_prj/domain/use_case/login/login_use_case.dart';
import 'package:test_prj/domain/use_case/token/load_token_use_case.dart';
import 'package:test_prj/domain/use_case/token/save_token_use_case.dart';
import 'package:test_prj/domain/validators/email_validator.dart';
import 'package:test_prj/domain/validators/password_validator.dart';
import 'package:test_prj/presentation/app/app_cubit.dart';
import 'package:test_prj/presentation/login_screens/login_cubit.dart';

class AppServiceLocatorBlocs {
  static Future<void> setup({required GetIt instance}) async {

    // app
    instance.registerFactory<AppCubit>(() => AppCubit());

    // Login
    instance.registerFactory<LoginCubit>(() => LoginCubit(
          emailValidator: instance<EmailValidator>(),
          loginUserUseCase: instance<LoginUserUseCase>(),
          passwordValidator: instance<PasswordValidator>(),
      saveTokenUseCase: instance<SaveTokenUseCase>(),
        ));
  }
}
