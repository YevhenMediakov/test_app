import 'package:test_prj/domain/repository/login_repository.dart';

class LoginUserUseCase {
  final LoginRepository _loginRepository;

  LoginUserUseCase({
    required LoginRepository loginRepository,
  }): _loginRepository = loginRepository;


  Future<String> execute({ required String email, required String password,}) async {
    return _loginRepository.loginUser(email: email, password: password);
  }
}