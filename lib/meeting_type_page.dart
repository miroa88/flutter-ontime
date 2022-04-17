//coping link pass etc

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart';
import 'my_navigation_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:clipboard/clipboard.dart';

class MeetingTypePage extends StatefulWidget {
  final String userId;
  final String recordId;
  String type;
  bool isZoom = false;
  bool isPhone = false;
  bool isInPerson = false;
  MeetingTypePage(this.userId, this.recordId, this.type)
  {
    if(type == 'In person')
      isInPerson = true;
    else if(type == 'Phone call')
      isPhone = true;
    else
      isZoom = true;
  }

  @override
  _MeetingTypePageState createState() => _MeetingTypePageState();
}

class _MeetingTypePageState extends State<MeetingTypePage> {
  var linkController = TextEditingController();
  var passController = TextEditingController();
  var phoneNumController = TextEditingController();
  var addressController = TextEditingController();
  bool _isAddressEmpty = false;
  bool _granted = false;
  bool _isPhoneEmpty = false;
  bool _isLinkEmpty = false;
  bool _isPassEmpty = false;

  late AndroidNotificationChannel channel;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    initLocalNotification();
    // FirebaseMessaging.instance.unsubscribeFromTopic("event");
  }

  void initLocalNotification() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    FlutterLocalNotificationsPlugin().initialize(const InitializationSettings(
      android: AndroidInitializationSettings('ontime1'),
      iOS: IOSInitializationSettings(),
    ));

    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title

      importance: Importance.high,
      enableVibration: true,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

  }

  Future _scheduleNotification(Duration dur, int id, String title, String body) async{
    var location = Location('UTC', [minTime], [0], [TimeZone.UTC]);
    flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        TZDateTime.now(location).add(dur),
        NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              importance: Importance.high,
              icon: 'ontime1',
            )
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime);
    print("scheduled");
  }

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
          widget.isZoom ?
          Container(
            margin: EdgeInsets.only(left:10, right: 10, bottom: 5,top :20),
            width: _width,
            height: _height/7,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 5, left: 5, bottom: 10 ),
                      child: Text("Enter Meeting link or ID",
                        style: GoogleFonts.lato(
                            textStyle: Theme.of(context).textTheme.headline4,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            color: Colors.black
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 82,
                      child: TextField(
                          enabled: widget.isZoom,
                          controller: linkController,
                          decoration: InputDecoration(
                              hintText: 'Meeting Link or ID',
                              hintStyle: _isLinkEmpty ? TextStyle( color: Colors.red) :
                              TextStyle( color: Colors.grey) ,
                              contentPadding: const EdgeInsets.all(15),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(color: Colors.black),)
                          ),
                          autofocus: true
                      ),
                    ),
                    Expanded(
                      flex: 18,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 14),
                        ),
                        onPressed: widget.isZoom  ?
                            () {
                          FlutterClipboard.paste().then((value) {
                            // Do what ever you want with the value.
                            setState(() {
                              linkController.text = value;
                            });
                          });
                        } : null,
                        child: const Text('PASTE',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ) : Container(),
          widget.isZoom ?
          Container(
              margin: EdgeInsets.only(left:10, right: 10, top: 10),
              width: _width,
              height: _height/7,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 5, left: 5, bottom: 10),
                        child: Text("Enter Meeting Password",
                          style: GoogleFonts.lato(
                              textStyle: Theme.of(context).textTheme.headline4,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                              color: Colors.black
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 82,
                        child: TextField(
                            controller: passController,
                            obscureText: true,
                            decoration: InputDecoration(
                                hintText: 'Meeting Password',
                                hintStyle: _isPassEmpty ? TextStyle( color: Colors.red) :
                                TextStyle( color: Colors.grey) ,
                                contentPadding: const EdgeInsets.all(15),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(color: Colors.black),)
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
                          child: const Text('PASTE',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),),
                        ),
                      ),
                    ],
                  ),
                ],
              )
          ) : Container(),
          widget.isPhone ?
          Container(
              margin: EdgeInsets.only(left:10, right: 10, bottom: 5,top :20),
              width: _width,
              height: _height/7,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 5, left: 5,bottom: 10),
                        child: Text("Enter Phone Number",
                          style: GoogleFonts.lato(
                              textStyle: Theme.of(context).textTheme.headline4,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                              color: Colors.black
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 82,
                        child: TextField(
                            controller: phoneNumController,
                            decoration: InputDecoration(
                                hintText: 'Meeting Phone Number',
                                hintStyle: _isPhoneEmpty ? TextStyle( color: Colors.red) :
                                TextStyle( color: Colors.grey) ,
                                contentPadding: const EdgeInsets.all(15),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(color: Colors.black),)
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
                          child: const Text('PASTE',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),),
                        ),
                      ),
                    ],
                  ),
                ],
              )
          ) : Container(),
          widget.isInPerson ?
          Container(
              margin: EdgeInsets.only(left:10, right: 10, bottom: 5,top: 20),
              width: _width,
              height: _height/7,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 5,left: 5,bottom: 10),
                        child: Text("Enter Meeting Address",
                          style: GoogleFonts.lato(
                              textStyle: Theme.of(context).textTheme.headline4,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                              color: Colors.black
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 82,
                        child: TextField(
                            controller: addressController,
                            decoration: InputDecoration(
                                hintText: 'Meeting Address',
                                hintStyle: _isAddressEmpty ? TextStyle( color: Colors.red) :
                                  TextStyle( color: Colors.grey) ,
                                contentPadding: const EdgeInsets.all(15),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(color: Colors.black),)
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
                          child: const Text('PASTE',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),),
                        ),
                      ),
                    ],
                  ),
                ],
              )
          ) : Container(),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.only(right: 20,top: 50),
                child: ElevatedButton(
                  onPressed: () {
                    if(addressController.text == "") {
                      setState(() {
                        _isAddressEmpty = true;
                      });
                    } else {_isAddressEmpty = false;}

                    if(phoneNumController.text == "") {
                      setState(() {
                        _isPhoneEmpty= true;
                      });
                    } else {_isPhoneEmpty = false;}

                    if(linkController.text == "") {
                      setState(() {
                        _isLinkEmpty = true;
                      });
                    } else {_isLinkEmpty = false;}

                    if(passController.text == "") {
                      setState(() {
                        _isPassEmpty = true;
                      });
                    } else {_isPassEmpty = false;}

                    if(!_isAddressEmpty || !_isPhoneEmpty || (!_isPassEmpty && !_isLinkEmpty))
                      _granted = true;

                    if(_granted && false)
                      {
                        _addUser(widget.userId, widget.recordId, linkController.text, passController.text,
                            phoneNumController.text, addressController.text);
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => MyNavigation(widget.userId)),
                              (Route<dynamic> route) => false,
                        );
                      }
                    int id = DateTime.now().millisecondsSinceEpoch;
                    _scheduleNotification(
                        Duration(seconds: 5),
                        1234,
                        widget.type,
                        "Meeting will start on"
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



