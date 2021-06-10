import 'package:counter_app/providers/counter_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class ProviderCounter extends StatelessWidget {
  const ProviderCounter({Key? key}) : super(key: key);

  void _showSnachBar({required BuildContext context, required String message}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<CounterProvider>(
        builder: (context, provider, __) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${provider.count}',
                style: TextStyle(fontSize: 40.0),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                    ),
                    onPressed: () {
                      provider.increment();
                      _showSnachBar(
                          context: context,
                          message: 'Countet ${provider.count}');
                    },
                    icon: Icon(Icons.add),
                    label: Text(
                      '1',
                      style: TextStyle(
                        fontSize: 23.0,
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                    ),
                    onPressed: () {
                      provider.decrement();
                      _showSnachBar(
                          context: context,
                          message: 'Countet ${provider.count}');
                    },
                    icon: Icon(Icons.remove),
                    label: Text(
                      '1',
                      style: TextStyle(
                        fontSize: 23.0,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
