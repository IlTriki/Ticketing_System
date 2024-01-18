import 'package:flutter/material.dart';
import 'package:partie_mobile/pages/connexion.dart';
import 'package:partie_mobile/models/certificate_validator.dart';
import 'dart:io';

void main() {
  HttpOverrides.global = DevHttpOverrides();
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Techniplan",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: "Poppins"),
      home: const LoginPage(),
      navigatorKey: navigatorKey,
    );
  }
}
