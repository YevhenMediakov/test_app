
abstract class LoginRepository {
  Future loginUser({required String email, required String password});
  Future registerUser();
  Future logout();

  Future storeCurrentUserId({required final int userId});
}