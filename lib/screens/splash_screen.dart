import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_tetris_1/screens/home_screen.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();

    Timer(
  const Duration(seconds: 3),
  () {
    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const HomePage(),
      ),
    );
  },
);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDEDED),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo.png', width: 250, fit: BoxFit.contain),

            const SizedBox(height: 30),

            const SizedBox(width: 200, child: LinearProgressIndicator()),
          ],
        ),
      ),
    );
  }
}
