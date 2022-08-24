//dashboard

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practice_app/back_end/notification_controller.dart';
import 'package:practice_app/back_end/ontime_user.dart';
import '/front_end/create_new_meeting/create_title.dart';
import 'package:uuid/uuid.dart';
import 'meeting_specifications_page.dart';
import 'dart:async';
class Dashboard extends StatefulWidget {
  final String userId;
  Dashboard(this.userId);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final typeController = TextEditingController();
  final linkController = TextEditingController();
  late Timer timer;
  bool showPicture = false;
  final map = {
    'Zoom': 'images/zoom.png' ,
    'Google Meet': 'images/google.png',
    'Phone call': 'images/phone.png',
    'In person' : 'images/person.png'
  };
  int indexOfMap(String type) {
    int index;
    if(type == "Zoom")
      index = 0;
    else if(type == "Google Meet")
      index = 1;
    else if(type == "Phone call")
      index = 2;
    else
      index = 3;
    return index;
  }

  @override
  void initState() {
    super.initState();

    NotificationController.initLocalNotification(selectNotification);
    initTimer();
    initShowWelcomePic();

  }

  void initShowWelcomePic() {
    FirebaseFirestore.instance.collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid).collection("records")
        .snapshots().listen((event) {
          if(mounted){
            if(event.docs.isEmpty){
              setState(() {
                showPicture = true;
              });

            }
            else {
              setState(() {
                showPicture = false;
              });
            }
          }
    });
  }
  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void initTimer() {
    if(mounted) {
          timer = Timer.periodic(const Duration(seconds: 30), (timer) {
            setState(() {});
          });
    }
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
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid).collection("records").orderBy('date_time',  descending: true).snapshots();
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Row(
              children: [
                const Text('Dashboard'),
              ],
            ),
          ],
        ),
      ),
      body:
      showPicture ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Hit", style: TextStyle(
              fontSize: 55,
              fontWeight: FontWeight.bold
            ),),
            Container(
              height: 250,
                width: 250,
                child: Image.asset('images/plus.png')),
            Text("To start", style: TextStyle(
                fontSize: 55,
                fontWeight: FontWeight.bold
            ),)
          ],
        ),
      ) :
      Container(
        margin: EdgeInsets.only(top: 10),
        child: StreamBuilder<QuerySnapshot>(
            stream: _usersStream,
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Something went wrong'));
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        alignment: Alignment.topCenter,
                        margin: EdgeInsets.only(top: 20),
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.grey,
                          color: Colors.black,
                          strokeWidth: 10,
                        )
                    ),
                  ],
                );
              }
              return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                  return Container(
                    margin: EdgeInsets.only(right: 10, left: 10),
                    child: Card(
                        color: (data['date_time'].toDate().add(Duration(minutes: (data['duration-min'])))
                            .compareTo(DateTime.now()) < 0 ) ? Colors.redAccent:
                        (data['date_time'].toDate().compareTo(DateTime.now()) > 0) ? Colors.yellowAccent : Colors.greenAccent,
                        //yellow: future meetings, green: in process meetings, red: past meetings
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MeetingSpecifications(data['Record_ID'])),
                            );
                          },
                          leading: CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.white,
                            backgroundImage: AssetImage(map.values.elementAt(indexOfMap(data['Meeting_type']))),
                          ),
                          title: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(data['Title']),
                                  SizedBox(height: 5,),
                                  Text("${data['Date']}  ${data['Start_Time']}"),
                                ],
                              ),
                              Spacer(),
                              IconButton(onPressed: () {
                                _deleteUser(widget.userId, data['Record_ID']);
                                NotificationController.cancelNotification(data['Notification_ID']);
                                OnTimeUser.initUsers();
                              }, icon: Icon(Icons.delete))
                            ],
                          ),
                        )),
                  );
                }).toList(),
              );
            }
        ),
      ),


      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () async {
          var recordId = Uuid().v4();
          _addUser(widget.userId, recordId);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => CreateTitle(widget.userId, recordId)),
                (Route<dynamic> route) => false,
          );
        },
        child: const Icon(Icons.add,
        ),
      ),
    );
  }


  Future<void> _addUser(String userID, String recordID) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users')
        .doc(userID).collection("records");

    return users
        .doc(recordID)
        .set({
      'Record_ID': recordID,
      'Title' : "",
      'Date' : "",
      'search_list' : [],
    })
        .then((value) => print("Title Added"))
        .catchError((error) => print("Failed to add tile: $error"));
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
