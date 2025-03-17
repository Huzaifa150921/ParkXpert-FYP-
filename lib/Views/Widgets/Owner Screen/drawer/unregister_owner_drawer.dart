import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parkxpert/Controller/UserController/user_controller.dart';
import 'package:parkxpert/Views/Widgets/user_screens/drawer/user_drawer_button.dart';
import 'package:parkxpert/res/routes/route_name.dart';

class UnregisterOwnerDrawer extends StatelessWidget {
  UnregisterOwnerDrawer({super.key});
  final UserController userController = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Container(
      width: screenwidth * 0.8,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.black87, Colors.blueGrey.shade900],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.4),
            blurRadius: 8,
            spreadRadius: 2,
            offset: const Offset(3, 3),
          ),
        ],
      ),
      child: GFDrawer(
        color: const Color.fromARGB(255, 24, 24, 24),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: screenheight * 0.10,
                left: screenwidth * 0.10,
              ),
              child: Obx(() {
                final user = userController.currentUser.value;
                if (user == null) {
                  return CircularProgressIndicator();
                }
                return Row(
                  children: [
                    GFAvatar(
                      size: 40,
                      backgroundImage: (user.profilePic != null)
                          ? MemoryImage(base64Decode(user.profilePic!))
                          : AssetImage(
                              "assets/images/default_profile_pic.jfif"),
                      backgroundColor: Colors.grey[800],
                    ),
                    SizedBox(width: screenwidth * 0.08),
                    Text(
                      user.name ?? "Guest",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                );
              }),
            ),
            SizedBox(
              height: screenheight * 0.03,
            ),
            Divider(
              color: const Color.fromARGB(162, 158, 158, 158),
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                children: [
                  UserDrawerButton(
                    text: "Profile",
                    icon: Icons.person_outline,
                    func: () {
                      Get.toNamed(RouteName.profileScreen);
                    },
                  ),
                  SizedBox(
                    height: screenheight * 0.02,
                  ),
                  UserDrawerButton(
                    text: "Bookings",
                    icon: Icons.history_outlined,
                    func: () {
                      Get.toNamed(RouteName.bookingScreen);
                    },
                  ),
                  SizedBox(
                    height: screenheight * 0.02,
                  ),
                  UserDrawerButton(
                    text: "Notifications",
                    icon: Icons.notifications_outlined,
                    func: () {
                      Get.toNamed(RouteName.notificationScreen);
                    },
                  ),
                  SizedBox(
                    height: screenheight * 0.02,
                  ),
                  UserDrawerButton(
                    text: "Settings",
                    icon: Icons.settings_outlined,
                    func: () {
                      Get.toNamed(RouteName.settingScreen);
                    },
                  ),
                  SizedBox(
                    height: screenheight * 0.02,
                  ),
                  UserDrawerButton(
                    text: "Online Registration",
                    icon: Icons.app_registration_outlined,
                    func: () {
                      // Get.toNamed(RouteName.settingScreen);
                    },
                  ),
                  SizedBox(
                    height: screenheight * 0.02,
                  ),
                  UserDrawerButton(
                    text: "Help",
                    icon: Icons.help_outline,
                    func: () {
                      Get.toNamed(RouteName.helpScreen);
                    },
                  ),
                  SizedBox(
                    height: screenheight * 0.02,
                  ),
                  UserDrawerButton(
                      text: "Support",
                      icon: Icons.support_outlined,
                      func: () {
                        Get.toNamed(RouteName.supportScreen);
                      }),
                  SizedBox(
                    height: screenheight * 0.02,
                  ),
                  UserDrawerButton(
                    text: "Rate Us",
                    icon: Icons.rate_review_outlined,
                    func: () {
                      Get.toNamed(RouteName.rateusScreen);
                    },
                  ),
                ],
              ),
            ),
            Divider(
              color: const Color.fromARGB(162, 158, 158, 158),
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: screenheight * 0.1, top: screenheight * 0.02),
              child: SizedBox(
                width: screenwidth * 0.7,
                child: GFButton(
                  size: 50,
                  onPressed: () {
                    Get.toNamed(RouteName.userScreen);
                  },
                  text: "User mode",
                  color: Colors.blue,
                  textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      letterSpacing: 1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
