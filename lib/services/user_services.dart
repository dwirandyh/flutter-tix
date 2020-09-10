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

  static Future<User> getUser({@required String id}) async {
    DocumentSnapshot snapshot = await userCollection.document(id).get();

    return User(id, snapshot.data['email'],
        balance: snapshot.data['balance'],
        profilePicture: snapshot.data['profilePicture'],
        selectedGenres: (snapshot.data['selectedGenres'] as List)
            .map((e) => e.toString())
            .toList(),
        selectedLanguage: snapshot.data['selectedLanguage'],
        name: snapshot.data['name']);
  }
}
