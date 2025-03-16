import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAwesomeDialog {
  static void show({
    required BuildContext context,
    required TextEditingController controller,
    required Function(String) onChanged,
    required RxBool isButtonDisabled,
    required VoidCallback onConfirm,
    required TextInputType type,
    required IconData icon,
  }) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.noHeader,
      animType: AnimType.scale,
      dismissOnTouchOutside: true,
      dialogBackgroundColor: const Color.fromARGB(255, 27, 26, 26),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: TextField(
          keyboardType: type,
          controller: controller,
          style: const TextStyle(color: Colors.white),
          cursorColor: Colors.tealAccent,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[850],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            prefixIcon: Icon(icon, color: Colors.tealAccent),
          ),
          onChanged: onChanged,
        ),
      ),
      btnCancel: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.redAccent,
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        onPressed: () {
          Get.back();
        },
        child: const Text("Cancel", style: TextStyle(color: Colors.white)),
      ),
      btnOk: Obx(() => TextButton(
            style: TextButton.styleFrom(
              backgroundColor:
                  isButtonDisabled.value ? Colors.grey : Colors.teal,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            onPressed: isButtonDisabled.value ? null : onConfirm,
            child: const Text("OK", style: TextStyle(color: Colors.white)),
          )),
    ).show();
  }
}
