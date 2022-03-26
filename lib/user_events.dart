
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'event_information.dart';
import 'package:deeply/deeply.dart';

class UserEvents {
  final String userId;
  List<Record> entries = <Record>[];
  UserEvents(this.userId);

  void addRecord(Record newRecord ){
    entries.add(newRecord);
    }
}