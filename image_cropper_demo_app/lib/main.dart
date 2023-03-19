import 'package:flutter/material.dart';
import 'package:image_cropper_demo_app/screens/loginPage.dart';
//import 'package:info_app/screens/signupPage.dart';
//import 'package:info_app/screens/dashboardPage.dart';
//import 'package:info_app/screens/profilePage.dart';

//import 'package:info_app/screens/signupPage.dart';
//import 'dart:async';
//import 'package:path/path.dart';

//import 'screens/dashboardPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
