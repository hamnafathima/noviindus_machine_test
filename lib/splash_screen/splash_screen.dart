import 'package:flutter/material.dart';
import 'package:flutter_machine_test/login_screen/login_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_machine_test/constants/images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToLogin();
  }

  _navigateToLogin() async {
    await Future.delayed(const Duration(seconds: 3), () {});
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            ImageClass.bg_Image,
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Center(
            child: SvgPicture.asset(
              ImageClass.logo_Two,
              height: 100,
              width: 100,
            ),
          ),
        ],
      ),
    );
  }
}
