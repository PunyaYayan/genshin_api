import 'package:flutter/material.dart';
import 'dart:async';
import 'CharList.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => CharList()));
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Container(
            padding: EdgeInsets.fromLTRB(60,0,60,0),
            child: Image.asset("assets/LogoGenshin/Black.png", fit: BoxFit.fill,),
          ),
        ),
      ),
    );
  }
}