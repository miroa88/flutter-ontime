import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'utils.dart';

class NotificationController {
  static final _notification = FlutterLocalNotificationsPlugin();

  static Future initLocalNotification(void Function(String? payload) selectNotification) async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('ontime1');
    final IOSInitializationSettings initializationSettingsIOS =
    IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    final MacOSInitializationSettings initializationSettingsMacOS =
    MacOSInitializationSettings();
    final InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS,
        macOS: initializationSettingsMacOS);
    await _notification.initialize(initializationSettings,
        onSelectNotification: selectNotification
    );
  }

  static void onDidReceiveLocalNotification(int id, String? title, String? body, String? payload) async {}

  static Future scheduleNotification(DateTime dt, int id, String title, String body, String payload) async{
    print("scheduleNotification called");
    final timePicPath = await Utils.downloadFile("https://firebasestorage.googleapis.com/v0/b/cpp-ontime-flutter.appspot.com/o/time.png?alt=media&token=dc449c24-5ecf-42ce-af42-282f4c3d7a01", "time");
    final iconPath = await Utils.downloadFile("https://firebasestorage.googleapis.com/v0/b/cpp-ontime-flutter.appspot.com/o/logo.png?alt=media&token=e4d08141-0c62-45c7-9fb4-b3d87b7e11c0", "icon");

    AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      "channel ID", //channel.id,
      "channel name", //channel.name,
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      styleInformation: BigPictureStyleInformation(
          FilePathAndroidBitmap(timePicPath),

          largeIcon: FilePathAndroidBitmap(iconPath)
      ),
    );
    NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    _notification.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(dt, tz.local),
      platformChannelSpecifics,
      payload: payload,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
    print("scheduled");
  }


  static Future showNotification(int id, String title, String body, String payload) async{
    final timePicPath = await Utils.downloadFile("https://firebasestorage.googleapis.com/v0/b/cpp-ontime-flutter.appspot.com/o/time.png?alt=media&token=dc449c24-5ecf-42ce-af42-282f4c3d7a01", "time");
    final iconPath = await Utils.downloadFile("https://firebasestorage.googleapis.com/v0/b/cpp-ontime-flutter.appspot.com/o/logo.png?alt=media&token=e4d08141-0c62-45c7-9fb4-b3d87b7e11c0", "icon");

    AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      "channel ID", //channel.id,
      "channel name", //channel.name,
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      styleInformation: BigPictureStyleInformation(
          FilePathAndroidBitmap(timePicPath),

          largeIcon: FilePathAndroidBitmap(iconPath)
      ),
    );

    NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

    _notification.show(
      id,
      title,
      body,
      platformChannelSpecifics,
      payload: payload,
    );
  }

  static Future cancelNotification(int id) async{
    await _notification.cancel(id);
    print("Notification canceled");

  }

}