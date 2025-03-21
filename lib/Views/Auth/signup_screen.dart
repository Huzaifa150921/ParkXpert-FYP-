import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parkxpert/Controller/UserController/user_controller.dart';
import 'package:parkxpert/Interface/Auth/signup_service.dart';
import 'package:parkxpert/Views/Widgets/textfeilds/account_asker.dart';
import 'package:parkxpert/Views/Widgets/textfeilds/text_feild_input.dart';
import 'package:parkxpert/res/routes/route_name.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignupState createState() => _SignupState();
}

final signupService = Get.put(SignupService());

class _SignupState extends State<SignupScreen> {
  final RoundedLoadingButtonController controller =
      RoundedLoadingButtonController();

  final UserController userController = Get.find<UserController>();
  final _formKey = GlobalKey<FormState>();

  final _nameController = signupService.nameController.value;
  final _emailController = signupService.emailController.value;
  final _phoneController = signupService.phoneNumberController.value;
  final _passwordController = signupService.passwordController.value;
  final _confirmPasswordController =
      signupService.confirmPasswordController.value;

  bool _isEmailValid = true;
  bool _isPhoneValid = true;
  bool _isPasswordValid = false;
  bool _doPasswordsMatch = false;
  bool hasMinLength = false;
  bool hasUppercase = false;
  bool hasSpecialCharacter = false;
  bool hasNumber = false;

  String nameError = '';
  String emailError = '';
  String phoneError = '';
  String passwordError = '';
  String confirmPasswordError = '';

  void _validateName() {
    setState(() {
      nameError = _nameController.text.isEmpty ? 'Name cannot be empty.' : '';
    });
  }

  void _validateEmail() {
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regExp = RegExp(pattern);
    setState(() {
      _isEmailValid = regExp.hasMatch(_emailController.text);
      emailError = _isEmailValid ? '' : 'Please enter a valid email address.';
    });
  }

  void _validatePhone() {
    String pattern = r'^[0-9]{11}$';
    RegExp regExp = RegExp(pattern);
    setState(() {
      _isPhoneValid = regExp.hasMatch(_phoneController.text);
      phoneError = _isPhoneValid ? '' : 'Please enter a valid phone number.';
    });
  }

  void _validatePassword() {
    String password = _passwordController.text;
    setState(() {
      hasMinLength = password.length >= 8;
      hasUppercase = password.contains(RegExp(r'[A-Z]'));
      hasSpecialCharacter =
          password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
      hasNumber = password.contains(RegExp(r'[0-9]'));
      _isPasswordValid =
          hasMinLength && hasUppercase && hasSpecialCharacter && hasNumber;
      passwordError = _isPasswordValid ? '' : 'Please enter a valid password.';
    });
  }

  void _checkPasswordMatch() {
    setState(() {
      _doPasswordsMatch =
          _passwordController.text == _confirmPasswordController.text;
      confirmPasswordError = _doPasswordsMatch ? '' : 'Passwords do not match.';
    });
  }

  void resetFields() {
    _nameController.clear();
    _emailController.clear();
    _phoneController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
  }

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_validateEmail);
    _phoneController.addListener(_validatePhone);
    _passwordController.addListener(_validatePassword);
    _confirmPasswordController.addListener(_checkPasswordMatch);
    _nameController.addListener(_validateName);
  }

  @override
  void dispose() {
    _emailController.removeListener(_validateEmail);
    _phoneController.removeListener(_validatePhone);
    _passwordController.removeListener(_validatePassword);
    _confirmPasswordController.removeListener(_checkPasswordMatch);
    _nameController.removeListener(_validateName);
    super.dispose();
  }

  Widget _buildPasswordRequirement(String text, bool isValid) {
    return Row(
      children: [
        Icon(
          isValid ? Icons.check_box_outlined : Icons.check_box_outline_blank,
          color: isValid ? Colors.green : Colors.red,
          size: 16,
        ),
        SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            color: isValid ? Colors.green : Colors.red,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
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
                    "Sign Up",
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
                    // Name Input Field
                    TextFeildInput(
                      controller: _nameController,
                      labeltext: "Name",
                      hinttext: "Enter Your Name",
                      icon: Icons.person,
                      inputtpe: TextInputType.name,
                    ),
                    if (nameError.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.only(
                            top: screenHeight * 0.001,
                            left: screenWidth * 0.10),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(nameError,
                              style: TextStyle(color: Colors.red)),
                        ),
                      ),
                    SizedBox(height: screenHeight * 0.02),

                    // Email Input Field
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
                            top: screenHeight * 0.001,
                            left: screenWidth * 0.10),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(emailError,
                              style: TextStyle(color: Colors.red)),
                        ),
                      ),
                    SizedBox(height: screenHeight * 0.02),

                    // Phone Input Field
                    TextFeildInput(
                      controller: _phoneController,
                      labeltext: "Phone Number",
                      hinttext: "Enter Your Phone Number",
                      icon: Icons.phone,
                      inputtpe: TextInputType.phone,
                    ),
                    if (phoneError.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.only(
                            top: screenHeight * 0.001,
                            left: screenWidth * 0.10),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(phoneError,
                              style: TextStyle(color: Colors.red)),
                        ),
                      ),
                    SizedBox(height: screenHeight * 0.02),

                    // Password Input Field
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
                            top: screenHeight * 0.001,
                            left: screenWidth * 0.10),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(passwordError,
                              style: TextStyle(color: Colors.red)),
                        ),
                      ),
                    if (_passwordController.text.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.01,
                          horizontal: screenWidth * 0.05,
                        ),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildPasswordRequirement(
                                  "At least 8 characters", hasMinLength),
                              _buildPasswordRequirement(
                                  "At least 1 uppercase letter", hasUppercase),
                              _buildPasswordRequirement(
                                  "At least 1 number", hasNumber),
                              _buildPasswordRequirement(
                                  "At least 1 special character",
                                  hasSpecialCharacter),
                            ],
                          ),
                        ),
                      ),
                    SizedBox(height: screenHeight * 0.02),

                    // Confirm Password Input Field
                    TextFeildInput(
                      controller: _confirmPasswordController,
                      labeltext: "Confirm Password",
                      hinttext: "Re-enter Your Password",
                      icon: Icons.password,
                      inputtpe: TextInputType.visiblePassword,
                      hide: true,
                    ),
                    if (confirmPasswordError.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.only(
                            top: screenHeight * 0.001,
                            left: screenWidth * 0.10),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(confirmPasswordError,
                              style: TextStyle(color: Colors.red)),
                        ),
                      ),
                    SizedBox(height: screenHeight * 0.01),

                    AccountAsker(
                      maintet: "Already have an account? ",
                      subtext: "Login",
                      func: () {
                        Get.offNamed(RouteName.login);
                        resetFields();
                      },
                    ),

                    // Signup Button
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
                            if (_nameController.text.isEmpty) {
                              setState(() {
                                nameError = 'Name cannot be empty.';
                              });
                            }
                            if (_emailController.text.isEmpty) {
                              setState(() {
                                emailError = 'Email cannot be empty.';
                              });
                            }
                            if (_phoneController.text.isEmpty) {
                              setState(() {
                                phoneError = 'Phone number cannot be empty.';
                              });
                            }
                            if (_passwordController.text.isEmpty) {
                              setState(() {
                                passwordError = 'Password cannot be empty.';
                              });
                            }
                            if (_confirmPasswordController.text.isEmpty) {
                              setState(() {
                                confirmPasswordError =
                                    'Password cannot be empty.';
                              });
                            }

                            if (_emailController.text.isNotEmpty &&
                                _phoneController.text.isNotEmpty &&
                                _passwordController.text.isNotEmpty &&
                                _confirmPasswordController.text.isNotEmpty &&
                                _isEmailValid &&
                                _isPhoneValid &&
                                _isPasswordValid &&
                                _doPasswordsMatch) {
                              controller.start();

                              bool success = await userController.registerUser(
                                _nameController.text.trim(),
                                _emailController.text.trim(),
                                _passwordController.text.trim(),
                                _phoneController.text.trim(),
                                "user",
                              );

                              if (success) {
                                Future.delayed(Duration(seconds: 3), () {
                                  Get.offNamed(RouteName.login);
                                });
                                resetFields();
                              } else {
                                controller.error();
                                Timer(Duration(seconds: 3), () {
                                  controller.reset();
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
                          width: screenWidth * 0.6,
                          height: screenHeight * 0.07,
                          borderRadius: 25,
                          successColor: Colors.green,
                          errorColor: Colors.red,
                          animateOnTap: true,
                          child: Text(
                            'Create Account',
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
