import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parkxpert/Views/Widgets/ResposeCodeWidgets/no_data_found.dart';

class UserBookingsScreen extends StatelessWidget {
  const UserBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // double screenheight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: Padding(
          padding: EdgeInsets.only(left: screenwidth * 0.14),
          child: Text(
            "My Bookings",
            style: GoogleFonts.nobile(
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
      body: Nodatafound(),
    );
  }
}
