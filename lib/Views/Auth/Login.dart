import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:parkxpert/Views/Auth/Signup.dart';
import 'package:parkxpert/Views/Widgets/textfeilds/account_asker.dart';
import 'package:parkxpert/Views/Widgets/textfeilds/text_feild_input.dart';
import 'package:parkxpert/Views/user_screen/main_screen.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final RoundedLoadingButtonController controller =
      RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: screenHeight * 1,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.black],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Container(
            color: Colors.black.withOpacity(0.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.all(screenWidth * 0.05),
                    child: Text(
                      "Login",
                      style: GoogleFonts.poppins(
                        fontSize: screenWidth * 0.08,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                TextFeildInput(
                  labeltext: "Email",
                  hinttext: "Enter Your Email",
                  icon: Icons.email,
                  inputtpe: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: screenHeight * 0.015,
                ),
                TextFeildInput(
                  labeltext: "Password",
                  hinttext: "Enter Your Password",
                  icon: Icons.password,
                  inputtpe: TextInputType.visiblePassword,
                  hide: true,
                ),
                SizedBox(
                  height: screenHeight * 0.015,
                ),
                AccountAsker(
                  maintet: "Don't have an account? ",
                  subtext: "Sign Up",
                  func: () {
                    context.pushTransition(
                      type: PageTransitionType.fade,
                      duration: Durations.medium3,
                      child: Signup(),
                    );
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.02,
                      vertical: screenHeight * 0.03),
                  child: Hero(
                    tag: "auth",
                    child: RoundedLoadingButton(
                      controller: controller,
                      onPressed: () {
                        Timer(Duration(seconds: 3), () {
                          context.pushReplacementTransition(
                            type: PageTransitionType.rightToLeft,
                            duration: Durations.medium3,
                            child: MainScreen(),
                          );
                          controller.success();
                        });
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      color: Colors.blueAccent,
                      width: screenWidth * 0.6,
                      height: screenHeight * 0.07,
                      borderRadius: 25,
                      successColor: Colors.green,
                      errorColor: Colors.red,
                      animateOnTap: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
