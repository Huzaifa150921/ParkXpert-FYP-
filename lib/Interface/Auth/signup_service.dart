import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupService extends GetxController {
  final nameController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final phoneNumberController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final confirmPasswordController = TextEditingController().obs;
}
