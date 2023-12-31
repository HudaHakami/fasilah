import 'dart:async';
import 'package:fasilah_m1/features/registration/welcome/view.dart';
import 'package:flutter/material.dart';
import '../../shared/components/constants.dart';
import '../../shared/components/navigator.dart';
import '../../shared/styles/images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    Timer(const Duration(seconds: 5), () {
      navigateAndReplace(context,  const WelcomeScreen());
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: width(context, 1.5),
          height: height(context, 1.5),
          child: const Image(image: AssetImage(logo)),
        ),
      ),
    );
  }
}
