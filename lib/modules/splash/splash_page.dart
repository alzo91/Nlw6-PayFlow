import 'package:flutter/material.dart';
import 'package:payflow/shared/auth/auth_controller.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_images.dart';

class SplashWidget extends StatefulWidget {
  const SplashWidget({Key? key}) : super(key: key);

  @override
  _SplashWidgetState createState() => _SplashWidgetState();
}

class _SplashWidgetState extends State<SplashWidget> {
  final authContronller = AuthController();
  @override
  void initState() {
    super.initState();
    /*Future.delayed(Duration(seconds: 2)).then(
      (_) => Navigator.pushReplacementNamed(context, "/login"),
    ); */
    authContronller.loadCurrentUser(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(AppImages.union),
              Image.asset(AppImages.logoFull),
            ],
          ),
        ),
      ),
    );
  }
}
