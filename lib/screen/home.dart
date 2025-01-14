import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:todo/Wdget/StreemNote.dart';
import 'package:todo/Wdget/TaskWidget.dart';
import 'package:todo/auth/auth_page.dart';
import 'package:todo/const/colors.dart';
import 'package:todo/data/firestor.dart';
import 'package:todo/screen/AddNote.dart';
import 'package:todo/screen/login.dart';

class Home_Screen extends StatefulWidget {
  Home_Screen({super.key});

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  bool show = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: custom_green.withOpacity(0.8),
        title: Center(
          child: Text(
            'To-Do',
            style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Auth_Page()));
            },
            child: Icon(Icons.logout_outlined, color: Colors.red, size: 40),
          ),
          SizedBox(width: 15),
        ],
      ),
      backgroundColor: backgroundColors,
      floatingActionButton: Visibility(
        // visible: show,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddNote()));
          },
          backgroundColor: custom_green,
          child: Icon(Icons.add, size: 30),
        ),
      ),
      body: NotificationListener<UserScrollNotification>(
        onNotification: (notification) {
          if (notification.direction == ScrollDirection.forward) {
            setState(() {
              show = true;
            });
          }
          if (notification.direction == ScrollDirection.reverse) {
            setState(() {
              show = false;
            });
          }
          return false;
        },
        child: SingleChildScrollView( // Added SingleChildScrollView
          child: Column(
            children: [
              StreemNote(false),
              Text(
                'Is-Done',
                style: TextStyle(fontSize: 16, color: Colors.grey.shade500, fontWeight: FontWeight.bold),
              ),
              StreemNote(true),
            ],
          ),
        ),
      ),
    );
  }
}
