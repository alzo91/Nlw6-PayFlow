import 'package:flutter/cupertino.dart';
import 'package:payflow/shared/auth/auth_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController {
  var currentPage = ValueNotifier<int>(0);
  final authController = AuthController();

  void setPage(int index) {
    currentPage.value = index;
  }

  Future<void> onLogout(BuildContext context) async {
    final instace = await SharedPreferences.getInstance();
    instace.clear();
    authController.setUser(context, null);
  }
}
