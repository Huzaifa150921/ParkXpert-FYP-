import 'package:double_tap_exit/double_tap_exit.dart';
import 'package:flutter/material.dart';

class DoubleTapExitFeature extends StatelessWidget {
  const DoubleTapExitFeature({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return DoubleTap(
      message: "Double tap to exit app!",
      waitForSecondBackPress: 2,
      background: Colors.black,
      backgroundRadius: 20,
      textStyle: const TextStyle(
          fontSize: 15,
          color: Colors.white,
          letterSpacing: 1,
          fontWeight: FontWeight.w500),
      child: child,
    );
  }
}
