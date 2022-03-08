//its not related to project

import 'package:flutter/material.dart';
import 'package:practice_app/from_scratch.dart';
import 'dart:math';
import 'main.dart';
import 'user_profile.dart';
class MyThirdPage extends StatefulWidget {
  const MyThirdPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyThirdPage> createState() => _MyThirdPageState();
}

class _MyThirdPageState extends State<MyThirdPage> {
 String flag = "";
 final myController = TextEditingController();

 @override
 void dispose() {
   // Clean up the controller when the widget is disposed.
   myController.dispose();
   super.dispose();
 }

 void _isPalindrome(String text) {
      setState(() {
        if (text == text.split('').reversed.join()) {
          flag = "YES";
        } else {
          flag = "NO";
        }
      });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 250,
              margin: EdgeInsets.all(30),
              child: const Image(
                image: NetworkImage('https://wpguynews.com/wp-content/uploads/2021/03/one-click-gmail-login-for-wordpress-featured-image.jpg.webp'),
              ),
            ),
            Container(

              child: const Text(
                'Is It Palindrome?',
                style: TextStyle(
                  color: Colors.black ,
                  fontSize: 38,
                  fontStyle: FontStyle.normal ,
                ),
              ),
            ),
            Container(
              width: 300,
              margin: EdgeInsets.all(2),
              child: TextField(
                controller: myController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter a text',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Text(
                flag,
                style: const TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Container(
              width: 250,
              child: TextButton(
                child: const Text("Click"),
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.blue,
                ),
                onPressed:() {
                  _isPalindrome(myController.text);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:() => {
          Navigator.push(context,MaterialPageRoute(builder: (context) => FromScratchPage()),
          ),
        },
        tooltip: 'Increment',
        child: const Icon(Icons.forward),
      ),
    );
  }
}
