import 'dart:async';
import 'package:flutter/material.dart';
import 'package:todo_app/screen/Login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3), // Change the duration as needed
          () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(), // Make the container fullscreen
        child: Image.asset(
          'asset/image/img.png', // Adjust the path as needed
          fit: BoxFit.cover, // Ensure the image covers the entire container
        ),
      ),
    );
  }
}