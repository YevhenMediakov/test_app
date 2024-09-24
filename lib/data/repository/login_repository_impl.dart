import 'package:faker/faker.dart';
import 'package:test_prj/domain/repository/login_repository.dart';

class LoginRepositoryImpl extends LoginRepository {
  final Faker faker = Faker();
  LoginRepositoryImpl();

  @override
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      return faker.jwt.valid();
    } catch (exception) {
      rethrow;
    }
  }
}
