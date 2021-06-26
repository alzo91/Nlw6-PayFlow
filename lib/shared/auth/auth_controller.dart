import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:payflow/shared/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  final _isAuthenticated = ValueNotifier(false);
  // ignore: non_constant_identifier_names
  static String KEY_PREFERENCE_USER = "payflow@user";

  UserModel? _user;

  UserModel get user => _user!;

  get isAuthenticated => _isAuthenticated;

  void setUser(BuildContext context, UserModel? user) {
    if (user == null) {
      _isAuthenticated.value = false;
      Navigator.pushReplacementNamed(context, "/login");
      return;
    }

    _isAuthenticated.value = true;
    _user = user;
    saveUser(user);
    Navigator.pushReplacementNamed(context, "/home", arguments: user);
  }

  Future<void> saveUser(UserModel user) async {
    final instace = await SharedPreferences.getInstance();
    await instace.setString(KEY_PREFERENCE_USER, user.toJson());
    return;
  }

  Future<void> loadCurrentUser(BuildContext context) async {
    final instance = await SharedPreferences.getInstance();
    await Future.delayed(Duration(seconds: 2));
    if (instance.containsKey(KEY_PREFERENCE_USER)) {
      final json = instance.getString(KEY_PREFERENCE_USER) as String;
      setUser(context, UserModel.fromJson(json));
    } else {
      setUser(context, null);
    }

    return;
  }
}
