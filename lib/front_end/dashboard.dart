// //dashboard
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
//
// import 'package:uuid/uuid.dart';
//
//
// class Dashboard extends StatefulWidget {
//   final String userId;
//   // MyListView({Key? key, required this.documentId}) : super(key: key);
//   Dashboard(this.userId);
//
//   @override
//   _DashboardState createState() => _DashboardState();
// }
//
// class _DashboardState extends State<Dashboard> {
//   // String recordId = const Uuid().v4();
//   final nameController = TextEditingController();
//   final phoneController = TextEditingController();
//   final typeController = TextEditingController();
//   final linkController = TextEditingController();
//
//   late AndroidNotificationChannel channel;
//   late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
//
//   @override
//   void initState() {
//     super.initState();
//     initLocalNotification();
//   }
//
//   void initLocalNotification() async {
//     var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//     FlutterLocalNotificationsPlugin().initialize(const InitializationSettings(
//       android: AndroidInitializationSettings('ontime1'),
//       iOS: IOSInitializationSettings(),
//     ));
//
//     channel = const AndroidNotificationChannel(
//       'high_importance_channel', // id
//       'High Importance Notifications', // title
//
//       importance: Importance.high,
//       enableVibration: true,
//     );
//
//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//         AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(channel);
//   }
//
//   Future _cancelNotification(int id) async{
//     await flutterLocalNotificationsPlugin.cancel(id);
//     print("canceled");
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('users')
//         .doc(FirebaseAuth.instance.currentUser!.uid).collection("records").orderBy('date_time').snapshots();
//     return Scaffold(
//       appBar: AppBar(
//         title: Row(
//           children: [
//             Row(
//               children: [
//                 const Text('Meetings'),
//                 // IconButton(onPressed:(){
//                 //   showNotification();
//                 // }, icon: Icon(Icons.javascript))
//               ],
//             ),
//           ],
//         ),
//       ),
//       body:Container(
//         child: StreamBuilder<QuerySnapshot>(
//             stream: _usersStream,
//             builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//               if (snapshot.hasError) {
//                 return Text('Something went wrong');
//               }
//
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Text("Loading");
//               }
//
//               return ListView(
//                 children: snapshot.data!.docs.map((DocumentSnapshot document) {
//                   Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
//                   return ListTile(
//                     onTap: () {},
//                     title: Row(
//                       children: [
//                         CircleAvatar(
//                           backgroundImage: AssetImage("images/zoom.png"),
//                         ),
//                         SizedBox(width: 5,),
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(data['Title']),
//                             Text(data['Date']),
//                             Row(
//                               children: [
//                                 Text(data['Start_Time']),
//                                 Text(" Duration: ${data['Duration']}"),
//                               ],
//                             )
//                           ],
//                         ),
//                         Spacer(),
//                         IconButton(onPressed: () {
//                           _deleteUser(widget.userId, data['Record_ID']);
//                         }, icon: Icon(Icons.close))
//                       ],
//                     ),
//                     // subtitle: Text(data['Date']),
//                   );
//                 }).toList(),
//               );
//             }
//         ),
//       ),
//
//
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.blue,
//         onPressed: () {
//           var recordId = Uuid().v4();
//           _addUser(widget.userId, recordId);
//           Navigator.pushAndRemoveUntil(
//             context,
//             MaterialPageRoute(builder: (context) => CreateMeetings(widget.userId, recordId)),
//                 (Route<dynamic> route) => false,
//           );
//         },
//         child: const Icon(Icons.add,
//         ),
//       ),
//     );
//   }
//
//
//   Future<void> _addUser(String userID, String recordID) {
//     CollectionReference users = FirebaseFirestore.instance.collection('users')
//         .doc(userID).collection("records");
//
//     return users
//         .doc(recordID)
//         .set({
//       'Record_ID': recordID,
//       'Title' : "",
//       'Date' : "",
//     })
//         .then((value) => print("Title Added"))
//         .catchError((error) => print("Failed to add tile: $error"));
//   }
//   Future<void> _deleteUser(String userID, String recordID) {
//     CollectionReference users = FirebaseFirestore.instance.collection('users')
//         .doc(userID).collection("records");
//     return users
//         .doc(recordID)
//         .delete()
//         .then((value) => print("User Deleted"))
//         .catchError((error) => print("Failed to delete user: $error"));
//   }
// }
