import 'package:flutter/material.dart';

import 'presentation/page/splashscreen_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gransangan App',
      //pada saat aplikasi dibuka langsung diarahkan ke splashscree
      home: SplashScreen(),
    );
  }
}
