import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:parkxpert/Views/Auth/Signup.dart';
import 'package:parkxpert/Views/Widgets/textfeilds/account_asker.dart';
import 'package:parkxpert/Views/Widgets/textfeilds/text_feild_input.dart';
import 'package:parkxpert/Views/user_screen/main_screen.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final RoundedLoadingButtonController controller =
      RoundedLoadingButtonController();
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String emailError = '';
  String passwordError = '';

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: screenHeight,
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
              Padding(
                padding: EdgeInsets.all(screenWidth * 0.05),
                child: ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [Colors.white, Colors.blueAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds),
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
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFeildInput(
                      controller: _emailController,
                      labeltext: "Email",
                      hinttext: "Enter Your Email",
                      icon: Icons.email,
                      inputtpe: TextInputType.emailAddress,
                    ),
                    if (emailError.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.only(
                            top: screenHeight * 0.003,
                            left: screenWidth * 0.10),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            emailError,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: screenWidth * 0.03,
                            ),
                          ),
                        ),
                      ),
                    SizedBox(height: screenHeight * 0.01),
                    TextFeildInput(
                      controller: _passwordController,
                      labeltext: "Password",
                      hinttext: "Enter Your Password",
                      icon: Icons.password,
                      inputtpe: TextInputType.visiblePassword,
                      hide: true,
                    ),
                    if (passwordError.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.only(
                            top: screenHeight * 0.003,
                            left: screenWidth * 0.10),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            passwordError,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: screenWidth * 0.03,
                            ),
                          ),
                        ),
                      ),
                    SizedBox(height: screenHeight * 0.015),
                    AccountAsker(
                      maintet: "Don't have an account? ",
                      subtext: "Sign up",
                      func: () {
                        Navigator.pushReplacement(
                          context,
                          PageTransition(
                            type: PageTransitionType.fade,
                            duration: Durations.medium3,
                            child: Signup(),
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.2,
                        vertical: screenHeight * 0.03,
                      ),
                      child: Hero(
                        tag: "auth",
                        child: RoundedLoadingButton(
                          controller: controller,
                          onPressed: () {
                            if (_emailController.text.isEmpty) {
                              setState(() {
                                emailError = 'Email cannot be empty.';
                              });
                            } else {
                              setState(() {
                                emailError = '';
                              });
                            }

                            if (_passwordController.text.isEmpty) {
                              setState(() {
                                passwordError = 'Password cannot be empty.';
                              });
                            } else {
                              setState(() {
                                passwordError = '';
                              });
                            }

                            if (_emailController.text.isNotEmpty &&
                                _passwordController.text.isNotEmpty) {
                              Timer(Duration(seconds: 3), () {
                                Navigator.pushReplacement(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: MainScreen(),
                                  ),
                                );
                                controller.success();
                              });
                            } else {
                              controller.error();
                              Timer(Duration(seconds: 3), () {
                                controller.reset();
                              });
                            }
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
                          width: screenWidth * 0.4,
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
            ],
          ),
        ),
      ),
    );
  }
}
