import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRExample extends StatelessWidget {
  const QRExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: QrImage(
          data: 'This is a simple QR code',
          version: QrVersions.auto,
          size: 320,
          gapless: false,
        ),
      ),
    );
  }
}
