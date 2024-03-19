import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:resume_builder_new/contact_page.dart';
import 'package:resume_builder_new/home_page.dart';
import 'package:resume_builder_new/personal_details.dart';
import 'package:resume_builder_new/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: SplashScreen(),
      initialRoute: "/",
      routes: {
        "/": (context) => SplashScreen(),
        "home": (context) => HomePage(),
        "contactInfo": (context) => ContactPage(),
        "personalDetails": (context) => PersonalDetails()
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Text(
                "onUnknownRoute",
                style: TextStyle(fontSize: 50, color: Colors.black),
              ),
            ),
          ),
        );
      },
    );
  }
}
