import 'package:animated_confirm_dialog/animated_confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parkxpert/Controller/UserController/user_controller.dart';
import 'package:parkxpert/Views/Widgets/user_screens/user_data_show.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});
  final UserController userController = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: Padding(
          padding: EdgeInsets.only(left: screenwidth * 0.17),
          child: Text(
            "Settings",
            style: GoogleFonts.nobile(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                letterSpacing: 1,
                color: Colors.white),
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.02,
          ),
          UserDataShow(
            text: "Language",
            subtext: "English",
            icon: Icons.arrow_forward_ios,
            color: Colors.white,
            onPressed: () {},
          ),
          SizedBox(
            height: screenHeight * 0.02,
          ),
          UserDataShow(
            text: "Night Mode",
            subtext: "Always Enabled",
            icon: Icons.arrow_forward_ios,
            color: Colors.white,
            onPressed: () {},
          ),
          SizedBox(
            height: screenHeight * 0.02,
          ),
          UserDataShow(
            text: "Rules and terms",
            icon: Icons.arrow_forward_ios,
            color: Colors.white,
            onPressed: () {},
          ),
          SizedBox(
            height: screenHeight * 0.02,
          ),
          UserDataShow(
            text: "Log out",
            color: Colors.white,
            onPressed: () {
              showCustomDialog(
                context: context,
                title: 'Log Out?',
                message: 'Are you sure you want to log out?',
                cancelButtonText: 'No',
                confirmButtonText: 'Yes',
                cancelButtonColor: Colors.red,
                cancelButtonTextColor: Colors.white,
                confirmButtonColor: Colors.green,
                confirmButtonTextColor: Colors.white,
                onCancel: () {
                  Navigator.of(context).pop();
                },
                onConfirm: () {
                  userController.logoutUser();
                },
                isFlip: true,
              );
            },
          ),
          SizedBox(
            height: screenHeight * 0.02,
          ),
          UserDataShow(
            text: "Delete account",
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}
