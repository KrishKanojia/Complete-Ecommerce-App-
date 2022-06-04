import 'dart:async';

import 'package:ecommerce_app/screens/homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Homepage(),
        ),
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0000fe),
      body: Center(
        child: Container(
          alignment: Alignment.center, // This is needed
          child: Image.asset(
            "assets/logo-whitebackground.png",
            fit: BoxFit.contain,
            width: 300,
          ),
        ),
      ),
    );
  }
}
