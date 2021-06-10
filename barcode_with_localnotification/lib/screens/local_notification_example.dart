import 'package:barcode_with_localnotification/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:timezone/data/latest.dart' as tz;

class LocalNotification extends StatefulWidget {
  const LocalNotification({Key? key}) : super(key: key);

  @override
  _LocalNotificationState createState() => _LocalNotificationState();
}

class _LocalNotificationState extends State<LocalNotification> {
  NotificationService notificationService = NotificationService();
  @override
  void initState() {
    tz.initializeTimeZones();
    notificationService.initialiseSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          notificationService.displayNotification();
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
