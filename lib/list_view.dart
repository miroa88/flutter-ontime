//dashboard
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:practice_app/list_adder.dart';
import 'contact_info_detail.dart';
import 'event_information.dart';
import 'meeting_date.dart';
import 'creatieg_ meetings.dart';
import 'package:uuid/uuid.dart';
import 'user_events.dart';

class MyListView extends StatefulWidget {
  final String userId;
  // MyListView({Key? key, required this.documentId}) : super(key: key);
  MyListView(this.userId);

  @override
  _MyListViewState createState() => _MyListViewState();
}

class _MyListViewState extends State<MyListView> {
  // String recordId = const Uuid().v4();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final typeController = TextEditingController();
  final linkController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid).collection("records").snapshots();
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Row(
              children: [
                const Text('Meetings'),
    //             IconButton(onPressed:(){
    //               final user = UserEvents(FirebaseAuth.instance.currentUser!.uid);
    //               user.addRecord(Record('3333333333','March 30, 2022', 'Cordero',' this.pass',
    // '1:33', "hello miro", "zoom", 'false', 'this.link',
    // '8785553', '12:45'));
    //               print(user.entries.first.isRecurring);
    //               print(user.entries.first.startTime);
    //               print(user.entries.first.duration);
    //               print(user.entries.first.endTime);
    //
    //             }, icon: Icon(Icons.javascript))
              ],
            ),
          ],
        ),
      ),
       body:Container(
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
                           backgroundImage: NetworkImage('https://cdn.freelogovectors.net/wp-content/uploads/2020/10/zoom-icon-logo-768x767.png'),
                           //https://linkgatesconsult.com/wp-content/uploads/2020/06/logo-person-user-person-icon-800x675.jpg
                         ),
                         SizedBox(width: 5,),
                         Column(
                           mainAxisAlignment: MainAxisAlignment.start,
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text(data['Title']),
                             Text(data['Date']),
                           ],
                         ),
                         Spacer(),
                         IconButton(onPressed: () {
                           _deleteUser(widget.userId, data['Record_ID']);
                         }, icon: Icon(Icons.close))
                       ],
                     ),
                     // subtitle: Text(data['Date']),
                   );
                 }).toList(),
               );
             }
         ),
       ),


      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          var revordId = Uuid().v4();
          _addUser(widget.userId, revordId);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => CreateMetings(widget.userId, revordId)),
                (Route<dynamic> route) => false,
          );
        },
        child: const Icon(Icons.add,
        ),
      ),
    );
  }


  Future<void> _addUser(String userID, String recordID) {
    CollectionReference users = FirebaseFirestore.instance.collection('users')
        .doc(userID).collection("records");

    return users
        .doc(recordID)
        .set({
      'Record_ID': recordID,
      'Title' : "",
      'Date' : "",
    })
        .then((value) => print("Title Added"))
        .catchError((error) => print("Failed to add tile: $error"));
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
