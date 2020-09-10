part of 'extensions.dart';

extension FirebaseUserExtension on FirebaseUser {
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
}
