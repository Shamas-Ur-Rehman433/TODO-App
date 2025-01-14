import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo/Wdget/TaskWidget.dart';
import 'package:todo/auth/main_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todo/screen/AddNote.dart';
import 'package:todo/screen/ForgetPassword.dart';
import 'package:todo/screen/home.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Main_Page(),
    );
  }
}
