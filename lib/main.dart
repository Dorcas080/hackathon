import 'package:e_commerce_app/firebase_options.dart';
import 'package:e_commerce_app/screens/navigation_screen.dart';
import 'package:e_commerce_app/screens/onboarding_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          } else if (asyncSnapshot.hasData) {
            return NavigationScreen();
          } else {
            return OnboardingScreen();
          }
        },
      ),
    );
  }
}
