import 'package:faker/faker.dart';

interface class LoginRepository {
  final Faker faker = Faker();

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 2));
    return faker.jwt.valid();
  }
}
