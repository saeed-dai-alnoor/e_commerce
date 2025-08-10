import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
 const  SplashView({super.key});
  @override
  Widget build(BuildContext context) {
    final mySystemTheme = SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.white,
      systemNavigationBarColor: Colors.white,
    );
    SystemChrome.setSystemUIOverlayStyle(mySystemTheme);
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset("assets/images/splash_bg.png", fit: BoxFit.cover),
          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(58.0),
                child: const CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
