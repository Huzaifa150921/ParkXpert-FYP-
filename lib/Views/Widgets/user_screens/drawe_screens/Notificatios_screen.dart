import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificatiosScreen extends StatelessWidget {
  const NotificatiosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: Padding(
          padding: EdgeInsets.only(left: screenwidth * 0.13),
          child: Text(
            "Notifications",
            style: GoogleFonts.poppins(
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
    );
  }
}
