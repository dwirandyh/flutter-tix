part of 'services.dart';

class UserServices {
  static CollectionReference userCollection =
      Firestore.instance.collection("users");

  static Future updateUser(User user) async {
    userCollection.document(user.id).setData({
      "email": user.email,
      "name": user.name,
      "balance": user.balance,
      "selectedGenres": user.selectedGenres,
      "selectedLanguage": user.selectedLanguage,
      "profilePicture": user.profilePicture ?? ""
    });
  }
}
