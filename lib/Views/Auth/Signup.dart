import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:parkxpert/Views/Auth/Login.dart';
import 'package:parkxpert/Views/Widgets/textfeilds/account_asker.dart';
import 'package:parkxpert/Views/Widgets/textfeilds/text_feild_input.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

class Signup extends StatelessWidget {
  Signup({super.key});

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding:
                      EdgeInsets.all(screenWidth * 0.05), // Flexible padding
                  child: Text(
                    "Sign Up",
                    style: GoogleFonts.poppins(
                      fontSize: screenWidth * 0.08, // Responsive font size
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              TextFeildInput(
                labeltext: "Name",
                hinttext: "Enter Your Name",
                icon: Icons.person,
                inputtpe: TextInputType.name,
              ),
              SizedBox(height: screenHeight * 0.015),
              TextFeildInput(
                labeltext: "Email",
                hinttext: "Enter Your Email",
                icon: Icons.email,
                inputtpe: TextInputType.emailAddress,
              ),
              SizedBox(height: screenHeight * 0.015),
              TextFeildInput(
                labeltext: "Phone Number",
                hinttext: "Enter Your number",
                icon: Icons.phone,
                inputtpe: TextInputType.phone,
              ),
              SizedBox(height: screenHeight * 0.015),
              TextFeildInput(
                labeltext: "Password",
                hinttext: "Enter Your Password",
                icon: Icons.password,
                inputtpe: TextInputType.visiblePassword,
                hide: true,
              ),
              SizedBox(height: screenHeight * 0.015),
              TextFeildInput(
                labeltext: "Confirm Password",
                hinttext: "Enter Your Password",
                icon: Icons.password,
                inputtpe: TextInputType.visiblePassword,
                hide: true,
              ),
              SizedBox(height: screenHeight * 0.015),
              AccountAsker(
                maintet: "Already have an account? ",
                subtext: "Login",
                func: () {
                  context.pushTransition(
                    type: PageTransitionType.fade,
                    duration: Durations.medium3,
                    child: Login(),
                  );
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.2, // Adjust width of button
                  vertical: screenHeight * 0.03, // Adjust height of button
                ),
                child: Hero(
                  tag: "auth",
                  child: RoundedLoadingButton(
                    controller: controller,
                    onPressed: () {
                      Timer(Duration(seconds: 3), () {
                        context.pushReplacementTransition(
                          type: PageTransitionType.rightToLeft,
                          duration: Durations.medium3,
                          child: Login(),
                        );
                        controller.success();
                      });
                    },
                    child: Text(
                      'Create Account',
                      style: TextStyle(
                        fontSize: screenWidth * 0.05, // Adjust button text size
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    color: Colors.blueAccent,
                    width: screenWidth * 0.6, // Responsive width
                    height: screenHeight * 0.07, // Responsive height
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
    );
  }
}
