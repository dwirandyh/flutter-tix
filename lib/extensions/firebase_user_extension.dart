part of 'extensions.dart';

extension FirebaseUserExtension on FireAuth.User {
  User convertToUser(
      {String name = "No Name",
      List<String> selectedGenre = const [],
      String selectedLanguage = "English",
      int balance = 50000}) {
    return User(this.uid, this.email,
        name: name,
        balance: balance,
        selectedGenres: selectedGenre,
        selectedLanguage: selectedLanguage);
  }

  Future<User> fromFireStore() async {
    return await UserServices.getUser(id: this.uid);
  }
}
