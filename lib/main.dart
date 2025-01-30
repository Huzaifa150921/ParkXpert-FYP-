import 'package:flutter/material.dart';

import 'package:parkxpert/Views/Intro%20Screen/intro.dart';
import 'package:parkxpert/Views/user_screen/map_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Park Xpert',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Intro(),
      debugShowCheckedModeBanner: false,
    );
  }
}
