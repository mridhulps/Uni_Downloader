// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // splashmethode(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
          child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Center(child: Text('splash screen')),
      )),
    );
  }
}

// splashmethode(BuildContext context) async {
//   // await Future.delayed(const Duration(seconds: 1));
//   await transportvalue(context);
// //   Navigator.of(context)
// //       .push(MaterialPageRoute(builder: (ctx) => const HomeScreen()));
//  }
 
 