import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parkxpert/Models/my_user.dart';
import 'package:parkxpert/utils/utils.dart';
import 'package:permission_handler/permission_handler.dart';

class UserController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Rx<MyUser?> currentUser = Rx<MyUser?>(null);

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  // Register User
  Future<bool> registerUser(String name, String email, String password,
      String phoneNumber, String role) async {
    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('users')
          .where('phoneNumber', isEqualTo: phoneNumber)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        Utils.snackBar("Signup Failed", "Phone number is already in use", true);
        return false;
      }

      UserCredential authUser = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      if (authUser.user != null) {
        MyUser user = MyUser(
          uid: authUser.user!.uid,
          name: name,
          email: authUser.user!.email,
          phoneNumber: phoneNumber,
          role: role,
          isOwner: false,
          isUserScreen: true,
          firstTime: true,
          accountcreated: Timestamp.now(),
          profilePic: null,
        );

        await firestore.collection("users").doc(user.uid).set(user.toJson());

        return true;
      }
      return false;
    } on FirebaseAuthException catch (e) {
      Utils.snackBar("Signup Failed", _getAuthErrorMessage(e.code), true);
      return false;
    } catch (e) {
      Utils.snackBar(
          "Error", "Something went wrong. Please try again later", true);
      return false;
    }
  }

  // Login User
  Future<bool> loginUser(String email, String password) async {
    try {
      UserCredential authUser = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (authUser.user != null) {
        String uid = authUser.user!.uid;
        DocumentSnapshot userDoc =
            await firestore.collection('users').doc(uid).get();

        if (userDoc.exists) {
          String userRole = userDoc['role'] ?? '';

          if (userRole == 'user') {
            await loadUserData();
            return true;
          } else {
            Utils.snackBar("Login Failed", "User not found!", true);
            return false;
          }
        } else {
          Utils.snackBar("Error", "User data not found.", true);
          return false;
        }
      }
      return false;
    } on FirebaseAuthException catch (e) {
      Utils.snackBar("Login Failed", _getAuthErrorMessage(e.code), true);
      return false;
    } catch (e) {
      Utils.snackBar(
          "Error", "Something went wrong. Please try again later", true);
      return false;
    }
  }

  // Load Logged-in User Data from Firestore
  Future<void> loadUserData() async {
    User? user = auth.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc =
          await firestore.collection("users").doc(user.uid).get();
      if (userDoc.exists) {
        currentUser.value =
            MyUser.fromJson(userDoc.data() as Map<String, dynamic>);
      }
    }
  }

  // Logout User
  Future<void> logoutUser() async {
    await auth.signOut();
    currentUser.value = null;
    Get.offAllNamed('/login');
  }

// update user name
  Future<void> updateUserName(String newName) async {
    String uid = auth.currentUser?.uid ?? "";
    if (uid.isEmpty) {
      Utils.snackBar("Error", "User not found!", true);
      return;
    }

    try {
      await firestore.collection("users").doc(uid).update({
        "name": newName,
      });

      currentUser.update((user) {
        user?.name = newName;
      });

      Utils.snackBar("Success", "Your name has been updated.", false);
    } catch (e) {
      Utils.snackBar("Error", "Failed to update name. Please try again.", true);
    }
  }

  // update Email

  Future<void> updateUserEmail(String newEmail) async {
    String uid = auth.currentUser?.uid ?? "";
    if (uid.isEmpty) {
      Utils.snackBar("Error", "User not found!", true);
      return;
    }

    if (!isValidEmail(newEmail)) {
      Utils.snackBar("Error", "Invalid email format!", true);
      return;
    }

    try {
      User? user = auth.currentUser;
      if (user == null) {
        Utils.snackBar("Error", "User not authenticated!", true);
        return;
      }

      QuerySnapshot querySnapshot = await firestore
          .collection("users")
          .where("email", isEqualTo: newEmail)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        Utils.snackBar("Error", "This email is already in use.", true);
        return;
      }

      await firestore.collection("users").doc(uid).update({
        "email": newEmail,
      });

      currentUser.update((u) {
        u?.email = newEmail;
      });

      Utils.snackBar("Success", "Your email has been updated.", false);
    } catch (e) {
      Utils.snackBar("Error", "Something went wrong. Try again!", true);
    }
  }

  bool isValidEmail(String email) {
    final RegExp emailRegex =
        RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    return emailRegex.hasMatch(email);
  }

  Future<void> updateUserphoneNumber(String newphoneNumber) async {
    String uid = auth.currentUser?.uid ?? "";
    if (uid.isEmpty) {
      Utils.snackBar("Error", "User not found!", true);
      return;
    }

    try {
      await firestore.collection("users").doc(uid).update({
        "phoneNumber": newphoneNumber,
      });

      currentUser.update((user) {
        user?.phoneNumber = newphoneNumber;
      });

      Utils.snackBar("Success", "Your contact has been updated.", false);
    } catch (e) {
      Utils.snackBar(
          "Error", "Failed to update contact. Please try again.", true);
    }
  }

  // Request for Permissions

  Future<bool> _requestPermissions() async {
    if (Platform.isAndroid) {
      PermissionStatus cameraStatus = await Permission.camera.status;
      PermissionStatus photosStatus = await Permission.photos.status;

      if (!cameraStatus.isGranted) {
        cameraStatus = await Permission.camera.request();
      }
      if (!photosStatus.isGranted) {
        photosStatus = await Permission.photos.request();
      }

      if (cameraStatus.isPermanentlyDenied ||
          photosStatus.isPermanentlyDenied) {
        openAppSettings();
        return false;
      }

      return cameraStatus.isGranted && photosStatus.isGranted;
    } else if (Platform.isIOS) {
      PermissionStatus photosStatus = await Permission.photos.status;

      if (!photosStatus.isGranted) {
        photosStatus = await Permission.photos.request();
      }

      if (photosStatus.isPermanentlyDenied) {
        openAppSettings();
        return false;
      }

      return photosStatus.isGranted;
    }
    return false;
  }

// show Image dialog Source
  void showImageSourceDialog(BuildContext context) async {
    bool hasPermission = await _requestPermissions();
    if (!hasPermission) {
      Utils.snackBar("Permission Denied",
          "You need to grant permissions for camera and gallery.", true);
      return;
    }

    showDialog(
      // ignore: use_build_context_synchronously
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFF121212),
          title: Text(
            'Choose a source',
            style: TextStyle(color: Color(0xFFFFFFFF)),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.camera, color: Color(0xFFFFFFFF)),
                title: Text(
                  'Take a Photo',
                  style: TextStyle(color: Color(0xFFFFFFFF)),
                ),
                onTap: () async {
                  Navigator.pop(context);
                  await updateProfilePic(ImageSource.camera);
                },
              ),
              ListTile(
                leading: Icon(Icons.image, color: Color(0xFFFFFFFF)),
                title: Text(
                  'Choose from Gallery',
                  style: TextStyle(color: Color(0xFFFFFFFF)),
                ),
                onTap: () async {
                  Navigator.pop(context);
                  await updateProfilePic(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

// updating profile pic
  Future<void> updateProfilePic(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    XFile? pickedFile = await picker.pickImage(source: source);

    if (pickedFile == null) {
      Utils.snackBar("Error", "No image selected.", true);
      return;
    }

    File imageFile = File(pickedFile.path);
    if (!imageFile.existsSync()) {
      Utils.snackBar("Error", "Image file does not exist.", true);
      return;
    }

    final compressedImage = await FlutterImageCompress.compressWithFile(
      imageFile.absolute.path,
      quality: 70,
    );

    if (compressedImage == null || compressedImage.length > 1024 * 1024) {
      Utils.snackBar("Error", "Image size should be less than 1MB", true);
      return;
    }

    try {
      String base64Image = base64Encode(compressedImage);
      String uid = FirebaseAuth.instance.currentUser?.uid ?? "";

      if (uid.isNotEmpty) {
        await FirebaseFirestore.instance.collection("users").doc(uid).update({
          "profilePic": base64Image,
        });

        currentUser.update((user) {
          user?.profilePic = base64Image;
        });

        Utils.snackBar("Success", "Profile picture updated.", false);
      } else {
        Utils.snackBar("Error", "User not authenticated.", true);
      }
    } catch (e) {
      Utils.snackBar("Error", "Something went wrong. Try again!", true);
    }
  }

  // Get error messages for FirebaseAuthException
  String _getAuthErrorMessage(String code) {
    switch (code) {
      case 'email-already-in-use':
        return "Email is already in use";
      case 'weak-password':
        return "Password is too weak. Please use a stronger password";
      case 'invalid-email':
        return "Invalid email. Please enter a valid email";
      case 'user-not-found':
        return "User not found. Please sign up first";
      case 'wrong-password':
        return "Incorrect password. Please try again";
      case 'invalid-credential':
        return "Invalid email or password. Please try again.";
      case 'too-many-requests':
        return "Too many failed attempts. Try again later";
      case 'network-request-failed':
        return "Network error. Please check your internet connection";
      default:
        return "An error occurred. Please try again";
    }
  }
}
