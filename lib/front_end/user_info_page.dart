//log out page
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practice_app/back_end/notification_controller.dart';
import 'meeting_specifications_page.dart';
import 'register_login/login_page.dart';
import '/back_end/notification_controller.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({Key? key}) : super(key: key);

  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {


  @override
  void initState() {
    super.initState();

    NotificationController.initLocalNotification(selectNotification);
  }

  void selectNotification(String? payload) async {
    if (payload != null) {
      print('notification payload: $payload');
    }
    await Navigator.push(
      context,
      MaterialPageRoute<void>(builder: (context) => MeetingSpecifications(payload)),
    );
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: Column(
        children: [
          Card(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                TextButton(
                    onPressed: () {
                    },
                    child: Row(
                      children: [
                        Icon( // <-- Icon
                          Icons.person,
                          size: 24.0,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text('Account',
                          style: TextStyle(
                              color: Colors.black
                          ),
                        ),
                      ],
                    )
                ),
                TextButton(
                    onPressed: () {
                      FirebaseFirestore.instance.collection("test").get().asStream().listen((event) {
                        event.docs.forEach((element) {print(element.data());});
                      });
                    },
                    child: Row(
                      children: [
                        Icon( // <-- Icon
                          Icons.help_outline_outlined,
                          size: 24.0,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text('Help',
                          style: TextStyle(
                              color: Colors.black
                          ),
                        ),
                      ],
                    )
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          TextButton(
              onPressed: () async{
                await FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                      (Route<dynamic> route) => false,
                );
              },
              child: Row(
                children: [
                  Icon( // <-- Icon
                    Icons.logout,
                    size: 24.0,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text('Log Out',
                    style: TextStyle(
                        color: Colors.black
                    ),
                  ),
                ],
              )
          ),
          SizedBox(height: _height/2.5,),
          Image.asset('images/icon.png',
              scale: 1.3),
        ],
      ),
    );
  }
}
