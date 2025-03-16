import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parkxpert/Models/my_user.dart';
import 'package:parkxpert/utils/utils.dart';
import 'package:permission_handler/permission_handler.dart';

class UserController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;

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
        await loadUserData();
        return true;
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

  // Function to Pick Image and Upload
  Future<void> updateProfilePic() async {
    bool hasPermission = await _requestPermissions();
    if (!hasPermission) {
      return;
    }

    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) {
      return;
    }

    File imageFile = File(pickedFile.path);

    if (!imageFile.existsSync()) {
      return;
    }

    String uid = auth.currentUser?.uid ?? "";
    if (uid.isEmpty) {
      return;
    }

    String filePath = "profile_pics/$uid.jpg";

    try {
      // Upload image to Firebase Storage
      TaskSnapshot uploadTask =
          await storage.ref().child(filePath).putFile(imageFile);

      if (uploadTask.state == TaskState.success) {
        String downloadURL = await uploadTask.ref.getDownloadURL();

        // Save URL to Firestore
        await firestore.collection("users").doc(uid).update({
          "profilePic": downloadURL,
        });

        // Update local user object
        currentUser.update((user) {
          user?.profilePic = downloadURL;
        });
      } else {
        // ignore: avoid_print
        print("Upload Failed: File upload was unsuccessful.");
      }
    } catch (e) {
      // ignore: avoid_print
      print("Upload Error: $e");
    }
  }

  Future<bool> _requestPermissions() async {
    if (Platform.isAndroid) {
      PermissionStatus cameraStatus = await Permission.camera.request();

      PermissionStatus storageStatus;
      if (await Permission.photos.isGranted ||
          await Permission.photos.request().isGranted) {
        storageStatus = PermissionStatus.granted;
      } else {
        storageStatus = await Permission.storage.request();
      }

      if (cameraStatus.isPermanentlyDenied ||
          storageStatus.isPermanentlyDenied) {
        Utils.snackBar("Permission Required",
            "Please enable Camera & Storage permissions in settings.", true);
        openAppSettings(); // Redirect user to settings
        return false;
      }

      return cameraStatus.isGranted && storageStatus.isGranted;
    } else if (Platform.isIOS) {
      PermissionStatus photosStatus = await Permission.photos.request();

      if (photosStatus.isPermanentlyDenied) {
        Utils.snackBar("Permission Required",
            "Please enable Photos permission in settings.", true);
        openAppSettings(); // Redirect user to settings
        return false;
      }

      return photosStatus.isGranted;
    }

    return false;
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
