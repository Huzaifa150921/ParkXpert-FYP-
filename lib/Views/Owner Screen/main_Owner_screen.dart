import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import this for SystemUiOverlayStyle
import 'package:parkxpert/Views/Widgets/Owner%20Screen/drawer/owner_drawer.dart';
import 'package:parkxpert/Views/Widgets/extra%20features/double_tap_exit_feature.dart';
import 'package:parkxpert/Views/Widgets/user_screens/drawer/user_drawer.dart';

class MainOwnerScreen extends StatelessWidget {
  MainOwnerScreen({super.key});
  final Color navigationBarColor = Colors.black;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;
    return DoubleTapExitFeature(
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          systemNavigationBarColor: navigationBarColor,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          key: _scaffoldKey,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(screenheight * 0.01),
            child: AppBar(
              centerTitle: true,
              backgroundColor: const Color.fromARGB(255, 0, 0, 0),
              elevation: 0,
              automaticallyImplyLeading: false,
            ),
          ),
          extendBodyBehindAppBar: true,
          drawer: OwnerDrawer(),
          body: Stack(
            children: [
              Positioned(
                top: screenheight * 0.07,
                left: screenwidth * 0.05,
                child: GestureDetector(
                  onTap: () => _scaffoldKey.currentState?.openDrawer(),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.shade900,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 6,
                          spreadRadius: 2,
                          offset: const Offset(2, 2),
                        ),
                      ],
                    ),
                    child:
                        const Icon(Icons.menu, color: Colors.white, size: 28),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
