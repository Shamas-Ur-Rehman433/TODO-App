import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo/Model/LoginModel.dart';
import 'package:todo/Model/NotesModel.dart';
import 'package:todo/screen/home.dart';
import 'package:uuid/uuid.dart';

class Firestore_Datasource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> CreateUser(String email) async {
    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .set({'id': _auth.currentUser!.uid, 'email': email});
      return true;
    } catch (e) {
      print(e);
      return true;
    }
  }


  Future<bool> AddNote(String title, String subtitle, int image) async {
    var uuid = Uuid().v4();
    DateTime date = DateTime.now();

    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('notes')
          .doc(uuid)
          .set({
        'id': uuid,
        'subtitle': subtitle,
        'isDone': false,
        'image': image,
        'time': '${date.hour}:${date.minute}',
        'title': title
      });
      return true;
    } catch (e) {
      return true;
    }
  }

  List getNotes(AsyncSnapshot snapshot) {
    try {
      final notelist = snapshot.data.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Note(
          data['id'],
          data['subtitle'],
          data['image'],
          data['time'],
          data['title'],
          data['isDone'],
        );
      }).toList();
      return notelist;
    } catch (e) {
      return [];
    }
  }




  Future<User?> login(String email, String password) async {
  try {
  UserCredential userCredential = await _auth.signInWithEmailAndPassword(
  email: email,
  password: password,
  );
  return userCredential.user;
  } on FirebaseAuthException catch (e) {
  print('Login error: $e');
  return null;
  }
  }



  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      print('Password reset email sent to $email');
    } on FirebaseAuthException catch (e) {
      print('Error sending password reset email: $e');
    }
  }







  Stream<QuerySnapshot> stream(bool isDone) {
    return _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .collection('notes').where('isDone',isEqualTo: isDone)
        .snapshots();
  }

  Future<bool> isDone(String uuid, bool isDone) async {
    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('notes')
          .doc(uuid)
          .update(({'isDone': isDone}));
      return true;
    } catch (e) {
      print(e);
      return true;
    }
  }

  Future<bool> Update_Note(String uuid,int image,String title,String sutitle,) async {
    try {
      DateTime date=DateTime.now();
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('notes')
          .doc(uuid)
          .update(({
        'time': '${date.hour}:${date.minute}',
        'title': title,
        'subtitle': sutitle,
        'image': image

      }));
      return true;
    } catch (e) {
      print(e);
      return true;
    }
  }

  Future<bool> Delete_Note(String uuid)async{
    try{
      await _firestore.collection('users').doc(_auth.currentUser!.uid).collection('notes').doc(uuid).delete();
      return true;
    }
    catch(e){
      return true;
    }
  }
}
