
import 'dart:async';
import 'package:e_commerce/ui/auth/login/Login%20Screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget{
  static const String routename = "splash";

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), () {
Navigator.of(context).pushReplacementNamed(LoginScreen.routename);
    });
    return Scaffold(
      body: Image.asset(
        'assets/images/Splash Screen.png',
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }

}