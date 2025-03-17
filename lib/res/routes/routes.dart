import 'package:get/get.dart';
import 'package:parkxpert/Views/Auth/login_screen.dart';
import 'package:parkxpert/Views/Auth/owner_registration.dart';
import 'package:parkxpert/Views/Auth/signup_screen.dart';
import 'package:parkxpert/Views/Intro%20Screen/intro.dart';
import 'package:parkxpert/Views/Owner%20Screen/owner_desition.dart';
import 'package:parkxpert/Views/Widgets/user_screens/displayparking/displayparking.dart';
import 'package:parkxpert/Views/Widgets/user_screens/drawe_screens/help_screen.dart';
import 'package:parkxpert/Views/Widgets/user_screens/drawe_screens/notificatios_screen.dart';
import 'package:parkxpert/Views/Widgets/user_screens/drawe_screens/rateus_screen.dart';
import 'package:parkxpert/Views/Widgets/user_screens/drawe_screens/support_screen.dart';
import 'package:parkxpert/Views/Widgets/user_screens/drawe_screens/profile_screen.dart';
import 'package:parkxpert/Views/Widgets/user_screens/drawe_screens/settings_screen.dart';
import 'package:parkxpert/Views/Widgets/user_screens/drawe_screens/user_bookings_screen.dart';
import 'package:parkxpert/Views/splash_screen.dart';
import 'package:parkxpert/Views/user_screen/main_screen.dart';
import 'package:parkxpert/res/routes/route_name.dart';

class Approutes {
  static appRoutes() => [
        // Splash Screen Route
        GetPage(
          name: RouteName.splashScreen,
          page: () => SplashScreen(),
        ),

        // Intro Screen Route
        GetPage(
          name: RouteName.intro,
          page: () => Intro(),
          transition: Transition.downToUp,
          transitionDuration: Duration(seconds: 1),
        ),

        // User Auth Route
        GetPage(
          name: RouteName.login,
          page: () => LoginScreen(),
          transition: Transition.fadeIn,
          transitionDuration: Duration(seconds: 1),
        ),
        GetPage(
          name: RouteName.signup,
          page: () => SignupScreen(),
          transition: Transition.fadeIn,
          transitionDuration: Duration(seconds: 1),
        ),

        // User Screens Route
        GetPage(
          name: RouteName.userScreen,
          page: () => MainScreen(),
          transition: Transition.rightToLeft,
          transitionDuration: Duration(seconds: 1),
        ),
        GetPage(
          name: RouteName.displayParking,
          page: () => DisplayParking(),
          transition: Transition.downToUp,
          transitionDuration: Duration(milliseconds: 600),
        ),
        GetPage(
          name: RouteName.profileScreen,
          page: () => ProfileScreen(),
          transition: Transition.downToUp,
          transitionDuration: Duration(milliseconds: 600),
        ),
        GetPage(
          name: RouteName.bookingScreen,
          page: () => UserBookingsScreen(),
          transition: Transition.downToUp,
          transitionDuration: Duration(milliseconds: 600),
        ),
        GetPage(
          name: RouteName.notificationScreen,
          page: () => NotificatiosScreen(),
          transition: Transition.downToUp,
          transitionDuration: Duration(milliseconds: 600),
        ),
        GetPage(
          name: RouteName.settingScreen,
          page: () => SettingsScreen(),
          transition: Transition.downToUp,
          transitionDuration: Duration(milliseconds: 600),
        ),
        GetPage(
          name: RouteName.helpScreen,
          page: () => HelpScreen(),
          transition: Transition.downToUp,
          transitionDuration: Duration(milliseconds: 600),
        ),
        GetPage(
          name: RouteName.supportScreen,
          page: () => SupportScreen(),
          transition: Transition.downToUp,
          transitionDuration: Duration(milliseconds: 600),
        ),
        GetPage(
          name: RouteName.rateusScreen,
          page: () => RateusScreen(),
          transition: Transition.downToUp,
          transitionDuration: Duration(milliseconds: 600),
        ),

        // Owner Screen Route
        GetPage(
          name: RouteName.ownerDesitionScreen,
          page: () => OwnerDesition(),
          transition: Transition.leftToRight,
          transitionDuration: Duration(seconds: 1),
        ),
        GetPage(
          name: RouteName.ownerRegistration,
          page: () => OwnerRegistration(),
          transition: Transition.fadeIn,
          transitionDuration: Duration(seconds: 1),
        ),
      ];
}
