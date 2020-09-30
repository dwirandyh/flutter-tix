part of 'services.dart';

class UserServices {
  static CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");

  static Future updateUser(User user) async {
    userCollection.doc(user.id).set({
      "email": user.email,
      "name": user.name,
      "balance": user.balance,
      "selectedGenres": user.selectedGenres,
      "selectedLanguage": user.selectedLanguage,
      "profilePicture": user.profilePicture ?? ""
    });
  }

  static Future<User> getUser({@required String id}) async {
    DocumentSnapshot snapshot = await userCollection.doc(id).get();
    final data = snapshot.data();
    return User(id, data["email"],
        balance: data['balance'] ?? "",
        profilePicture: data['profilePicture'] ?? "",
        selectedGenres:
            (data['selectedGenres'] as List).map((e) => e.toString()).toList(),
        selectedLanguage: data['selectedLanguage'] ?? "",
        name: data['name'] ?? "");
  }
}
