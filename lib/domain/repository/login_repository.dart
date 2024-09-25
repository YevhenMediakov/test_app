
abstract class LoginRepository {
  Future<String> loginUser({required String email, required String password});
}