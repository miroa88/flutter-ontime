//coping link pass etc

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'my_navigation_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:clipboard/clipboard.dart';

class MeetingTypePage extends StatefulWidget {
  final String userId;
  final String recordId;
  MeetingTypePage(this.userId, this.recordId);

  @override
  _MeetingTypePageState createState() => _MeetingTypePageState();
}

class _MeetingTypePageState extends State<MeetingTypePage> {
  var linkController = TextEditingController();
  var passController = TextEditingController();
  var phoneNumController = TextEditingController();
  var addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery
        .of(context)
        .size
        .height;
    double _width = MediaQuery
        .of(context)
        .size
        .width;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text('Create New Meeting'),
            Spacer(),
            IconButton(onPressed: (){
              _deleteUser(widget.userId,widget.recordId);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => MyNavigation(widget.userId)),
                    (Route<dynamic> route) => false,
              );
            }, icon: Icon(Icons.close)),
          ],
        ),
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(left:10, right: 10),
            width: _width,
            height: _height/9,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 82,
                      child: TextField(
                          controller: linkController,
                          decoration: InputDecoration(
                              labelText: 'Meeting Link or ID'
                          ),
                          autofocus: true
                      ),
                    ),
                    //Spacer(),
                    Expanded(
                      flex: 18,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 14),
                        ),
                        onPressed: () {
                          FlutterClipboard.paste().then((value) {
                            // Do what ever you want with the value.
                            setState(() {
                              linkController.text = value;
                            });
                          });
                        },
                        child: const Text('PASTE'),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Text("Enter meeting link or ID",
                        style: GoogleFonts.lato(
                            textStyle: Theme.of(context).textTheme.headline4,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.italic,
                            color: Colors.black
                        ),
                      ),
                    ),
                  ],
                ),

              ],
            )
          ),
          Container(
              margin: EdgeInsets.only(left:10, right: 10),
              width: _width,
              height: _height/9,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 82,
                        child: TextField(
                            controller: passController,
                            decoration: InputDecoration(
                                labelText: 'Meeting Password'
                            ),
                            autofocus: true
                        ),
                      ),
                      //Spacer(),
                      Expanded(
                        flex: 18,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 14),
                          ),
                          onPressed: () {
                            FlutterClipboard.paste().then((value) {
                              // Do what ever you want with the value.
                              setState(() {
                                passController.text = value;
                              });
                            });
                          },
                          child: const Text('PASTE'),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Text("Enter meeting password",
                          style: GoogleFonts.lato(
                              textStyle: Theme.of(context).textTheme.headline4,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.italic,
                              color: Colors.black
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
          ),
          Container(
              margin: EdgeInsets.only(left:10, right: 10, bottom: 5),
              width: _width,
              height: _height/9,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 82,
                        child: TextField(
                            controller: phoneNumController,
                            decoration: InputDecoration(
                                labelText: 'Phone Meeting Number'
                            ),
                            autofocus: true
                        ),
                      ),
                      //Spacer(),
                      Expanded(
                        flex: 18,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 14),
                          ),
                          onPressed: () {
                            FlutterClipboard.paste().then((value) {
                              // Do what ever you want with the value.
                              setState(() {
                                phoneNumController.text = value;
                              });
                            });
                          },
                          child: const Text('PASTE'),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Text("Enter Phone number",
                          style: GoogleFonts.lato(
                              textStyle: Theme.of(context).textTheme.headline4,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.italic,
                              color: Colors.black
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
          ),
          Container(
              margin: EdgeInsets.only(left:10, right: 10, bottom: 5),
              width: _width,
              height: _height/9,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 82,
                        child: TextField(
                            controller: addressController,
                            decoration: InputDecoration(
                                labelText: 'Meeting Address'
                            ),
                            autofocus: true
                        ),
                      ),
                      //Spacer(),
                      Expanded(
                        flex: 18,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 14),
                          ),
                          onPressed: () {
                            FlutterClipboard.paste().then((value) {
                              // Do what ever you want with the value.
                              setState(() {
                                addressController.text = value;
                              });
                            });
                          },
                          child: const Text('PASTE'),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Text("Enter Meeting Address",
                          style: GoogleFonts.lato(
                              textStyle: Theme.of(context).textTheme.headline4,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.italic,
                              color: Colors.black
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.only(right: 20),
                child: ElevatedButton(
                  onPressed: () {
                    _addUser(widget.userId, widget.recordId, linkController.text, passController.text,
                        phoneNumController.text, addressController.text);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => MyNavigation(widget.userId)),
                          (Route<dynamic> route) => false,
                    );
                  },
                  child: const Text('CREATE'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
  Future<void> _addUser(String userID, String recordID, String link, String pass, String phoneNum,
      String address) {
    CollectionReference users = FirebaseFirestore.instance.collection('users')
        .doc(userID).collection("records");

    return users
        .doc(recordID)
        .update({
      'Meeting_Link': link,
      'Password': pass,
      'Phone_number': phoneNum,
      'Meeting_address' : address
    })
        .then((value) => print("Link Added"))
        .catchError((error) => print("Failed to add Link: $error"));
  }

  Future<void> _deleteUser(String userID, String recordID) {
    CollectionReference users = FirebaseFirestore.instance.collection('users')
        .doc(userID).collection("records");
    return users
        .doc(recordID)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

}



