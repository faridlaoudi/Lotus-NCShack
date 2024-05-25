import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lotus/home.dart';

import 'colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final Widget logo =
      SvgPicture.asset('assets/Logo.svg', semanticsLabel: 'Lotus Logo');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBackgroundColor,
      body: Animate(
        effects: [FadeEffect(duration: 500.ms), ScaleEffect()],
        onComplete: (controller) {
          // Navigate to HomePage after the animation completes
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              logo,
            ],
          ),
        ),
      ),
    );
  }
}
