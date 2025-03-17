import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import this for SystemUiOverlayStyle
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:parkxpert/Views/Loaders/owner_registration_loader.dart';
import 'package:parkxpert/Views/Widgets/Owner%20Screen/drawer/unregister_owner_drawer.dart';
import 'package:parkxpert/Views/Widgets/extra%20features/double_tap_exit_feature.dart';
import 'package:parkxpert/res/routes/route_name.dart';

class OwnerDesition extends StatelessWidget {
  OwnerDesition({super.key});
  final Color navigationBarColor = Colors.black;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;
    return DoubleTapExitFeature(
      bgColor: Colors.white,
      textColor: Colors.black,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          systemNavigationBarColor: navigationBarColor,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 73, 73, 73),
          key: _scaffoldKey,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(screenheight * 0.0001),
            child: AppBar(
              centerTitle: true,
              backgroundColor: const Color.fromARGB(255, 0, 0, 0),
              elevation: 0,
              automaticallyImplyLeading: false,
            ),
          ),
          extendBodyBehindAppBar: true,
          drawer: UnregisterOwnerDrawer(),
          body: Stack(
            children: [
              Positioned(
                top: screenheight * 0.07,
                left: screenwidth * 0.05,
                child: GestureDetector(
                  onTap: () => _scaffoldKey.currentState?.openDrawer(),
                  child: const Icon(Icons.menu, color: Colors.white, size: 28),
                ),
              ),
              Positioned(
                top: screenheight * 0.15,
                child: Container(
                  width: screenwidth,
                  padding: EdgeInsets.symmetric(horizontal: screenwidth * 0.05),
                  child: Card(
                    color: Colors.blue[700],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 6,
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Get income with us",
                            style: GoogleFonts.nunito(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: screenheight * 0.02),
                          Row(
                            children: [
                              Icon(Icons.add_location_alt,
                                  color: Colors.white70, size: 24),
                              SizedBox(width: screenwidth * 0.03),
                              Expanded(
                                child: Text(
                                  "List Your Parking Space Easily",
                                  style: GoogleFonts.nunito(
                                      fontSize: 16, color: Colors.white70),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: screenheight * 0.01),
                          Row(
                            children: [
                              Icon(Icons.attach_money,
                                  color: Colors.white70, size: 24),
                              SizedBox(width: screenwidth * 0.03),
                              Expanded(
                                child: Text(
                                  "Set Your Own Prices",
                                  style: GoogleFonts.nunito(
                                      fontSize: 16, color: Colors.white70),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: screenheight * 0.01),
                          Row(
                            children: [
                              Icon(Icons.payment,
                                  color: Colors.white70, size: 24),
                              SizedBox(width: screenwidth * 0.03),
                              Expanded(
                                child: Text(
                                  "Get Secure Payments",
                                  style: GoogleFonts.nunito(
                                      fontSize: 16, color: Colors.white70),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: screenheight * 0.01),
                          Row(
                            children: [
                              Icon(Icons.people,
                                  color: Colors.white70, size: 24),
                              SizedBox(width: screenwidth * 0.03),
                              Expanded(
                                child: Text(
                                  "More Customers, More Income",
                                  style: GoogleFonts.nobile(
                                      fontSize: 16, color: Colors.white70),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: screenheight * 0.03),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                Get.to(() => OwnerRegistrationLoader(),
                                    transition: Transition.fade);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orangeAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 14, horizontal: 24),
                              ),
                              child: Text(
                                "Start Earning Now!",
                                style: GoogleFonts.nobile(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: screenheight * 0.86,
                left: 0,
                right: 0,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenwidth * 0.05),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(color: Colors.black),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: screenheight * 0.015),
                      ),
                      child: Text(
                        "I already have an account",
                        style: GoogleFonts.nobile(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: screenheight * 0.93,
                left: 0,
                right: 0,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenwidth * 0.05),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: TextButton(
                      onPressed: () {
                        Get.toNamed(RouteName.userScreen);
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            vertical: screenheight * 0.015),
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        "Go to user mode",
                        style: GoogleFonts.nobile(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            letterSpacing: 1 // Ensuring black text color
                            ),
                      ),
                    ),
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
