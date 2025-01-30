import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:parkxpert/Views/Auth/Login.dart';

class GFIntroScreenWidget extends StatefulWidget {
  const GFIntroScreenWidget({super.key});

  @override
  GFIntroScreenWidgetState createState() => GFIntroScreenWidgetState();
}

class GFIntroScreenWidgetState extends State<GFIntroScreenWidget> {
  int initialPage = 0;
  bool showskip = true;
  bool showback = true;
  List<Widget> slideList = [];
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: initialPage);
    slideList = _buildSlides();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (index) {
              setState(() {
                initialPage = index;
                if (initialPage == slideList.length - 1) {
                  showback = false;
                }
              });
            },
            children: slideList,
          ),
          if (initialPage > 0 && showback == true)
            Positioned(
              left: screenWidth * 0.06,
              bottom: screenHeight * 0.09,
              child: ElevatedButton(
                onPressed: () {
                  if (initialPage > 0) {
                    _pageController.previousPage(
                      duration: const Duration(milliseconds: 900),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade800,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Back',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2),
                ),
              ),
            ),
          if (initialPage < slideList.length - 1)
            Positioned(
              right: screenWidth * 0.06,
              bottom: screenHeight * 0.09,
              child: ElevatedButton(
                onPressed: () {
                  showskip = false;
                  if (initialPage < slideList.length - 1) {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 900),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Next',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2),
                ),
              ),
            ),
          if (initialPage < slideList.length - 1 && showskip == true)
            Positioned(
              top: screenHeight * 0.10,
              right: screenWidth * 0.75,
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    PageTransition(
                      type: PageTransitionType.leftToRight,
                      child: Login(),
                      duration: const Duration(milliseconds: 1000),
                    ),
                  );
                },
                child: const Text(
                  'Skip >',
                  style: TextStyle(
                      color: Colors.redAccent,
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          if (initialPage == slideList.length - 1)
            Positioned(
              left: screenWidth * 0.33,
              bottom: screenHeight * 0.09,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: Login(),
                      duration: const Duration(milliseconds: 1000),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Get Started',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2)),
              ),
            ),
        ],
      ),
    );
  }

  List<Widget> _buildSlides() {
    return [
      slideContent(
        icon: Icons.local_parking,
        color: Colors.cyanAccent,
        title: 'Find Parking Easily',
        description:
            'With ParkXpert, you can easily find parking spaces in your vicinity, making parking easier and stress-free.',
        gradient: [Colors.greenAccent, Colors.pinkAccent],
      ),
      slideContent(
        icon: Icons.calendar_today,
        color: Colors.amberAccent,
        title: 'Reserve Your Spot',
        description:
            'Reserve your parking spot ahead of time and ensure you always have a place to park.',
        gradient: [Colors.red, Colors.yellow],
      ),
      slideContent(
        icon: Icons.check_circle,
        color: Colors.greenAccent,
        title: 'Seamless Experience',
        description:
            'Enjoy a smooth and efficient parking experience. Find, reserve, and park without hassle.',
        gradient: [Colors.blue, Colors.green],
      ),
      slideContent(
        icon: Icons.star,
        color: Colors.orangeAccent,
        title: 'Welcome to ParkXpert',
        description:
            'We are excited to have you here. ParkXpert is your ultimate parking solution, bringing convenience and simplicity to your daily life.',
        gradient: [Colors.purple, Colors.blue],
      ),
    ];
  }

  Widget slideContent({
    required String title,
    required String description,
    required List<Color> gradient,
    required IconData icon,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: color,
            size: 100,
          ),
          const SizedBox(height: 20),
          ShaderMask(
            shaderCallback: (rect) {
              return LinearGradient(
                colors: gradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(rect);
            },
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey.shade400,
            ),
          ),
        ],
      ),
    );
  }
}
