import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:miniecom/src/screens/loginscreen.dart';
import 'package:flutter/material.dart';
import 'blocs/loginprovider.dart';
import 'blocs/signupprovider.dart';

class App extends StatelessWidget {
  Widget build(context) {
    return SignupProvider(child: 
      LoginProvider(child: 
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        splash: Image.asset(
          "assets/images/agastya.png",
        ),
        nextScreen: LoginScreen(),
      ),
    )
    )
    );
  }
}
