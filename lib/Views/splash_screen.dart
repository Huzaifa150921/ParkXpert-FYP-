import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parkxpert/Controller/UserController/user_controller.dart';
import 'package:parkxpert/res/routes/route_name.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final UserController userController = Get.find<UserController>();

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        if (userController.currentUser.value != null) {
          Get.offNamed(RouteName.userScreen);
        } else {
          Get.offNamed(RouteName.intro);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 73, 73, 73),
      body: Center(
        child: Image.asset(
          'assets/images/splash.png',
          width: MediaQuery.of(context).size.width * 0.6,
          height: MediaQuery.of(context).size.height * 0.6,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
