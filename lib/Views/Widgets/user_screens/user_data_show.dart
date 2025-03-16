import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:google_fonts/google_fonts.dart';

class UserDataShow extends StatelessWidget {
  const UserDataShow(
      {super.key,
      required this.text,
      this.subtext,
      this.onPressed,
      this.icon,
      required this.color});

  final String text;
  final String? subtext;
  final void Function()? onPressed;
  final IconData? icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return GFButton(
      onPressed: onPressed,
      fullWidthButton: true,
      shape: GFButtonShape.square,
      size: 70,
      color: Colors.black,
      hoverColor: Colors.blue[700],
      splashColor: Colors.blue[800],
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: GoogleFonts.nobile(
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1,
                      color: color),
                ),
                if (subtext != null) ...[
                  SizedBox(height: screenHeight * 0.008),
                  Text(
                    subtext!,
                    style: GoogleFonts.nobile(
                        fontSize: screenWidth * 0.04,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1,
                        color: Colors.grey),
                  ),
                ],
              ],
            ),
            if (icon != null) ...[
              Icon(
                icon,
                size: screenWidth * 0.07,
                color: Colors.grey,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
