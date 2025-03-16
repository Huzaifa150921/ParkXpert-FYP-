import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parkxpert/Controller/UserController/user_controller.dart';
import 'package:parkxpert/Views/Widgets/Custom%20dialog%20box/custom_dialog.dart';
import 'package:parkxpert/Views/Widgets/user_screens/user_data_show.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final UserController userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double avatarSize = screenWidth * 0.4;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: Padding(
          padding: EdgeInsets.only(left: screenWidth * 0.15),
          child: Text(
            "My Profile",
            style: GoogleFonts.nobile(
              fontSize: screenWidth * 0.06,
              fontWeight: FontWeight.w500,
              letterSpacing: 1,
              color: Colors.white,
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined,
              color: Colors.white),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Obx(() {
            final user = userController.currentUser.value;
            if (user == null) {
              return const CircularProgressIndicator();
            }
            final TextEditingController nameController =
                TextEditingController(text: user.name);
            final TextEditingController emailController =
                TextEditingController(text: user.email);
            final TextEditingController phoneController =
                TextEditingController(text: user.phoneNumber);
            final RxBool isButtonDisabled = true.obs;

            void validateInput(String value) {
              isButtonDisabled.value = value.isEmpty || value == user.name;
            }

            bool isValidEmailFormat(String email) {
              final emailRegex =
                  RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
              return emailRegex.hasMatch(email);
            }

            void validateEmailInput(String value) {
              isButtonDisabled.value = value.isEmpty ||
                  value == user.email ||
                  !isValidEmailFormat(value);
            }

            bool isValidPhoneNumber(String phone) {
              final phoneRegex = RegExp(r'^\d{11}$');
              return phoneRegex.hasMatch(phone);
            }

            void validatePhoneNumberInput(String value) {
              isButtonDisabled.value = value.isEmpty ||
                  value == user.phoneNumber ||
                  !isValidPhoneNumber(value);
            }

            return Column(
              children: [
                SizedBox(height: screenHeight * 0.06),
                Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showGeneralDialog(
                          context: context,
                          barrierDismissible: true,
                          barrierLabel: '',
                          transitionDuration: const Duration(milliseconds: 300),
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                            return GestureDetector(
                              onTap: () => Navigator.of(context).pop(),
                              behavior: HitTestBehavior.opaque,
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
                                child: Dialog(
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,
                                  child: Center(
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: CircleAvatar(
                                        radius: avatarSize * 0.68,
                                        backgroundColor: Colors.white,
                                        backgroundImage: AssetImage(
                                          user.profilePic ??
                                              "assets/images/default_profile_pic.jfif",
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          transitionBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                        );
                      },
                      child: Container(
                        width: avatarSize,
                        height: avatarSize,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              // ignore: deprecated_member_use
                              color: Colors.blueAccent.withOpacity(0.7),
                              width: 4),
                          gradient: const LinearGradient(
                            colors: [Colors.red, Colors.purpleAccent],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: avatarSize * 0.48,
                          backgroundColor: Colors.white,
                          backgroundImage: AssetImage(
                            user.profilePic ??
                                "assets/images/default_profile_pic.jfif",
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: screenHeight * 0.15,
                      left: screenWidth * 0.26,
                      child: GestureDetector(
                        onTap: () {
                          userController.updateProfilePic();
                        },
                        child: Icon(
                          Icons.camera_alt,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.07),
                UserDataShow(
                  text: "Name",
                  subtext: user.name,
                  icon: Icons.arrow_forward_ios,
                  color: Colors.white,
                  onPressed: () {
                    CustomAwesomeDialog.show(
                      icon: Icons.person,
                      type: TextInputType.text,
                      context: context,
                      controller: nameController,
                      onChanged: validateInput,
                      isButtonDisabled: isButtonDisabled,
                      onConfirm: () {
                        userController.updateUserName(nameController.text);
                        Get.back();
                      },
                    );
                  },
                ),
                SizedBox(height: screenHeight * 0.02),
                UserDataShow(
                  text: "Email",
                  subtext: user.email,
                  icon: Icons.arrow_forward_ios,
                  color: Colors.white,
                  onPressed: () {
                    CustomAwesomeDialog.show(
                      icon: Icons.email,
                      type: TextInputType.emailAddress,
                      context: context,
                      controller: emailController,
                      onChanged: validateEmailInput,
                      isButtonDisabled: isButtonDisabled,
                      onConfirm: () {
                        userController.updateUserEmail(emailController.text);
                        Get.back();
                      },
                    );
                  },
                ),
                SizedBox(height: screenHeight * 0.02),
                UserDataShow(
                  text: "Password",
                  subtext: "*************",
                  icon: Icons.arrow_forward_ios,
                  color: Colors.white,
                  onPressed: () {},
                ),
                SizedBox(height: screenHeight * 0.02),
                UserDataShow(
                  text: "Phone Number",
                  subtext: user.phoneNumber,
                  icon: Icons.arrow_forward_ios,
                  color: Colors.white,
                  onPressed: () {
                    CustomAwesomeDialog.show(
                      icon: Icons.phone,
                      type: TextInputType.phone,
                      context: context,
                      controller: phoneController,
                      onChanged: validatePhoneNumberInput,
                      isButtonDisabled: isButtonDisabled,
                      onConfirm: () {
                        userController
                            .updateUserphoneNumber(phoneController.text);
                        Get.back();
                      },
                    );
                  },
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
