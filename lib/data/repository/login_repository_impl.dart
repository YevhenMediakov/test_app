

import 'package:test_prj/domain/repository/login_repository.dart';

class LoginRepositoryImpl extends LoginRepository {


  LoginRepositoryImpl();


  @override
  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    try {

    } catch (exception) {

    }
  }

  @override
  Future logout() async {

  }


  @override
  Future<void> storeCurrentUserId({required int? userId}) async {
  }


  @override
  Future registerUser() {
    // TODO: implement registerUser
    throw UnimplementedError();
  }
}