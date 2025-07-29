import 'package:flutter/material.dart';
import 'package:crossapp/models/user.dart';

class AuthService with ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  bool get isLoggedIn => _user != null;

  Future<void> signIn(String email, String password) async {
    if (email == 'demo1' && password == 'demo1') {
      _user = UserModel(uid: '1', email: 'demo1', role: 'athlete');
      notifyListeners();
    } else if (email == 'demo2' && password == 'demo2') {
      _user = UserModel(uid: '2', email: 'demo2', role: 'coach');
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    _user = null;
    notifyListeners();
  }
}
