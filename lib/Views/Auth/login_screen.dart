import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parkxpert/Controller/UserController/user_controller.dart';
import 'package:parkxpert/Interface/Auth/login_service.dart';
import 'package:parkxpert/Views/Widgets/textfeilds/account_asker.dart';
import 'package:parkxpert/Views/Widgets/textfeilds/text_feild_input.dart';
import 'package:parkxpert/res/routes/route_name.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginState createState() => _LoginState();
}

final loginService = Get.put(LoginService());

class _LoginState extends State<LoginScreen> {
  final UserController userController = Get.find<UserController>();
  final RoundedLoadingButtonController controller =
      RoundedLoadingButtonController();
  final _formKey = GlobalKey<FormState>();

  final _emailController = loginService.emailController.value;
  final _passwordController = loginService.passwordController.value;

  String emailError = '';
  String passwordError = '';

  void resetFields() {
    _emailController.clear();
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: screenHeight,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/auth.jpg"),
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high),
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
                    style: GoogleFonts.nobile(
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
                    SizedBox(height: screenHeight * 0.02),
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
                        Get.offNamed(RouteName.signup);
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
                          onPressed: () async {
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
                              controller.start();

                              bool isLoggedIn = await userController.loginUser(
                                _emailController.text.trim(),
                                _passwordController.text.trim(),
                              );

                              if (isLoggedIn) {
                                Future.delayed(Duration(seconds: 3), () {
                                  Get.offNamed(RouteName.userScreen);
                                  resetFields();
                                });
                              } else {
                                controller.error();
                                Timer(Duration(seconds: 3), () {
                                  controller.reset();
                                  resetFields();
                                });
                              }
                            } else {
                              controller.error();
                              Timer(Duration(seconds: 3), () {
                                controller.reset();
                              });
                            }
                          },
                          color: Colors.blueAccent,
                          width: screenWidth * 0.4,
                          height: screenHeight * 0.07,
                          borderRadius: 25,
                          successColor: Colors.green,
                          errorColor: Colors.red,
                          animateOnTap: true,
                          child: Text(
                            'Login',
                            style: GoogleFonts.nobile(
                              fontSize: screenWidth * 0.05,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
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
