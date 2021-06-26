import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:payflow/shared/auth/auth_controller.dart';
import 'package:payflow/shared/models/user_model.dart';

class LoginController {
  final authController = AuthController();

  Future<void> googleSignIn(BuildContext context) async {
    print("We gonna login with Google!");

    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
      ],
    );
    try {
      final response = await _googleSignIn.signIn();
      // if (response.authentication.)
      // print(response);

      final user =
          UserModel(name: response!.displayName!, photoUrl: response.photoUrl);
          
      authController.setUser(context, user);
    } catch (error) {
      print("Error LoginController | googleSignIn");
      print(error.toString());
      authController.setUser(context, null);
    }
  }
}
