import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'my_navigation_page.dart';
import 'from_scratch.dart';
import 'package:http/http.dart' as http;
import 'package:timezone/timezone.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'next_page.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {

  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  tz.initializeTimeZones();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp( const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  TextEditingController username = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  late AndroidNotificationChannel channel;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  String? tokens = " ";

  @override
  void initState() {
    super.initState();
    requestPermission();
    loadFCM();
    listenFCM();
    getToken();
    
    FirebaseMessaging.instance.subscribeToTopic("event");
    // FirebaseMessaging.instance.unsubscribeFromTopic("event");
  }

  //local notification
  Future _showNotification() async{
    flutterLocalNotificationsPlugin.show(
      454747,
      "test",
      "body of test notification",
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          importance: Importance.high,
          icon: 'ic_launcher',
        ),
      ),
    );
  }
  Future _scheduleNotification(Duration dur) async{
    var location = Location('UTC', [minTime], [0], [TimeZone.UTC]);
    flutterLocalNotificationsPlugin.zonedSchedule(
        1234,
        "test",
        "scheduled notification",
        TZDateTime.now(location).add(dur),
        NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              importance: Importance.high,
              icon: 'ic_launcher',
            )
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime);
    print("scheduled");
  }

  Future _cancelNotification(int id) async{
    await flutterLocalNotificationsPlugin.cancel(id);
    print("canceled");
  }




  void saveToken(String token) async {
    await FirebaseFirestore.instance.collection("userTokens").doc("user1").set({
      'token' : token, }
    );
  }
  void getToken() async {
    await FirebaseMessaging.instance.getToken().then(
            (token) => {
          setState(() {
            tokens = token;
          }),
          saveToken(token!)
        }
    );
  }

  void getTokenFromFirestore() async {

}



  void sendPushMessage(String token, String body, String title) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=AAAAFd08HXU:APA91bEsHKfOJmIafv_d7UD8eGXXsQ0lSWLAMeN5MsECkV0icThDViEuIx72fnKtFlkuUW846ydBidFU57bVK5r6Dve2IeQeGS30zmjj4-DgMVZSw_iHEIUV7rykriUqZqt63iXOllLq',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': body,
              'title': title
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1', //FirebaseAuth.instance.currentUser.uid,
              'status': 'done',
            },
            "to": token,
          },
        ),
      );
    } catch (e) {
      print("error push notification");
    }
  }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true
    );

    if(settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    }
    else if (settings.authorizationStatus == AuthorizationStatus.provisional){
      print('User granted provisional permission');
    }
    else{
      print("user declined or has not accepted permission");
    }
  }


  void listenFCM() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              icon: 'launch_background',
            ),
          ),
        );
      }
    });
  }


  void loadFCM() async {
    if (!kIsWeb) {
      channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title

        importance: Importance.high,
        enableVibration: true,
      );

      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      /// Create an Android Notification Channel.
      ///
      /// We use this channel in the `AndroidManifest.xml` file to override the
      /// default FCM channel to enable heads up notifications.
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      /// Update the iOS foreground notification presentation options to allow
      /// heads up notifications.
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
}




  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:
      // Scaffold(
      //   body: Center(
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         Text("notification test page"),
      //         TextFormField(
      //           controller: username,
      //         ),
      //         TextFormField(
      //           controller: titleController,
      //         ),
      //         TextFormField(
      //           controller: bodyController,
      //         ),
      //         GestureDetector(
      //           onTap: () async {
      //             // _showNotification();
      //             _scheduleNotification(Duration(seconds: 5));
      //             // String name = username.text.trim();
      //             //
      //             // if(name != "") {
      //             //   DocumentSnapshot snap = await FirebaseFirestore.instance
      //             //       .collection("userTokens").doc(name).get();
      //             //   String token = snap['token'];
      //             //   print(token);
      //             //   print(titleController.text);
      //             //   print( bodyController.text);
      //             //   sendPushMessage(token, titleController.text, bodyController.text);
      //             // }
      //           },
      //           child: Container(
      //             height: 40, width: 200, color: Colors.blue,
      //           ),
      //         ),
      //         ElevatedButton(onPressed: () {_cancelNotification(1234);}, child: Icon(Icons.settings))
      //       ],
      //     ),
      //   ),
      // )
      StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator());
            }
            else if(snapshot.hasError){
              return Center(child: Text("something went wrong"),);
            }
            else if(snapshot.hasData){
              return
                // MyNextPage(flutterLocalNotificationsPlugin, channel);
                MyNavigation(FirebaseAuth.instance.currentUser!.uid,);
            }
            else{
              return FromScratchPage();
            }
          }
      ),
    );

  }
}



