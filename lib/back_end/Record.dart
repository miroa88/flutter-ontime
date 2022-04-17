// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
// class Record {
//   String recordID;
//   late DateTime date ;
//   late Duration duration;
//   String link;
//   String address;
//   String type;
//   String pass;
//   String phone;
//   late bool isRecurring;
//   late DateTime startTime;
//   String title;
//   late DateTime endTime;
//
//   Record(this.recordID,String date, this.address, this.pass,
//       String duration, this.title, this.type, String isRecurring, this.link,
//       this.phone, String startTime)
//   {
//     this.date = DateFormat('MMMM d, y', 'en_US').parse(date);
//     this.duration = Duration(hours: int.parse(duration.split(':')[0]),minutes: int.parse(duration.split(':')[1]), seconds: 0);
//     this.startTime = DateTime(this.date.year, this.date.month, this.date.day,
//         int.parse(startTime.split(':')[0]), int.parse(startTime.split(':')[1]));
//     endTime = this.startTime.add(this.duration);
//     if(isRecurring == "false") {
//       this.isRecurring = false;
//     }
//     else {
//       this.isRecurring = true;
//     }
//   }
// }
