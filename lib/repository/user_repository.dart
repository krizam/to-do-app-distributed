import '../model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../service/firebase_service.dart';


class UserRepository {
  CollectionReference<UserModel> userRef =
  FirebaseService.db.collection("users").withConverter<UserModel>(
    fromFirestore: (snapshot, _) {
      return UserModel.fromFirebaseSnapshot(snapshot);
    },
    toFirestore: (model, _) => model.toJson(),
  );


  Future<UserCredential?> register(UserModel user) async {
    try {
      // Check if the email is already registered
      final emailCheck = await userRef.where("email", isEqualTo: user.email).get();
      if (emailCheck.docs.isNotEmpty) {
        throw Exception("Email already exists");
      }

      // Create the user in Firebase Authentication
      UserCredential uc = await FirebaseService.firebaseAuth.createUserWithEmailAndPassword(
        email: user.email!,
        password: user.password!,
      );

      // Set user properties
      user.userId = uc.user!.uid;
      user.fcm = "";

      // Insert user data into Firestore
      await userRef.doc(uc.user!.uid).set(user);

      return uc;
    } catch (err) {
      print("Error during registration: $err");
      rethrow;
    }
  }



  Future<UserCredential> login(String email, String password) async {
    try {
      UserCredential uc = await FirebaseService.firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return uc;
    } catch (err) {
      rethrow;
    }
  }

  Future<UserModel> getUserDetail(String id, String? token) async {
    try {

      final response = await userRef.doc(id).get();
      var user = response.data()!;
      user.fcm = token ?? "";
      await userRef.doc(user.id).set(user);
      return user;
    } catch (err) {
      rethrow;
    }
  }

  Future<bool> resetPassword(String email) async {
    try {
      var res = await FirebaseService.firebaseAuth
          .sendPasswordResetEmail(email: email);
      return true;
    } catch (err) {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await FirebaseService.firebaseAuth.signOut();
    } catch (err) {
      rethrow;
    }
  }
}