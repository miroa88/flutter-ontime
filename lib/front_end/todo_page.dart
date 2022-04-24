
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:intl/intl.dart';
import '../back_end/notification_controller.dart';
import 'meeting_specifications_page.dart';

class ToDoPage extends StatefulWidget {
  const ToDoPage({Key? key}) : super(key: key);

  @override
  _ToDoPageState createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  bool showPicture = false;
  DateTime _selectedDate = DateTime.now();
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
    _resetSelectedDate();

    NotificationController.initLocalNotification(selectNotification);
    initShowPic();
  }

  void initShowPic() {
    FirebaseFirestore.instance.collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid).collection("records")
        .where('Date', isEqualTo: DateFormat.yMMMMd('en_US').format(_selectedDate).toString())
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

  void _resetSelectedDate() {
    _selectedDate = DateTime.now();
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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid).collection("records")
        .orderBy('date_time')
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        title: const Text('To Do'),
      ),

      body: Column(
        children: [
          Expanded(
            flex: 20,
            child: Card(
              child: Container(
                margin: EdgeInsets.only(right: 20),
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CalendarTimeline(
                        showYears: false,
                        initialDate: _selectedDate,
                        firstDate: DateTime(2022),
                        lastDate: DateTime.now().add(Duration(days: 1000)),
                        onDateSelected: (date) {
                          setState(() {
                            _selectedDate = date!;
                          });
                          print(_selectedDate);
                          initShowPic();
                        },
                        leftMargin: 20,
                        monthColor: Colors.black87,
                        dayColor: Colors.black,
                        dayNameColor: Colors.white,
                        activeDayColor: Colors.white,
                        activeBackgroundDayColor: Colors.black,
                        dotsColor: Colors.white,
                        locale: 'en_ISO',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          showPicture ? Expanded(
            flex: 80,
            child: Container(
              height: 300,
              width: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Nothing scheduled for ",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 30
                  ),),
                  Text(DateFormat.yMMMMd('en_US').format(_selectedDate).toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 30
                    ),),
                  SizedBox(height: 5,),
                  Image.asset('images/calendar.png',
                      scale: 1.6),

                ],
              ),
            ),
          ) :
          Expanded(
            flex: 80,
            child:
            Container(
              child: StreamBuilder<QuerySnapshot>(
                  stream: _usersStream,
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Column(
                        children: [
                          SizedBox(
                            height: height/5 ,
                          ),
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

                    return Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      child: ListView(
                        children: snapshot.data!.docs.map((DocumentSnapshot document) {
                          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

                          return DateFormat.yMMMMd('en_US').format(_selectedDate).toString() == data['Date'] ?
                            Card(
                              elevation: 5,
                              // shape: const CircleBorder(),
                              shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                          ),
                          color: Colors.blue[100],
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => MeetingSpecifications(data['Record_ID'])),
                              );
                            },
                            title: Row(
                              children: [
                                Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundImage: AssetImage(map.values.elementAt(indexOfMap(data['Meeting_type']))),
                                      backgroundColor: Colors.white,
                                    ),
                                  ],
                                ),
                                SizedBox(width: 10,),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Row(
                                      children: [
                                        Icon(Icons.adjust_outlined),
                                        SizedBox(width: 5,),
                                        Text(data['Start_Time'],
                                          // style: TextStyle(fontSize: 18,
                                          //     color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    Icon(Icons.height),
                                    Row(
                                      children: [
                                        Icon(Icons.adjust_outlined),
                                        SizedBox(width: 5,),
                                        Text(TimeOfDay(
                                          hour: data['date_time'].toDate().add(Duration(minutes: data['duration-min'])).hour ,
                                          minute: data['date_time'].toDate().add(Duration(minutes: data['duration-min'])).minute,
                                        ).format(context).toString(),
                                          // style: TextStyle(fontSize: 18,
                                          //     color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Center(
                                  child: Text("Duration: ${data['duration-min']} min"),
                                )
                              ],
                            ),
                            // subtitle: Text(data['Date']),
                          )) : Container();
                        }).toList(),
                      ),
                    );
                  }
              ),
            ),
          ),
        ],
      ),
    );
  }
}
