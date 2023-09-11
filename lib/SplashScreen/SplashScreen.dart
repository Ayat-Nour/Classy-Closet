import 'package:final_project/AppScreens/Onboarding/onBoardingPage.dart';
import 'package:flutter/material.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
        logo: Image.asset("lib/assets/png/LogoClassyCloset.png"),
      backgroundColor: Colors.white,
      durationInSeconds: 5,
      logoWidth: 300,
      navigator: OnBoardingPage(),
    );
  }
}
