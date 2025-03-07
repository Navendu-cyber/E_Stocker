import 'dart:developer';

import 'package:e_stocker/routes/routes.dart';
import 'package:e_stocker/database/db_models/data_user.dart';
import 'package:e_stocker/database/db_functions/user_funtions.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    log('splashscreen');
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(Duration(seconds: 2));
    final box = await Hive.openBox<User>(USER_BOX);

    if (!mounted) return;

    if (box.isEmpty) {
      Navigator.of(context).pushReplacementNamed(Routes.createAccount);
    } else {
      Navigator.of(context).pushReplacementNamed(Routes.bootUpScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'E-Stocker',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
