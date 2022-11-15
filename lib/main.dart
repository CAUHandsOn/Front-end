import 'package:flutter/material.dart';
import 'package:handson/src/provider/bottom_navigation_provider.dart';
import 'package:handson/src/ui/home.dart';
import 'package:handson/src/ui/splash_widget.dart';
import 'package:handson/src/ui/student_page/student_home_widget.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hands on Project',
      theme: ThemeData(
        // primary color : 0c218b
        primarySwatch: Colors.indigo,
      ),
      debugShowCheckedModeBanner: false,
      home: StudentWidget(),
    );
  }
}
