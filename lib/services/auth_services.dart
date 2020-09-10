part of 'services.dart';

class AuthServices {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<ServiceResult<User>> signUp(String email, String password,
      String name, List<String> selectedGenres, String selectedLanguage) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      User user = result.user.convertToUser(
          name: name,
          selectedGenre: selectedGenres,
          selectedLanguage: selectedLanguage);

      await UserServices.updateUser(user);

      return ServiceResult<User>(data: user);
    } catch (e) {
      return ServiceResult<User>(message: e.toString());
    }
  }
}
