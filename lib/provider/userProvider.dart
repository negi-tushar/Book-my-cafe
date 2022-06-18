import 'package:flutter/material.dart';
import 'package:restroapp/models/users.dart';
import 'package:restroapp/services/auth.dart';

class UserProvider extends ChangeNotifier {
  Users _user = Users(mobile: '', name: '', email: '', id: '');
  Users get getUser => _user;
  final SignIn _authMethods = SignIn();

  Future<void> refreshUsers() async {
    Users user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
