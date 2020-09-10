part of 'services.dart';

class AuthServices {
  static FirebaseAuth auth = FirebaseAuth.instance;

  static Future<ServiceResult<User>> signUp(String email, String password,
      String name, List<String> selectedGenres, String selectedLanguage) async {
    try {
      AuthResult result = await auth.createUserWithEmailAndPassword(
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

  static Future<ServiceResult<User>> signIn(
      {@required String email, @required String password}) async {
    try {
      AuthResult result = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = await result.user.fromFireStore();
      return ServiceResult<User>(data: user);
    } catch (e) {
      return ServiceResult<User>(message: e.toString().split(',')[1]);
    }
  }

  static Future<void> signOut() async {
    await auth.signOut();
  }
}
