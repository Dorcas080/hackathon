import 'package:e_commerce_app/screens/navigation_screen.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ECommerce Sopping",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Color(0xFFDB3022)),
      home: NavigationScreen(),
    );
  }
}
