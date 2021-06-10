import 'package:barcode_with_localnotification/screens/local_notification_example.dart';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //  home: QRViewExample(),
      //home: QRExample(),
      home: LocalNotification(),
    );
  }
}
