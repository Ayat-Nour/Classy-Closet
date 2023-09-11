import 'package:easy_localization/easy_localization.dart';
import 'package:final_project/AppScreens/LoginScreens/Login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:OnBoardingSlider(
        finishButtonText: 'shopNow'.tr(),
        onFinish: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
        },
        finishButtonStyle: const FinishButtonStyle(
          backgroundColor: Colors.pink,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
        ),
        skipTextButton:  Text(
          'skip'.tr(),
          style:const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        controllerColor: Colors.pink,
        totalPage: 3,
        headerBackgroundColor: Colors.white,
        pageBackgroundColor: Colors.white,
        centerBackground: true,
        background: [
          Image.asset(
            'lib/assets/png/onboarding1.png',
            height: 400,
          ),
          Image.asset(
            'lib/assets/png/onboarding2.png',
            height: 400,
          ),
          Image.asset(
            'lib/assets/png/onboarding3.png',
            height: 400,
          ),
        ],
        speed: 1.8,
        pageBodies: [
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:  <Widget>[
                SizedBox(
                  height: 480,
                ),
                Text(
                  'onBoarding1title'.tr(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'onBoarding1desc'.tr(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:  <Widget>[
                SizedBox(
                  height: 480,
                ),
                Text(
                  'onBoarding2title'.tr(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'onBoarding2desc'.tr(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:  <Widget>[
                SizedBox(
                  height: 480,
                ),
                Text(
                  'onBoarding3title'.tr(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'onBoarding3desc'.tr(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}
