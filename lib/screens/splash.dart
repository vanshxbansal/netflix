import 'package:flutter/material.dart';
import 'dart:async';
import 'users_tile.dart';
class Splash extends StatefulWidget {
  const Splash({super.key});
  @override
  State<Splash> createState() => _SplashState();
}
class _SplashState extends State<Splash> {
  @override
  void initState() {
    Timer(Duration(seconds:5), (){
      Navigator.push(context, MaterialPageRoute(builder: (context) {return Users();}));
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Center(
          child: Image.asset("assets/netflix_logo.png"),
        ),
      ),
    );
  }
}

