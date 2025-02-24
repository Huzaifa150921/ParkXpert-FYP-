import 'dart:async';

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

import 'package:parkxpert/Views/Widgets/user_screens/drawer/user_drawer_button.dart';
import 'package:parkxpert/Views/user_screen/main_screen.dart';

class OwnerDrawer extends StatelessWidget {
  const OwnerDrawer({super.key});

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
            color: Colors.black.withOpacity(0.4),
            blurRadius: 8,
            spreadRadius: 2,
            offset: const Offset(3, 3),
          ),
        ],
      ),
      child: GFDrawer(
        color: Colors.black,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: screenheight * 0.10,
                left: screenwidth * 0.10,
              ),
              child: Row(
                children: [
                  GFAvatar(
                    size: 40,
                    backgroundImage:
                        AssetImage("assests/images/default_profile_pic.jfif"),
                    backgroundColor: Colors.grey[800],
                  ),
                  SizedBox(
                    width: screenwidth * 0.04,
                  ),
                  Text(
                    "username",
                    style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        letterSpacing: 1),
                  ),
                ],
              ),
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
                      Timer(Duration(milliseconds: 500), () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.bottomToTop,
                            duration: Duration(milliseconds: 900),
                            curve: Curves.easeInOut,
                            // child: ProfileScreem(),
                          ),
                        );
                      });
                    },
                  ),
                  SizedBox(
                    height: screenheight * 0.02,
                  ),
                  UserDrawerButton(
                    text: "Bookings",
                    icon: Icons.history_outlined,
                    func: () {
                      Timer(Duration(milliseconds: 500), () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.bottomToTop,
                            duration: Duration(milliseconds: 900),
                            curve: Curves.easeInOut,
                            // child: UserBookingsScreen(),
                          ),
                        );
                      });
                    },
                  ),
                  SizedBox(
                    height: screenheight * 0.02,
                  ),
                  UserDrawerButton(
                    text: "Notifications",
                    icon: Icons.notifications_outlined,
                    func: () {
                      Timer(Duration(milliseconds: 500), () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.bottomToTop,
                            duration: Duration(milliseconds: 900),
                            curve: Curves.easeInOut,
                            // child: NotificatiosScreen(),
                          ),
                        );
                      });
                    },
                  ),
                  SizedBox(
                    height: screenheight * 0.02,
                  ),
                  UserDrawerButton(
                    text: "Settings",
                    icon: Icons.settings_outlined,
                    func: () {
                      Timer(Duration(milliseconds: 500), () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.bottomToTop,
                            duration: Duration(milliseconds: 900),
                            curve: Curves.easeInOut,
                            // child: SettingsScreen(),
                          ),
                        );
                      });
                    },
                  ),
                  SizedBox(
                    height: screenheight * 0.02,
                  ),
                  UserDrawerButton(
                    text: "Help",
                    icon: Icons.help_outline,
                    func: () {
                      Timer(Duration(milliseconds: 500), () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.bottomToTop,
                            duration: Duration(milliseconds: 900),
                            curve: Curves.easeInOut,
                            // child: HelpScreen(),
                          ),
                        );
                      });
                    },
                  ),
                  SizedBox(
                    height: screenheight * 0.02,
                  ),
                  UserDrawerButton(
                      text: "Support",
                      icon: Icons.support_outlined,
                      func: () {
                        Timer(Duration(milliseconds: 500), () {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.bottomToTop,
                              duration: Duration(milliseconds: 900),
                              curve: Curves.easeInOut,
                              // child: SupportScreen(),
                            ),
                          );
                        });
                      }),
                  SizedBox(
                    height: screenheight * 0.02,
                  ),
                  UserDrawerButton(
                    text: "Rate Us",
                    icon: Icons.rate_review_outlined,
                    func: () {
                      Timer(Duration(milliseconds: 500), () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.bottomToTop,
                            duration: Duration(milliseconds: 900),
                            curve: Curves.easeInOut,
                            // child: RateusScreen(),
                          ),
                        );
                      });
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
              child: Container(
                width: screenwidth * 0.7,
                child: GFButton(
                  size: 50,
                  onPressed: () {
                    Timer(Duration(milliseconds: 800), () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rotate,
                          alignment: Alignment.center,
                          duration: Duration(milliseconds: 900),
                          curve: Curves.easeInOutBack,
                          child: MainScreen(),
                        ),
                      );
                    });
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
