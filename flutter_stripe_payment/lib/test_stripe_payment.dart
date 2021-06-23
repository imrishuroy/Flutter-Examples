import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:stripe_payment/stripe_payment.dart';

class TestStripePayment extends StatefulWidget {
  const TestStripePayment({Key? key}) : super(key: key);

  @override
  _TestStripePaymentState createState() => _TestStripePaymentState();
}

class _TestStripePaymentState extends State<TestStripePayment> {
  double costPrice = 100.0;
  int amount = 100;
  String? _error;
  @override
  void initState() {
    super.initState();
    StripePayment.setOptions(
      StripeOptions(
        publishableKey:
            'pk_test_51Io5n5SFuluemEibvrpwKC5VS1wN7gPPxKii4Ds6QPEzdvbbne54MvR8Nw21AvfuCjvfLgw1u7YlPoClIAKoH0Zc00E9w2eR9p',
      ),
    );
  }

  PaymentMethod? _paymentMethod;
  void setError(dynamic error) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(error.toString())));
    setState(() {
      _error = error.toString();
    });
  }

  Future<void> startPayment() async {
    print('This runs----------------');
    try {
      final paymentMethod = await StripePayment.paymentRequestWithCardForm(
          CardFormPaymentRequest());

      // final enCodedPayment = jsonEncode(paymentMethod);
      // final deCodedPayment = jsonDecode(enCodedPayment);

      String apiBase = 'https://api.stripe.com/v1';
      String secretKey =
          'sk_test_51Io5n5SFuluemEibMZCKUkmOBBlPkXq5UeMKmCGMzWIVztREcwfdehJ1d7tvbYhxgLzG9EEJx3PjLVg3gabFmiwA00UqdnvHOa';
      String paymentUrl = '$apiBase/payment_intents';

      Map<String, dynamic> body = {
        'amount': '100',
        // 'currency': 'usd',
        'currency': 'inr',
        'payment_method_types[]': 'card'
      };
      Map<String, String> headers = {
        'Authorization': 'Bearer $secretKey',
        'Content-Type': 'application/x-www-form-urlencoded',
      };

      final response = await http.post(
        Uri.parse(
          paymentUrl,
        ),
        body: body,
        headers: headers,
      );
      print('------------------------------------');
      print(response.body);
      print(response.body.runtimeType);
      print(response.statusCode);
      print(jsonDecode(response.body));
      print(jsonDecode(response.body).runtimeType);

      final data = jsonDecode(response.body);
      print('-----------------------');
      print(data.runtimeType);

      final paymentIntent = await StripePayment.confirmPaymentIntent(
        PaymentIntent(
          clientSecret: data['client_secret'],
          paymentMethodId: paymentMethod.id,
        ),
      );

      print('Payement Intent --------------- ${paymentIntent.status}');
      //Payement Intent --------------- succeeded

    } catch (error) {
      print('Error----------------------${error.toString()}');
    }

    // try {} catch (error) {}
    // //StripePayment.setStripeAccount('null');
    // amount = (10 * 100).toInt();

    // PaymentMethod paymentMethod = PaymentMethod();
    // paymentMethod = await StripePayment.paymentRequestWithCardForm(
    //   CardFormPaymentRequest(),
    // ).then((PaymentMethod paymentMethod) {
    //   print('This runs----------------2');
    //   return paymentMethod;
    // }).catchError((error) {
    //   print('-----------------Payment Errot - ${error.toString()}');
    // });
    // print('---------------------------------');
    // print(paymentMethod.id);
    // startDirectCharge(paymentMethod);
  }

  _makePayment() async {
    try {
      String apiBase = 'https://api.stripe.com/v1';
      String secretKey =
          'sk_test_51J2NG7EQrpNdjijuy2jr4NTF7XcIMbvp4YJMB3JuAzOK9NqGDlZzwq0zoA32QfL6TY5GPhlmPTFsJIuAdPYHoFfO00lMCrmrBS';
      String paymentUrl = '$apiBase/payment_intents';

      Map<String, dynamic> body = {
        'amount': '500',
        'currency': 'usd',
        'payment_method_types[]': 'card'
      };
      Map<String, String> headers = {
        'Authorization': 'Bearer $secretKey',
        'Content-Type': 'application/x-www-form-urlencoded',
      };

      final response = await http.post(
        Uri.parse(
          paymentUrl,
        ),
        body: body,
        headers: headers,
      );
      print('------------------------------------');
      print(response.body);
      print(response.body.runtimeType);
      print(response.statusCode);
      print(jsonDecode(response.body));
      print(jsonDecode(response.body).runtimeType);

      final data = jsonDecode(response.body);
      print('-----------------------');
      print(data.runtimeType);

      await StripePayment.confirmPaymentIntent(
        PaymentIntent(
          clientSecret: data['client_secret'],
          paymentMethodId: _paymentMethod?.id,
        ),
      );
    } catch (error) {
      print('Payment Error -------------- ${error.toString()}');
    }
  }

  String description = 'This is test description';

  // Future<void> startDirectCharge(PaymentMethod paymentMethod) async {
  //   try {
  //     print('Payment charge started');
  //     String url =
  //         "https://us-central1-discover-genius-within.cloudfunctions.net/stripePay";
  //     print(
  //         'Final Url ------------ $url?amount=$amount&currency=USD&paym=${paymentMethod.id}&description=$description');

  //     final dioRes = await Dio().post(
  //         '$url?amount=$amount&currency=USD&paym=${paymentMethod.id}$description=$description');

  //     print('DIO RESPONSE ${dioRes.data}');

  //     // final http.Response? response = await http.post(Uri.parse(
  //     //     '$url?amount=$amount&currency=USD&paym=${paymentMethod.id}'));

  //     final http.Response response = await http.post(Uri.parse(
  //         '$url?amount=$amount&currency=USD&paym=${paymentMethod.id}'));

  //     print(response.statusCode);
  //     print('--------------------------------');
  //     print('${response.body}');

  //     if (response.body != null && response.body != 'error') {
  //       final paymentIntent = jsonDecode(response.body);
  //       final status = paymentIntent['paymentIntent']['status'];
  //       final acct = paymentIntent['stripeAccount'];

  //       if (status == 'succeeded') {
  //         print('Payment Done');
  //       } else {
  //         StripePayment.setStripeAccount(acct);
  //         // await StripePayment.confirmPaymentIntent(intent)

  //         await StripePayment.confirmPaymentIntent(PaymentIntent(
  //                 paymentMethodId: paymentIntent['paymentIntent']
  //                     ['payment_method'],
  //                 clientSecret: paymentIntent['paymentIntent']
  //                     ['client_secret']))
  //             .then((PaymentIntentResult paymentIntentResult) {
  //           final statusFinal = paymentIntentResult.status;

  //           if (statusFinal == 'succeeded') {
  //             print('Payment Done');
  //             StripePayment.completeNativePayRequest();
  //           }
  //         });
  //       }
  //     }
  //   } catch (error) {
  //     print('Error in payment process -------- ${error.toString()}');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text('Pay'),
          onPressed: () {
            startPayment();
          },
        ),
      ),
    );
  }
}

// class TestStripePayment extends StatefulWidget {
//   @override
//   _TestStripePaymentState createState() => new _TestStripePaymentState();
// }

// class _TestStripePaymentState extends State<TestStripePayment> {
//   Token? _paymentToken;
//   PaymentMethod? _paymentMethod;
//   String? _error;

//   //this client secret is typically created by a backend system
//   //check https://stripe.com/docs/payments/payment-intents#passing-to-client
//   final String? _paymentIntentClientSecret = null;

//   PaymentIntentResult? _paymentIntent;
//   Source? _source;

//   ScrollController _controller = ScrollController();

//   final CreditCard testCard = CreditCard(
//     number: '4000002760003184',
//     expMonth: 12,
//     expYear: 21,
//     name: 'Test User',
//     cvc: '133',
//     addressLine1: 'Address 1',
//     addressLine2: 'Address 2',
//     addressCity: 'City',
//     addressState: 'CA',
//     addressZip: '1337',
//   );

//   GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

//   @override
//   initState() {
//     super.initState();

//     StripePayment.setOptions(StripeOptions(
//         publishableKey:
//             "pk_test_51J2NG7EQrpNdjijuNj5zdd9Nd0U0jDJ3Q05hRRmerG3u1blhhn8z5cI4cpOycs3aFC0NIElbpMO4MmNLjYuXmzHb00JHGxfFQI",
//         merchantId: "Test",
//         androidPayMode: 'test'));
//   }

//   void setError(dynamic error) {
//     ScaffoldMessenger.of(context)
//         .showSnackBar(SnackBar(content: Text(error.toString())));
//     setState(() {
//       _error = error.toString();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new MaterialApp(
//       home: new Scaffold(
//         key: _scaffoldKey,
//         appBar: new AppBar(
//           title: new Text('Plugin example app'),
//           actions: <Widget>[
//             IconButton(
//               icon: Icon(Icons.clear),
//               onPressed: () {
//                 setState(() {
//                   _source = null;
//                   _paymentIntent = null;
//                   _paymentMethod = null;
//                   _paymentToken = null;
//                 });
//               },
//             )
//           ],
//         ),
//         body: ListView(
//           controller: _controller,
//           padding: const EdgeInsets.all(20),
//           children: <Widget>[
//             RaisedButton(
//               child: Text("Create Source"),
//               onPressed: () {
//                 StripePayment.createSourceWithParams(SourceParams(
//                   type: 'ideal',
//                   amount: 1099,
//                   currency: 'eur',
//                   returnURL: 'example://stripe-redirect',
//                 )).then((source) {
//                   _scaffoldKey.currentState!.showSnackBar(
//                       SnackBar(content: Text('Received ${source.sourceId}')));
//                   setState(() {
//                     _source = source;
//                   });
//                 }).catchError(setError);
//               },
//             ),
//             Divider(),
//             RaisedButton(
//               child: Text("Create Token with Card Form"),
//               onPressed: () {
//                 StripePayment.paymentRequestWithCardForm(
//                         CardFormPaymentRequest())
//                     .then((paymentMethod) {
//                   _scaffoldKey.currentState!.showSnackBar(
//                       SnackBar(content: Text('Received ${paymentMethod.id}')));
//                   setState(() {
//                     _paymentMethod = paymentMethod;
//                   });
//                 }).catchError(setError);
//               },
//             ),
//             RaisedButton(
//               child: Text("Create Token with Card"),
//               onPressed: () {
//                 StripePayment.createTokenWithCard(
//                   testCard,
//                 ).then((token) {
//                   _scaffoldKey.currentState!.showSnackBar(
//                       SnackBar(content: Text('Received ${token.tokenId}')));
//                   setState(() {
//                     _paymentToken = token;
//                   });
//                 }).catchError(setError);
//               },
//             ),
//             Divider(),
//             RaisedButton(
//               child: Text("Create Payment Method with Card"),
//               onPressed: () {
//                 StripePayment.createPaymentMethod(
//                   PaymentMethodRequest(
//                     card: testCard,
//                   ),
//                 ).then((paymentMethod) {
//                   _scaffoldKey.currentState!.showSnackBar(
//                       SnackBar(content: Text('Received ${paymentMethod.id}')));
//                   setState(() {
//                     _paymentMethod = paymentMethod;
//                   });
//                 }).catchError(setError);
//               },
//             ),
//             RaisedButton(
//               child: Text("Create Payment Method with existing token"),
//               onPressed: _paymentToken == null
//                   ? null
//                   : () {
//                       StripePayment.createPaymentMethod(
//                         PaymentMethodRequest(
//                           card: CreditCard(
//                             token: _paymentToken!.tokenId,
//                           ),
//                         ),
//                       ).then((paymentMethod) {
//                         _scaffoldKey.currentState!.showSnackBar(SnackBar(
//                             content: Text('Received ${paymentMethod.id}')));
//                         setState(() {
//                           _paymentMethod = paymentMethod;
//                         });
//                       }).catchError(setError);
//                     },
//             ),
//             Divider(),
//             RaisedButton(
//               child: Text("Confirm Payment Intent"),
//               onPressed:
//                   _paymentMethod == null || _paymentIntentClientSecret == null
//                       ? null
//                       : () {
//                           StripePayment.confirmPaymentIntent(
//                             PaymentIntent(
//                               clientSecret: _paymentIntentClientSecret,
//                               paymentMethodId: _paymentMethod!.id,
//                             ),
//                           ).then((paymentIntent) {
//                             _scaffoldKey.currentState!.showSnackBar(SnackBar(
//                                 content: Text(
//                                     'Received ${paymentIntent.paymentIntentId}')));
//                             setState(() {
//                               _paymentIntent = paymentIntent;
//                             });
//                           }).catchError(setError);
//                         },
//             ),
//             RaisedButton(
//               child: Text(
//                 "Confirm Payment Intent with saving payment method",
//                 textAlign: TextAlign.center,
//               ),
//               onPressed:
//                   _paymentMethod == null || _paymentIntentClientSecret == null
//                       ? null
//                       : () {
//                           StripePayment.confirmPaymentIntent(
//                             PaymentIntent(
//                               clientSecret: _paymentIntentClientSecret,
//                               paymentMethodId: _paymentMethod!.id!,
//                               isSavingPaymentMethod: true,
//                             ),
//                           ).then((paymentIntent) {
//                             _scaffoldKey.currentState?.showSnackBar(SnackBar(
//                                 content: Text(
//                                     'Received ${paymentIntent.paymentIntentId}')));
//                             setState(() {
//                               _paymentIntent = paymentIntent;
//                             });
//                           }).catchError(setError);
//                         },
//             ),
//             RaisedButton(
//               child: Text("Authenticate Payment Intent"),
//               onPressed: _paymentIntentClientSecret == null
//                   ? null
//                   : () {
//                       StripePayment.authenticatePaymentIntent(
//                               clientSecret: _paymentIntentClientSecret!)
//                           .then((paymentIntent) {
//                         _scaffoldKey.currentState!.showSnackBar(SnackBar(
//                             content: Text(
//                                 'Received ${paymentIntent.paymentIntentId}')));
//                         setState(() {
//                           _paymentIntent = paymentIntent;
//                         });
//                       }).catchError(setError);
//                     },
//             ),
//             Divider(),
//             RaisedButton(
//               child: Text("Native payment"),
//               onPressed: () {
//                 if (Platform.isIOS) {
//                   _controller.jumpTo(450);
//                 }
//                 StripePayment.paymentRequestWithNativePay(
//                   androidPayOptions: AndroidPayPaymentRequest(
//                     totalPrice: "1.20",
//                     currencyCode: "EUR",
//                   ),
//                   applePayOptions: ApplePayPaymentOptions(
//                     countryCode: 'DE',
//                     currencyCode: 'EUR',
//                     items: [
//                       ApplePayItem(
//                         label: 'Test',
//                         amount: '13',
//                       )
//                     ],
//                   ),
//                 ).then((token) {
//                   setState(() {
//                     _scaffoldKey.currentState!.showSnackBar(
//                         SnackBar(content: Text('Received ${token.tokenId}')));
//                     _paymentToken = token;
//                   });
//                 }).catchError(setError);
//               },
//             ),
//             RaisedButton(
//               child: Text("Complete Native Payment"),
//               onPressed: () {
//                 StripePayment.completeNativePayRequest().then((_) {
//                   _scaffoldKey.currentState!.showSnackBar(
//                       SnackBar(content: Text('Completed successfully')));
//                 }).catchError(setError);
//               },
//             ),
//             Divider(),
//             Text('Current source:'),
//             Text(
//               JsonEncoder.withIndent('  ').convert(_source?.toJson() ?? {}),
//               style: TextStyle(fontFamily: "Monospace"),
//             ),
//             Divider(),
//             Text('Current token:'),
//             Text(
//               JsonEncoder.withIndent('  ')
//                   .convert(_paymentToken?.toJson() ?? {}),
//               style: TextStyle(fontFamily: "Monospace"),
//             ),
//             Divider(),
//             Text('Current payment method:'),
//             Text(
//               JsonEncoder.withIndent('  ')
//                   .convert(_paymentMethod?.toJson() ?? {}),
//               style: TextStyle(fontFamily: "Monospace"),
//             ),
//             Divider(),
//             Text('Current payment intent:'),
//             Text(
//               JsonEncoder.withIndent('  ')
//                   .convert(_paymentIntent?.toJson() ?? {}),
//               style: TextStyle(fontFamily: "Monospace"),
//             ),
//             Divider(),
//             Text('Current error: $_error'),
//           ],
//         ),
//       ),
//     );
//   }
// }
