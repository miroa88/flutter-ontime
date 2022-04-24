
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../back_end/notification_controller.dart';
import 'meeting_specifications_page.dart';

class SearchMeeting extends StatefulWidget {
  const SearchMeeting({Key? key}) : super(key: key);

  @override
  _SearchMeetingState createState() => _SearchMeetingState();
}

class _SearchMeetingState extends State<SearchMeeting> {
  final controller = TextEditingController();
  String controlStr = " ";
  bool showPicture = true;

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
    Stream<QuerySnapshot>  _usersStream = FirebaseFirestore.instance.collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid).collection("records")
        .where("search_list" , arrayContains:  controlStr)
        .snapshots();

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Meeting")
      ),
      body: Column(
        children: [
          SizedBox(
            height:  height/20,
          ),
          Container(
            height: 50,
            margin: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
            child: TextField(
                onChanged: (text) {
                  setState(() {
                    showPicture = false;
                    controlStr = text.toLowerCase();
                  });
                },
                controller: controller,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  hintText: 'Search Title, Type and Date',
                  suffixIcon: IconButton(icon: Icon(Icons.search), onPressed: () {
                    setState(() {
                      controlStr = controller.text.toLowerCase();
                    });
                  }),
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50)
                  ),
                ),
                autofocus: false
            ),
          ),
          Divider(
            indent: 10.0,
            endIndent: 10.0,
            thickness: 1,
          ),
          SizedBox(
            height: 10,
          ),
          showPicture ?
          Expanded(
            child: ListView(
              children: [
                Image.asset('images/search.png',
                    scale: 1.4),
              ],
            ),
          ) :
          Container(

            child: Expanded(
              child: Container(
                child:
                StreamBuilder<QuerySnapshot>(
                    stream: _usersStream,
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Something went wrong');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Column(
                          children: [
                            SizedBox(
                              height: height/7 ,
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
                      if(snapshot.data!.size == 0 && !showPicture) {
                        return Column(
                          children: [
                            SizedBox(
                              height: height/7 ,
                            ),
                            Text("No result found")
                          ],
                        );
                      }

                      return ListView(
                        children: snapshot.data!.docs.map((DocumentSnapshot document) {
                          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                          return Container(
                            height: 75,
                            margin: EdgeInsets.only(left: 10,right: 10, bottom: 20),
                            child: Card(
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                color: Colors.blue[100],
                                child: ListTile(
                                  onTap: () {
                                    Navigator.push( context,
                                        MaterialPageRoute(builder: (context) => MeetingSpecifications(data['Record_ID'])));
                                  },
                                  title:
                                  Row(
                                    children: [
                                      Column(
                                        children: [
                                          CircleAvatar(
                                            radius: 30,
                                            backgroundImage: AssetImage(map.values.elementAt(indexOfMap(data['Meeting_type']))),
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 10,),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(data['Title'],
                                            style: GoogleFonts.lato(
                                                textStyle: Theme.of(context).textTheme.headline4,
                                                fontSize: 18,
                                                fontStyle: FontStyle.normal,
                                                color: Colors.black
                                            ),

                                          ),
                                          SizedBox(height: 10,),
                                          Text(data['Date']),
                                        ],
                                      ),
                                      Spacer(),
                                      IconButton(onPressed: () {
                                        _deleteUser(FirebaseAuth.instance.currentUser!.uid, data['Record_ID']);
                                        NotificationController.cancelNotification(data['Notification_ID']);
                                      }, icon: Icon(Icons.delete,
                                      color: Colors.black54,))
                                    ],
                                  ),
                                  subtitle: Row(
                                    children: [
                                      Text(data['Start_Time']),
                                      Text(" to " + TimeOfDay(
                                        hour: data['date_time'].toDate().add(Duration(minutes: data['duration-min'])).hour ,
                                        minute: data['date_time'].toDate().add(Duration(minutes: data['duration-min'])).minute,
                                      ).format(context).toString(),
                                      ),
                                    ],
                                  ),

                                )

                            ),
                          );
                        }).toList(),
                      );
                    }
                ),
              ),
            ),
          )
        ],
      ),
    );
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
