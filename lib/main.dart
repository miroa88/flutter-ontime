// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:math';
import 'next_page.dart';
import 'my_navigation_page.dart';
import 'from_scratch.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:  StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator());
            }
            else if(snapshot.hasError){
              return Center(child: Text("something went wrong"),);
            }
            else if(snapshot.hasData){
              return MyNavigation(FirebaseAuth.instance.currentUser!.uid);
            }
            else{
              return FromScratchPage();
            }
          }
      ),
    );

  }
}



