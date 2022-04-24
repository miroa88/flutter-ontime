//coping link pass etc
import '../../back_end/notification_controller.dart';
import '/../back_end/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:clipboard/clipboard.dart';
import 'package:rxdart/rxdart.dart';
import '../meeting_specifications_page.dart';
import '/front_end/navigation_page.dart';


class MeetingDetailsPage extends StatefulWidget {
  final searchList;
  final String userId;
  final String recordId;
  DateTime recordStartDateTime;
  String type;
  bool isZoom = false;
  bool isPhone = false;
  bool isInPerson = false;
  MeetingDetailsPage(this.userId, this.recordId, this.type, this.recordStartDateTime, this.searchList)
  {
    if(type == 'In person')
      isInPerson = true;
    else if(type == 'Phone call')
      isPhone = true;
    else
      isZoom = true;
  }

  @override
  _MeetingDetailsPageState createState() => _MeetingDetailsPageState();
}

class _MeetingDetailsPageState extends State<MeetingDetailsPage> {
  var linkController = TextEditingController();
  var passController = TextEditingController();
  var phoneNumController = TextEditingController();
  var addressController = TextEditingController();
  bool _isAddressEmpty = false;
  bool _isPhoneEmpty = false;
  bool _isLinkEmpty = false;
  bool _isPassEmpty = false;
  bool _dateTimeErr = false;
  bool _progressIndicator = false;
  bool _tryAgain = false;
  // late AndroidNotificationChannel channel;


  @override
  void initState() {
    super.initState();

    NotificationController.initLocalNotification(selectNotification);
    }

  void selectNotification(String? payload) async {
    if (payload != null) {
      print('notification payload: $payload');
    }
    await Navigator.push(
      context,
      MaterialPageRoute<void>(builder: (context) => MeetingSpecifications(payload)),
    );
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

    return
      // _GoToDashboard ? NavigationScreen(widget.userId) :
      Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text('Create New Meeting'),
            Spacer(),
            IconButton(onPressed: (){
              _deleteUser(widget.userId,widget.recordId);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => NavigationScreen()),
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
          _progressIndicator ? Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(top: 20),
              child: CircularProgressIndicator(
                backgroundColor: Colors.grey,
                color: Colors.black,
                strokeWidth: 10,
              )
          ) : Container(),

          _dateTimeErr ? Center(
            child: Text(
              'The Meeting should be scheduled for a future time.\nPlease go back and pick another date or time.',
              style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold),
                ),
          ) : Container(),

          _tryAgain ? Center(
            child: Text(
              'Please try again',
              style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold),
            ),
          ) : Container(),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.only(right: 20,top: 50),
                child: SizedBox(
                  height: 35,
                  width: 84,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black, // Background color
                      onPrimary: Colors.white, // Text Color (Foreground color)
                    ),
                    onPressed: () async {
                      setState(() {_tryAgain = false;});
                      setState(() {_progressIndicator = true;});

                      if(addressController.text.isEmpty) {
                        setState(() {
                          _isAddressEmpty = true;
                        });
                      } else {_isAddressEmpty = false;}

                      if(phoneNumController.text.isEmpty) {
                        setState(() {
                          _isPhoneEmpty= true;
                        });
                      } else {_isPhoneEmpty = false;}

                      if(linkController.text.isEmpty) {
                        setState(() {
                          _isLinkEmpty = true;
                        });
                      } else {_isLinkEmpty = false;}

                      if(passController.text.isEmpty) {
                        setState(() {
                          _isPassEmpty = true;
                        });
                      } else {_isPassEmpty = false;}

                      if(!_isAddressEmpty || !_isPhoneEmpty || (!_isPassEmpty && !_isLinkEmpty))
                      {
                        print("start time ${widget.recordStartDateTime}");
                        int id = (DateTime.now().millisecondsSinceEpoch) % 10000000000;//notification ID

                        if((widget.recordStartDateTime.subtract(const Duration(seconds: 30)))
                            .compareTo(DateTime.now()) > 0) {
                          _addUser(widget.userId, widget.recordId, linkController.text, passController.text,
                              phoneNumController.text, addressController.text, id, widget.searchList);
                          await NotificationController.scheduleNotification(
                            ((widget.recordStartDateTime.subtract( const Duration(minutes: 5))).compareTo(DateTime.now()) > 0) ?
                            widget.recordStartDateTime.subtract(const Duration(minutes: 5)) :
                            widget.recordStartDateTime , //it notifies about the meeting 5 min earlier
                            id,
                            "Meeting Reminder: ${widget.type}",
                            "Meeting in 5 minutes.",
                            widget.recordId.toString(),
                          ).timeout(const Duration(seconds: 7),
                            onTimeout: () {
                                setState(() { _tryAgain = true;}); //timeout set to 7 seconds if scheduling went wrong
                            }).onError((error, stackTrace) {
                            print(error);
                            setState(() {_tryAgain = true;});
                          }).whenComplete(() {
                            _addUser(widget.userId, widget.recordId, linkController.text, passController.text,
                                phoneNumController.text, addressController.text, id, widget.searchList);
                          });

                          if(!_tryAgain) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => NavigationScreen()),
                                  (Route<dynamic> route) => false,
                            );
                          }
                        }
                        else {
                          setState(() {
                            _dateTimeErr = true;
                          });
                        }
                      }
                      setState(() {_progressIndicator = false;});
                    },
                    child: const Text('CREATE'),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<void> _addUser(String userID, String recordID, String link, String pass, String phoneNum,
      String address, int notificationID, List searchList) {
    CollectionReference users = FirebaseFirestore.instance.collection('users')
        .doc(userID).collection("records");

    return users
        .doc(recordID)
        .update({
      'Meeting_Link': link,
      'Password': pass,
      'Phone_number': phoneNum,
      'Meeting_address' : address,
      'Notification_ID' : notificationID,
      'search_list': FieldValue.arrayUnion(searchList),
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

  List<String> searchElementGenerator(String s) {
    List<String> tempList = List<String>.empty(growable: true);
    String sLower = s.toLowerCase();

    for (int i = 0; i < sLower.length; i++) {
      if(i == 0) {
        tempList.add(sLower[i]);
      }
      else {
        tempList.add(tempList[i-1] + sLower[i]);
      }
    }
    return tempList;
  }

}



