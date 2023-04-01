import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sq_flite_demo/db/db_helper.dart';
import 'package:sq_flite_demo/screens/home_screen.dart';

DBHelper? dbHelper;
void main() {
  dbHelper = DBHelper();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      home: HomeScreen(),
    );
  }
}
