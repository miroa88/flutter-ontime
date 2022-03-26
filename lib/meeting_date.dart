//picking date
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'meeting_type_page.dart';
import 'my_navigation_page.dart';
import 'package:intl/intl.dart';

class MeetingDatePage extends StatefulWidget {
  final String userId;
  final String recordId;
  MeetingDatePage(this.userId, this.recordId);

  @override
  _MeetingDatePageState createState() => _MeetingDatePageState();

}

class _MeetingDatePageState extends State<MeetingDatePage> {
  bool isChecked = false;
  var minController = TextEditingController();
  var hourController = TextEditingController();

  TimeOfDay currentTime = TimeOfDay.now();
  Future<Null> _selectTime(BuildContext context) async{
    final TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: currentTime);
    if (pickedTime != null && pickedTime != currentTime)
      setState(() {
        currentTime = pickedTime;
      });
  }

  DateTime currentDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2030));
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
      });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery
        .of(context)
        .size
        .height;
    double width = MediaQuery
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
      body:ListView(
          children: [
            SizedBox(
              height: 30,
            ),
            ListTile(
              title: Text('Meeting Date',
                style: GoogleFonts.lato(
                    textStyle: Theme.of(context).textTheme.headline4,
                    fontSize: 23,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.italic,
                    color: Colors.black
                    ),
                ),
              trailing: Icon(Icons.date_range,
                color: Colors.blue,),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Choose a date for your meeting',
                      style: TextStyle(
                          fontSize: 18.0
                      )),
                  Text(DateFormat.yMMMMd('en_US').format(currentDate)
                      .toString(),
                  style: TextStyle(
                      fontSize: 30.0
                  ))
                ],
              ),
              onTap: () {
                _selectDate(context);
              },
            ),
            SizedBox(
              height: 15,
            ),
            ListTile(
              title: Text('Meeting Start Time',
                style: GoogleFonts.lato(
                    textStyle: Theme.of(context).textTheme.headline4,
                    fontSize: 23,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.italic,
                    color: Colors.black
                ),
              ),
              trailing: Icon(Icons.alarm,
                color: Colors.blue,
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Choose a start time for your meeting',
                      style: TextStyle(
                          fontSize: 18.0
                      )
                  ),
                  Text(currentTime.format(context).toString(),
                    style: TextStyle(
                        fontSize: 30.0
                    )
                  )
                ],
              ),
              onTap: () {
                _selectTime(context);
              },
            ),
            ListTile(
              title: Row(
                children: [
                  Text('Meeting Duration',
                    style: GoogleFonts.lato(
                        textStyle: Theme.of(context).textTheme.headline4,
                        fontSize: 23,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.italic,
                        color: Colors.black
                    ),),
                  Spacer(),
                  Column(
                    children: [
                      Text("hour"),
                      Container(
                          height:50,
                          width: 58,
                          child: TextField(
                            controller: hourController,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 25.0),
                              decoration: InputDecoration(
                                   contentPadding: EdgeInsets.zero,
                                  border: OutlineInputBorder()
                              )
                          )
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Column(
                    children: [
                      Text("min"),
                      Container(
                          height:50,
                          width: 58,
                          child: TextField(
                            controller: minController,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 25.0),
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: OutlineInputBorder(),
                              )
                          )
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                    activeColor: Colors.blue,
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                      });
                    }
                ),
                Text(
                  "Recurring Meeting",
                  style: GoogleFonts.lato(
                      textStyle: Theme.of(context).textTheme.headline4,
                      fontSize: 19,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.italic,
                      color: Colors.black87
                  ),
                ),
                Spacer(),
                Container(
                    margin: EdgeInsets.only(right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(onPressed: () {
                          print("date: " + currentDate.toString() + " time: " + currentTime.toString());
                          _addUser(widget.userId, widget.recordId,
                              DateFormat.yMMMMd('en_US').format(currentDate).toString(),
                              currentTime.format(context).toString(),
                              // currentTime.hour.toString() + ":" + currentTime.minute.toString(),
                              hourController.text+":"+minController.text,
                              isChecked.toString());
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MeetingTypePage(widget.userId,widget.recordId)),
                          );
                        },
                          child: Text("NEXT"),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue, // Background color
                            onPrimary: Colors.white, // Text Color (Foreground color)
                          ),
                        ),
                      ],
                    )
                )
              ],
            ),
          ],
        ),
    );
  }

  Future<void> _addUser(String userID, String recordID, String date,
      String sTime, String duration, String isChecked) {
    CollectionReference users = FirebaseFirestore.instance.collection('users')
        .doc(userID).collection("records");

    return users
        .doc(recordID)
        .update({
          'Date': date,
          'Start_Time': sTime,
          'Duration' : duration,
          'Recurring_Meeting' : isChecked
    })
        .then((value) => print("Date Added"))
        .catchError((error) => print("Failed to add date: $error"));
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





