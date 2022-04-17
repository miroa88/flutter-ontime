// //log out page
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
//
//
// class UserInfoPage extends StatefulWidget {
//   const UserInfoPage({Key? key}) : super(key: key);
//
//   @override
//   _UserInfoPageState createState() => _UserInfoPageState();
// }
//
// class _UserInfoPageState extends State<UserInfoPage> {
//
//   @override
//
//   Widget build(BuildContext context) {
//     double _width = MediaQuery.of(context).size.width;
//     double _height = MediaQuery.of(context).size.height;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('User Profile'),
//       ),
//       body: Column(
//         children: [
//           Card(
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: 10,
//                 ),
//                 TextButton(
//                     onPressed: () {},
//                     child: Row(
//                       children: [
//                         Icon( // <-- Icon
//                           Icons.person,
//                           size: 24.0,
//                           color: Colors.black,
//                         ),
//                         SizedBox(
//                           width: 5,
//                         ),
//                         Text('Account',
//                           style: TextStyle(
//                               color: Colors.black
//                           ),
//                         ),
//                       ],
//                     )
//                 ),
//                 TextButton(
//                     onPressed: () {
//                       FirebaseFirestore.instance.collection("test").get().asStream().listen((event) {
//                         event.docs.forEach((element) {print(element.data());});
//                       });
//
//                     },
//
//                     child: Row(
//                       children: [
//                         Icon( // <-- Icon
//                           Icons.help_outline_outlined,
//                           size: 24.0,
//                           color: Colors.black,
//                         ),
//                         SizedBox(
//                           width: 5,
//                         ),
//                         Text('Help',
//                           style: TextStyle(
//                               color: Colors.black
//                           ),
//                         ),
//                       ],
//                     )
//                 ),
//
//                 SizedBox(
//                   height: 40,
//                 ),
//               ],
//             ),
//
//           ),
//           TextButton(
//               onPressed: () async{
//                 await FirebaseAuth.instance.signOut();
//                 Navigator.pushAndRemoveUntil(
//                   context,
//                   MaterialPageRoute(builder: (context) => FromScratchPage()),
//                       (Route<dynamic> route) => false,
//                 );
//               },
//               child: Row(
//                 children: [
//                   Icon( // <-- Icon
//                     Icons.logout,
//                     size: 24.0,
//                     color: Colors.black,
//                   ),
//                   SizedBox(
//                     width: 5,
//                   ),
//                   Text('Log Out',
//                     style: TextStyle(
//                         color: Colors.black
//                     ),
//                   ),
//                 ],
//               )
//           ),
//         ],
//       ),
//     );
//   }
//
//
// }
