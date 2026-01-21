import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:message_practice/login_screen/screen/login_screen.dart';




class MyApp extends StatelessWidget {
  const MyApp({super.key});

 
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}