import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Record {
  String recordID;
  String date;
  String duration;
  String link;
  String address;
  String type;
  String pass;
  String phone;
  String isRecurring;
  String startTime;
  String title;

  Record({this.recordID = "",this.type = "",this.title = "", this.date = "",
    this.startTime = "",this.duration = "", this.isRecurring = "", this.address = "",
    this.pass = "",this.link = "",this.phone = ""});

}
