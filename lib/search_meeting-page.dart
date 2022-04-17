import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class SearchMeeting extends StatefulWidget {
  const SearchMeeting({Key? key}) : super(key: key);

  @override
  _SearchMeetingState createState() => _SearchMeetingState();
}

class _SearchMeetingState extends State<SearchMeeting> {
  final controller = TextEditingController();
  String variable = "Title";
  String controlStr = "";
  @override

  Widget build(BuildContext context) {
    Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid).collection("records")
        .where(variable, isEqualTo: controlStr)
        .snapshots();

    List<String> types = [
      'In person',
      'Zoom',
      'Google Meet',
      'Phone call'
    ];

    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Meeting")
      ),
      body: Column(

        children: [
          SizedBox(
            height: width/10,
          ),
          Center(
            child: Container(
              width: width - 20,
              height: (width - 20) / 6,
              child: TextField(
                controller: controller,
                  decoration: InputDecoration(
                      labelText: 'Search Meeting Title and Type',
                    suffixIcon: IconButton(icon: Icon(Icons.search), onPressed: () {
                      if(types.contains(controller.text))
                        {
                          setState(() {
                            variable = 'Meeting_type';
                            controlStr = controller.text;
                          });
                        }
                      else{
                        setState(() {
                          variable = 'Title';
                          controlStr = controller.text;
                        });
                      }
                    },

                    )

                  ),
                  autofocus: false

              ),
            ),
          ),
          SizedBox(
            height: width/10,
          ),
          SizedBox(
            height: width/20,
          ),
          Container(
            child: Expanded(
              child: Container(
                child: StreamBuilder<QuerySnapshot>(
                    stream: _usersStream,
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Something went wrong');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text("Loading");
                      }

                      return ListView(
                        children: snapshot.data!.docs.map((DocumentSnapshot document) {
                          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                          return ListTile(
                            onTap: () {},
                            title: Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: AssetImage("images/zoom.png"),
                                ),
                                SizedBox(width: 5,),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(data['Title']),
                                    Text(data['Date']),
                                    Row(
                                      children: [
                                        Text(data['Start_Time']),
                                        Text(" Duration: ${data['Duration']}"),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                            // subtitle: Text(data['Date']),
                          );
                        }).toList(),
                      );
                    }
                ),
              ),
            ),
          )

        ],
      )

    );
  }
}
