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
  final searchList;
  final String userId;
  final String recordId;
  String type;
  CreateDateTime(this.userId, this.recordId, this.type, this.searchList);

  @override
  _CreateDateTimeState createState() => _CreateDateTimeState();

}

class _CreateDateTimeState extends State<CreateDateTime> {
  bool isChecked = false;
  var minController = TextEditingController();
  var hourController = TextEditingController();
  bool _overlapChecked = true;
  bool _dateChecked = true;
  bool _hourChecked = true;
  bool _minChecked = true;
  bool _futureTimeChecked = true;
  TimeOfDay currentTime = TimeOfDay.fromDateTime(DateTime.now().add(const Duration(minutes: 2)));
  DateTime currentDate = DateTime.now();

  Future<void> _selectTime(BuildContext context) async{
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: currentTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.black, // header background color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Colors.black, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
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
      lastDate: DateTime(2030),
      builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: Colors.black, // header background color
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: Colors.black, // button text color
                ),
              ),
            ),
            child: child!,
          );
        },
    );
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
                MaterialPageRoute(builder: (context) => NavigationScreen()),
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
                                labelStyle: _hourChecked ? TextStyle(color: Colors.grey) : TextStyle(color: Colors.red),
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
                              labelStyle: _minChecked ? TextStyle(color: Colors.grey) : TextStyle(color: Colors.red),
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

          _futureTimeChecked ?
          Container() :
          Center(
            child: Container(
              width: width*8/9,
              child: Text('The date and time picked should be in the future!',
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
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Checkbox(
              //     activeColor: Colors.black,
              //     value: isChecked,
              //     onChanged: (bool? value) {
              //       setState(() {
              //         isChecked = value!;
              //       });
              //     }
              // ),
              // Text(
              //   "Recurring Meeting",
              //   style: GoogleFonts.lato(
              //       textStyle: Theme.of(context).textTheme.headline4,
              //       fontSize: 19,
              //       fontWeight: FontWeight.w700,
              //       fontStyle: FontStyle.normal,
              //       color: Colors.black87
              //   ),
              // ),
              // Spacer(),
              Container(
                  margin: EdgeInsets.only(right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 80,
                        height: 35,
                        child: ElevatedButton(
                          onPressed: () async {
                          int min = 0;
                          int hour = 0;
                          var recordStartDateTime = DateTime(currentDate.year, currentDate.month, currentDate.day, currentTime.hour,
                              currentTime.minute, 0, 0, 0);

                          if(hourController.text.isNotEmpty) { // checking the hour text field
                            hour = int.parse(hourController.text);
                            setState(() { _hourChecked = true;});
                          }
                          else {
                            setState(() {_hourChecked = false;});
                          }

                          if(minController.text.isNotEmpty  // checking the minute text field
                              && (int.parse(minController.text) > 0 || hour > 0)) //meeting duration should be at least 1 min
                          {
                            min = int.parse(minController.text);
                            setState(() {_minChecked = true; });
                          }
                          else{
                            setState(() {_minChecked = false; });
                          }


                          if(_hourChecked && _minChecked) { //Check to see that the duration does not extend into the next day.
                            if(recordStartDateTime.add(Duration(hours: hour, minutes: min)).day > currentDate.day){
                              setState(() {_dateChecked = false;});
                            }
                            else{
                              setState(() {_dateChecked = true;});
                            }
                          }

                          if(_dateChecked && _minChecked && _hourChecked)
                          {
                            await FirebaseFirestore.instance.collection('users')
                                .doc(widget.userId).collection("records")
                                .where("Date", isEqualTo: DateFormat.yMMMMd('en_US').format(currentDate).toString())
                                .get().then((QuerySnapshot querySnapshot) {
                              if(querySnapshot.docs.isEmpty){
                                print("no overlap");
                                setState(() {_overlapChecked = true; });
                              }
                              for (var doc in querySnapshot.docs) {
                                if(doc['Record_ID'] == widget.recordId)
                                  continue;
                                DateTime docStartDateTime = doc["date_time"].toDate();
                                final duration = doc["Duration"].split(' ');
                                print("diration[0] is ${duration[0]} and  diration[3] is ${duration[3]}");
                                var docEndDateTime = docStartDateTime.add(
                                    Duration( hours: int.parse(duration[0]),minutes: int.parse(duration[3])))
                                    .subtract(const Duration(seconds: 1));  //to able start a new meeting right after existing one
                                var recordEndDateTime = recordStartDateTime.add(Duration(hours: hour, minutes: min))
                                .subtract(const Duration(seconds: 1)); //to able start a new meeting right after existing one

                                if(recordEndDateTime.isBefore(docStartDateTime) ||
                                    recordStartDateTime.isAfter(docEndDateTime))
                                {
                                  print("no overlap");
                                  if(!_overlapChecked)
                                  {
                                    setState(() {_overlapChecked = true;});
                                  }
                                }
                                else
                                {
                                  print("an overlap found");
                                  setState(() {_overlapChecked = false;});
                                  break;
                                }
                              }
                            });
                          }

                          if(recordStartDateTime.compareTo(DateTime.now()) <= 0) { //check if the selected time is in the future
                            setState(() {_futureTimeChecked = false;});
                          }
                          else{
                            setState(() { _futureTimeChecked = true; });
                          }


                          if(_overlapChecked && _dateChecked && _hourChecked && _minChecked && _futureTimeChecked)
                          {

                            final dateTimeList = searchElementGenerator(
                                DateFormat.yMMMMd('en_US').format(currentDate).toString() +
                                " " + currentTime.format(context).toString()
                            );
                            final durationList = searchElementGenerator(
                              hour.toString() + " hour " + min.toString() + " minute",
                            );

                            _addUser(widget.userId, widget.recordId,
                                DateFormat.yMMMMd('en_US').format(currentDate).toString(),
                                currentTime.format(context).toString(),
                                hour.toString() + " hour and " + min.toString() + " minute",
                                hour*60 + min,
                                isChecked.toString(), recordStartDateTime);

                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>
                                  MeetingDetailsPage(widget.userId,widget.recordId,widget.type, recordStartDateTime,
                                      dateTimeList + durationList + widget.searchList)),
                            );
                          }
                        },
                          child: Text("NEXT"),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black, // Background color
                            onPrimary: Colors.white, // Text Color (Foreground color)
                          ),
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
      String sTime, String duration,int durMin, String isChecked, DateTime recordDT) {
    CollectionReference users = FirebaseFirestore.instance.collection('users')
        .doc(userID).collection("records");

    return users
        .doc(recordID)
        .update({
      'Date': date,
      'Start_Time': sTime,
      'Duration' : duration,
      'duration-min' : durMin,
      'Recurring_Meeting' : isChecked,
      'date_time' : Timestamp.fromDate(recordDT),
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





