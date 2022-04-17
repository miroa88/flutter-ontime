//picking date
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:intl/intl.dart';
import 'create_details.dart';

import '/front_end/navigation_page.dart';

class CreateDateTime extends StatefulWidget {
  final String userId;
  final String recordId;
  String type;
  CreateDateTime(this.userId, this.recordId, this.type);

  @override
  _CreateDateTimeState createState() => _CreateDateTimeState();

}

class _CreateDateTimeState extends State<CreateDateTime> {
  bool isChecked = false;
  var minController = TextEditingController();
  var hourController = TextEditingController();
  bool _overlapChecked = true;
  bool _dateChecked = true;
  bool _timeChecked = true;
  bool _granted = false;
  TimeOfDay currentTime = TimeOfDay.now();
  DateTime currentDate = DateTime.now();

  Future<void> _selectTime(BuildContext context) async{
    final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: currentTime);
    if (pickedTime != null && pickedTime != currentTime)
      setState(() {
        currentTime = pickedTime;
      });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2030));
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
        print(currentDate);
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
                MaterialPageRoute(builder: (context) => NavigationScreen(widget.userId)),
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
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
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
                        fontSize: 25.0
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
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
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
                        fontSize: 25.0
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
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                      color: Colors.black
                  ),),
                Spacer(),
                Column(
                  children: [
                    // Text("hour"),
                    Container(
                        height:50,
                        width: 58,
                        child: TextField(
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                            ],
                            controller: hourController,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 23.0),
                            decoration: InputDecoration(
                                labelText: " hour",
                                labelStyle: _timeChecked ? TextStyle(color: Colors.grey) : TextStyle(color: Colors.red),
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
                    // Text("Min"),
                    Container(
                        height:50,
                        width: 58,
                        child: TextField(
                            controller: minController,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                            ],
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 23.0),
                            decoration: InputDecoration(
                              labelText: " min",
                              labelStyle: _timeChecked ? TextStyle(color: Colors.grey) : TextStyle(color: Colors.red),
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
          _dateChecked ?
          Container() :
          Center(
            child: Container(
              width: width*8/9,
              child: Text('The meeting should begin and end on the same day!',
                style: GoogleFonts.lato(
                    textStyle: Theme.of(context).textTheme.headline4,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.red
                ),),
            ),
          ),
          _overlapChecked ?
          Container() :
          Center(
            child: Container(
              width: width*8/9,
              child: Text('The date and time selected will overlap with an existing record!',
                style: GoogleFonts.lato(
                    textStyle: Theme.of(context).textTheme.headline4,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.red
                ),),
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
                    fontStyle: FontStyle.normal,
                    color: Colors.black87
                ),
              ),
              Spacer(),
              Container(
                  margin: EdgeInsets.only(right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(onPressed: () async {
                        int min = 0;
                        int hour = 0;
                        var recordStartDateTime = DateTime(currentDate.year, currentDate.month, currentDate.day, currentTime.hour,
                            currentTime.minute, 0, 0, 0);
                        if(hourController.text != ""){
                          hour = int.parse(hourController.text);
                        }
                        if(minController.text != ""){
                          min = int.parse(minController.text);
                        }
                        if(min == 0 && hour == 0)
                        {
                          setState(() {
                            _timeChecked = false;
                            _granted = false;
                          });
                        }
                        else{
                          setState(() {
                            _timeChecked = true;
                          });
                        }
                        if(recordStartDateTime.add(Duration(hours: hour, minutes: min)).day > currentDate.day){
                          setState(() {
                            _dateChecked = false;
                            _granted = false;
                          });
                        }
                        else{
                          setState(() {
                            _dateChecked = true;
                          });
                        }
                        if(_dateChecked && _timeChecked)
                        {
                          await FirebaseFirestore.instance.collection('users')
                              .doc(widget.userId).collection("records")
                              .where("Date", isEqualTo: DateFormat.yMMMMd('en_US').format(currentDate).toString())
                              .get().then((QuerySnapshot querySnapshot) {
                            if(querySnapshot.docs.isEmpty){
                              print("no overlap");
                              setState(() {
                                _overlapChecked = true;
                              });
                            }
                            for (var doc in querySnapshot.docs) {
                              if(doc['Record_ID'] == widget.recordId)
                                continue;
                              DateTime docStartDateTime = doc["date_time"].toDate();
                              final duration = doc["Duration"].split(':');
                              if(duration[0] == "")
                                duration[0] = '0';
                              if(duration[1] == "")
                                duration[1] = '0';
                              print(duration[0]);
                              var docEndDateTime = docStartDateTime.add(
                                  Duration( hours: int.parse(duration[0]),minutes: int.parse(duration[1]))
                              );
                              var recordEndDateTime = recordStartDateTime.add(Duration(hours: hour, minutes: min));
                              if(recordEndDateTime.isBefore(docStartDateTime) ||
                                  recordStartDateTime.isAfter(docEndDateTime))
                              {
                                print("no overlap");
                                if(!_overlapChecked)
                                {
                                  setState(() {
                                    _overlapChecked = true;
                                  });
                                }
                              }
                              else
                              {
                                print("overlap");
                                setState(() {
                                  _overlapChecked = false;
                                });
                                _granted = false;
                                break;
                              }
                            }
                          });
                        }
                        if(_overlapChecked && _dateChecked && _timeChecked)
                          _granted = true;
                        if(_granted)
                        {
                          _addUser(widget.userId, widget.recordId,
                              DateFormat.yMMMMd('en_US').format(currentDate).toString(),
                              currentTime.format(context).toString(),
                              // currentTime.hour.toString() + ":" + currentTime.minute.toString(),
                              (hourController.text == "" ? '0' : hourController.text ) + ":" +
                                  (minController.text == "" ? '0' : minController.text ),
                              isChecked.toString(), recordStartDateTime);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MeetingDetailsPage(widget.userId,widget.recordId,widget.type)),

                          );
                        }
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
      String sTime, String duration, String isChecked, DateTime recordDT) {
    CollectionReference users = FirebaseFirestore.instance.collection('users')
        .doc(userID).collection("records");

    return users
        .doc(recordID)
        .update({
      'Date': date,
      'Start_Time': sTime,
      'Duration' : duration,
      'Recurring_Meeting' : isChecked,
      'date_time' : Timestamp.fromDate(recordDT)
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





