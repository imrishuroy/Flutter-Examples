import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void initialiseSettings() async {
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    // final AndroidInitializationSettings initializationSettingsAndroid =
    //     AndroidInitializationSettings('app_icon');

    // final InitializationSettings initializationSettings =
    //     InitializationSettings(
    //   android: initializationSettingsAndroid,
    // );

    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('chat_icon');

// final IOSInitializationSettings initializationSettingsIOS =
//     IOSInitializationSettings(
//         onDidReceiveLocalNotification: onDidReceiveLocalNotification);
// final MacOSInitializationSettings initializationSettingsMacOS =
//     MacOSInitializationSettings();
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      //iOS: initializationSettingsIOS,
      // macOS: initializationSettingsMacOS
    );

    // await flutterLocalNotificationsPlugin.initialize(initializationSettings,
    //     onSelectNotification: (value) async {
    //   print(value);
    // });

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> displayNotification() async {
    flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Hello there...',
      'Your prescription has been added, Please check',
      tz.TZDateTime.now(tz.local).add(Duration(seconds: 5)),
      NotificationDetails(
          android: AndroidNotificationDetails(
        'channel_id',
        'channel_name',
        'channel_description',
      )),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
    );
  }
}
