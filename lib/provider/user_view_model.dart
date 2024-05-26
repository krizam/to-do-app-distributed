import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/user_model.dart';

import '../repository/user_repository.dart';
import '../service/firebase_service.dart';

class UserViewModel with ChangeNotifier {
  User? _user = FirebaseService.firebaseAuth.currentUser;

  User? get user => _user;

  UserModel? _loggedInUser;
  UserModel? get loggedInUser => _loggedInUser;

  Future<void> login(String email, String password) async {
    try {
      var response = await UserRepository().login(email, password);
      _user = response.user;
      _loggedInUser = await UserRepository().getUserDetail(_user!.uid, _token);
      notifyListeners();
    } catch (err) {
      UserRepository().logout();
      rethrow;
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await UserRepository().resetPassword(email);
      notifyListeners();
    } catch (err) {
      rethrow;
    }
  }

  Future<void> register(UserModel user) async {
    try {
      var response = await UserRepository().register(user);
      _user = response!.user;
      _loggedInUser = await UserRepository().getUserDetail(_user!.uid, _token);
      notifyListeners();
    } catch (err) {
      UserRepository().logout();
      rethrow;
    }
  }

  String? _token;
  String? get token => _token;
  Future<void> checkLogin(String? token) async {
    try {
      _loggedInUser = await UserRepository().getUserDetail(_user!.uid, token);
      _token = token;
      notifyListeners();
    } catch (err) {
      _user = null;
      UserRepository().logout();
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await UserRepository().logout();
      _user = null;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

}
