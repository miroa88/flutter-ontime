import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Record.dart';

class OnTimeUser {
  final String userId;
  List<Record> entries = <Record>[];
  static Map<String, Record> records = {};
  OnTimeUser(this.userId);
  
  void addRecord(Record newRecord ){
    entries.add(newRecord);
  }
  
  static Future initUsers() async {
    records.clear();
    FirebaseFirestore.instance.collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid).collection("records").orderBy("date_time") //, descending: true
        .get().then((value) {
       for (var documentSnapshot in value.docs) {
         records[documentSnapshot.get('Record_ID')] = Record(
             recordID: documentSnapshot.get('Record_ID'),
             date: documentSnapshot.get('Date'),
             duration: documentSnapshot.get('Duration'),
             link: documentSnapshot.get('Meeting_Link'),
             address: documentSnapshot.get('Meeting_address'),
             type: documentSnapshot.get('Meeting_type'),
             pass: documentSnapshot.get('Password'),
             phone: documentSnapshot.get('Phone_number'),
             isRecurring: documentSnapshot.get('Recurring_Meeting'),
             startTime: documentSnapshot.get('Start_Time'),
             title: documentSnapshot.get('Title')
         );
       }
    });
  }

  static deleteRecord(String recordId) {
    if(records[recordId]!= null) {
      records.remove(recordId);
    }
  }

  static addNewRecord(Record record) {
    records[record.recordID] = record;
  }

}