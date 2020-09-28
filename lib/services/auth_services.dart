part of 'services.dart';

class AuthServices {
  static FireAuth.FirebaseAuth auth = FireAuth.FirebaseAuth.instance;

  static Future<ServiceResult<User>> signUp(String email, String password,
      String name, List<String> selectedGenres, String selectedLanguage) async {
    try {
      FireAuth.UserCredential result = await auth
          .createUserWithEmailAndPassword(email: email, password: password);

      User user = result.user.convertToUser(
          name: name,
          selectedGenre: selectedGenres,
          selectedLanguage: selectedLanguage);

      await UserServices.updateUser(user);

      return ServiceResult<User>(data: user);
    } catch (e) {
      return ServiceResult<User>(message: e.message);
    }
  }

  static Future<ServiceResult<User>> signIn(
      {@required String email, @required String password}) async {
    try {
      FireAuth.UserCredential result = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = await result.user.fromFireStore();
      return ServiceResult<User>(data: user);
    } catch (e) {
      return ServiceResult<User>(message: e.message);
    }
  }

  static Future<void> signOut() async {
    await auth.signOut();
  }

  static Stream<FireAuth.User> get userStream => auth.authStateChanges();
}
