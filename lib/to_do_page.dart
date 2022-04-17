//to do
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:intl/intl.dart';

class ToDoPage extends StatefulWidget {
  const ToDoPage({Key? key}) : super(key: key);

  @override
  _ToDoPageState createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {

  late DateTime _selectedDate;
  @override
  void initState() {
    super.initState();
    _resetSelectedDate();
  }
  void _resetSelectedDate() {
    _selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    List<String> items = ["miro"];
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid).collection("records")
        .where('Date', isEqualTo: DateFormat.yMMMMd('en_US').format(_selectedDate).toString())
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule'),
      ),

      body: Column(
        children: [
          Expanded(
            flex: 25,
            child: Container(
              margin: EdgeInsets.only(right: 20),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CalendarTimeline(
                      showYears: false,
                      initialDate: _selectedDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(Duration(days: 1000)),
                      onDateSelected: (date) {
                        setState(() {
                          print("");
                          _selectedDate = date!;
                        });


                        print(_selectedDate);
                      },
                      leftMargin: 20,
                      monthColor: Colors.black87,
                      dayColor: Colors.black,
                      dayNameColor: Colors.blue,
                      activeDayColor: Colors.white,
                      activeBackgroundDayColor: Colors.blue,
                      dotsColor: Colors.white,
                      selectableDayPredicate: (date) => date.day != 23,
                      locale: 'en_ISO',
                    ),
                    // SizedBox(height: 20),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 16),
                    //   child: TextButton(
                    //     style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.teal[200])),
                    //     child: Text('RESET', style: TextStyle(color: Color(0xFF333A47))),
                    //     onPressed: () => setState(() => _resetSelectedDate()),
                    //   ),
                    // ),
                    // SizedBox(height: 20),
                    // Center(child: Text('Selected date is $_selectedDate', style: TextStyle(color: Colors.white)))
                  ],
                ),
              ),
            ),
          ),
          Expanded(
              flex: 75,
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
              
              // ListView(
              //   children: const <Widget>[
              //     Card(child: ListTile(title: Text('One-line ListTile'))),
              //     Card(
              //       child: ListTile(
              //         leading: FlutterLogo(),
              //         title: Text('One-line with leading widget'),
              //       ),
              //     ),
              //     Card(
              //       child: ListTile(
              //         title: Text('One-line with trailing widget'),
              //         trailing: Icon(Icons.more_vert),
              //       ),
              //     ),
              //     Card(
              //       child: ListTile(
              //         leading: FlutterLogo(),
              //         title: Text('One-line with both widgets'),
              //         trailing: Icon(Icons.more_vert),
              //       ),
              //     ),
              //     Card(
              //       child: ListTile(
              //         title: Text('One-line dense ListTile'),
              //         dense: true,
              //       ),
              //     ),
              //     Card(
              //       child: ListTile(
              //         leading: FlutterLogo(size: 56.0),
              //         title: Text('Two-line ListTile'),
              //         subtitle: Text('Here is a second line'),
              //         trailing: Icon(Icons.more_vert),
              //       ),
              //     ),
              //     Card(
              //       child: ListTile(
              //         leading: FlutterLogo(size: 72.0),
              //         title: Text('Three-line ListTile'),
              //         subtitle: Text(
              //             'A sufficiently long subtitle warrants three lines.'
              //         ),
              //         trailing: Icon(Icons.more_vert),
              //         isThreeLine: true,
              //       ),
              //     ),
              //   ],
              // )

          )
        ],
      ),
    );
  }
}
