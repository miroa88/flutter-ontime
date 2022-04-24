import 'Record.dart';

class OnTimeUser {
  final String userId;
  List<Record> entries = <Record>[];
  OnTimeUser(this.userId);

  void addRecord(Record newRecord ){
    entries.add(newRecord);
  }
}