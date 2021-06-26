import 'package:flutter/material.dart';

import 'package:payflow/modules/extract/extract_page.dart';
import 'package:payflow/modules/home/home_controller.dart';
import 'package:payflow/modules/meus_boletos/meus_boletos_page.dart';
import 'package:payflow/shared/models/user_model.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';

class HomePage extends StatefulWidget {
  final UserModel user;
  const HomePage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeController = HomeController();

  @override
  Widget build(BuildContext context) {
    // final authController = AuthController();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(152),
        child: Container(
          height: 152,
          color: AppColors.primary,
          child: Center(
            child: ListTile(
              title: Text.rich(TextSpan(
                  text: "Olá, ",
                  style: TextStyles.titleRegular,
                  children: [
                    TextSpan(
                      text: "${widget.user.name}",
                      style: TextStyles.titleBoldBackground,
                    )
                  ])),
              subtitle: Text(
                "Mantenha suas contas em dia",
                style: TextStyles.captionShape,
              ),
              trailing: GestureDetector(
                onTap: () => homeController.onLogout(context),
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                          image: NetworkImage(widget.user.photoUrl!))),
                ),
              ),
            ),
          ),
        ),
      ),
      body: ValueListenableBuilder<int>(
        valueListenable: homeController.currentPage,
        builder: (_, value, __) {
          return [
            MeusBoletosPage(
              key: UniqueKey(),
            ),
            ExtractPage(key: UniqueKey())
          ][value];
        },
      ),
      bottomNavigationBar: Container(
        height: 65,
        color: Color(0xFFE3E3E3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                print("You clicked first button!");
                homeController.setPage(0);
              },
              icon: ValueListenableBuilder<int>(
                valueListenable: homeController.currentPage,
                builder: (context, value, _) => Icon(
                  Icons.home,
                  color: value == 0 ? AppColors.primary : AppColors.body,
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                print("You clicked center button!");
                await Navigator.pushNamed(context, "/barcode_scanner");
                await Future.delayed(Duration(seconds: 1));
                setState(() {});
                // Navigator.pushNamed(context, "/insert_boleto");
              },
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Icon(Icons.add_box_outlined, color: AppColors.body),
              ),
            ),
            IconButton(
                onPressed: () {
                  print("You clicked final button!");
                  homeController.setPage(1);
                },
                icon: ValueListenableBuilder<int>(
                  valueListenable: homeController.currentPage,
                  builder: (context, value, _) => Icon(
                    Icons.home,
                    color: value == 1 ? AppColors.primary : AppColors.body,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
