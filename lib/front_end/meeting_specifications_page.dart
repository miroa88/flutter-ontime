import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import '../back_end/Record.dart';
import '../back_end/notification_controller.dart';
import '../back_end/ontime_user.dart';
import 'navigation_page.dart';

class MeetingSpecifications extends StatefulWidget {
  final String? recordId;
  MeetingSpecifications(this.recordId);

  @override
  State<MeetingSpecifications> createState() => _MeetingSpecificationsState();
}

class _MeetingSpecificationsState extends State<MeetingSpecifications> {
  var noteController = TextEditingController();
  Record tempRecord = Record();
  final map = {
    'Zoom': 'images/zoom.png' ,
    'Google Meet': 'images/google.png',
    'Phone call': 'images/phone.png',
    'In person' : 'images/person.png'
  };
  int indexOfMap() {
    int index;
    if(tempRecord.type == "Zoom")
      index = 0;
    else if(tempRecord.type == "Google Meet")
      index = 1;
    else if(tempRecord.type == "Phone call")
      index = 2;
    else
      index = 3;
    return index;
  }

  @override
  void initState() {

    super.initState();
    initRecord();
  }

  void initRecord() async {
    await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('records').doc(widget.recordId).get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        tempRecord = Record(
            recordID: documentSnapshot.get('Record_ID'),
            date: documentSnapshot.get('Date'),
            duration: documentSnapshot.get('Duration'),
            link: documentSnapshot.get('Meeting_Link'),
            address: documentSnapshot.get('Meeting_address'),
            type: documentSnapshot.get('Meeting_type'),
            pass: documentSnapshot.get('Password'),
            phone: documentSnapshot.get('Phone_number'),
            isRecurring: documentSnapshot.get('Recurring_Meeting'),
            startTime: documentSnapshot.get('Start_Time'),
            title: documentSnapshot.get('Title'));
      } else {
        print('Document does not exist on the database');
      }
    }).whenComplete(() {
      setState(() {
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    final map = {
      'Zoom': 'images/zoom.png' ,
      'Google Meet': 'images/google.png',
      'Phone call': 'images/phone.png',
      'In person' : "images/person.png"
    };

    return Scaffold(
        appBar: AppBar(
          title: Text('Display Meeting'),
        ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 10, right: 10),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top:10),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage(map.values.elementAt(indexOfMap())),
                      minRadius: 30,
                      maxRadius: 50,
                    ),
                  ),
                  Column(children: [
                    Text(tempRecord.type,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 22.0,
                        color: Colors.black,
                      ),),
                    SizedBox(height: 10,),
                    Text(tempRecord.title,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 25.0,
                          color: Colors.black,
                        )),
                  ],),
                  SizedBox(height: 10,),
                  Container(
                    height: 70,
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      color: Colors.blue[100],
                      child: ListTile(
                        leading: Icon(Icons.date_range),
                        title: Text('Date'),
                        subtitle: Text(tempRecord.date),
                      ),
                    ),
                  ),
                  Container(
                    height: 70,
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      color: Colors.blue[100],
                      child: ListTile(
                        leading: Icon(Icons.timelapse),
                        title: Text('Time'),
                        subtitle: Text(tempRecord.startTime),
                      ),
                    ),
                  ),
                  Container(
                    height: 70,
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      color: Colors.blue[100],
                      child: ListTile(
                        leading: Icon(Icons.timer),
                        title: Text('Duration'),
                        subtitle: Text(tempRecord.duration),
                      ),
                    ),
                  ),
                  (tempRecord.type == "Google Meet" || tempRecord.type == "Zoom") ?
                  Container(
                    height: 70,
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      color: Colors.blue[100],
                      child: ListTile(
                        leading: Icon(Icons.link),
                        title: Text('Link'),
                        subtitle: Text(tempRecord.link),
                        onTap: () {
                          Clipboard.setData(ClipboardData(text: tempRecord.link));
                        },

                      ),
                    ),
                  ) : Container(),
                  (tempRecord.type == "Google Meet" || tempRecord.type == "Zoom") ?
                  Container(
                    height: 70,
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      color: Colors.blue[100],
                      child: ListTile(
                        leading: Icon(Icons.password),
                        title: Text('Password'),
                        subtitle: Text(tempRecord.pass),
                        onTap: () {
                          Clipboard.setData(ClipboardData(text: tempRecord.pass));
                        },
                      ),
                    ),
                  ) : Container(),
                  (tempRecord.type == "Phone call") ?
                  Container(
                    height: 70,
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      color: Colors.blue[100],
                      child: ListTile(
                        leading: Icon(Icons.phone),
                        title: Text('Phone Number'),
                        subtitle: Text(tempRecord.phone),
                      ),
                    ),
                  ) : Container(),
                  (tempRecord.type == "In person") ?
                  Container(
                    height: 70,
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      color: Colors.blue[100],
                      child: ListTile(
                        leading: Icon(Icons.location_pin),
                        title: Text('Meeting Address'),
                        subtitle: Text(tempRecord.address),
                      ),
                    ),
                  ) : Container(),
                  SizedBox(height: 20,),
                  TextButton(onPressed: (){
                    openDialog();
                    FirebaseFirestore.instance.collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection("records").doc(tempRecord.recordID).get()
                        .then((DocumentSnapshot documentSnapshot) {
                          if(documentSnapshot.exists) {
                            try{
                              setState(() {
                                print("I am here");
                                noteController.text = documentSnapshot.get('note');
                              });
                            } catch (err) {
                              print("note is empty (" + err.toString() + ")");
                            }
                          }
                    });


                  }, child: Text('Show notes',
                  style: TextStyle(
                    fontSize: 17
                  ),)
                  ),
                  // TextButton(onPressed: (){
                  //   OnTimeUser.records.forEach((key, value) {print(key + " " + value.date);});
                  //   print("*************************************");
                  // }, child: Icon(Icons.title))
                ],
              ),
            )
        ),
      ),
    );
  }

  Future openDialog() => (
    showDialog(context: context,
        builder: (context) => AlertDialog(
          title: Text('Your notes:'),
          content: TextField(
            decoration: InputDecoration(
              hintText: "add your note here"
            ),

            controller: noteController,
            textInputAction: TextInputAction.newline,
            keyboardType: TextInputType.multiline,
            maxLines: 5,
          ),
          actions: [
            TextButton(onPressed: (){
              updateNote(FirebaseAuth.instance.currentUser!.uid, tempRecord.recordID, noteController.text);
              Navigator.of(context).pop();
            }, child: Text('OK'))
          ],
        ))
  );

  Future<void> updateNote(String userID, String recordID, String note) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users')
        .doc(userID).collection("records");

    return users
        .doc(recordID)
        .update({
      'note': note,
    })
        .then((value) => print("note Added"))
        .catchError((error) => print("Failed to add note: $error"));
  }
}
