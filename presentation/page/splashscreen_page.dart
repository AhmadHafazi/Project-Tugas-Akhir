// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import '../../helpers/db_helper.dart';
import 'home_page.dart';
import 'register_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkUserStatus();
  }

  Future<void> _checkUserStatus() async {
    final db = DatabaseHelper.instance;
    final users = await db.getAllUsers();
    if (users.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(user: users.first),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => RegisterPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Future.delayed(Duration(seconds: 1), () async {
    //   final db = DatabaseHelper.instance;
    //   final users = await db.getAllUsers();
    //   if (users.isNotEmpty) {
    //     Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(builder: (context) => HomePage(user: users.first)),
    //     );
    //   } else {
    //     Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(builder: (context) => RegisterPage()),
    //     );
    //   }
    // });
    return Scaffold(
      body: Center(child: Image.asset('assets/logosplash.png')),
    );
  }
}
