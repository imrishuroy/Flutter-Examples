import 'package:counter_app/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocCounter extends StatelessWidget {
  const BlocCounter({Key? key}) : super(key: key);

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
    final _counterBloc = BlocProvider.of<CounterBloc>(context);

    return Scaffold(
      body: BlocConsumer<CounterBloc, int>(
        bloc: _counterBloc,
        listener: (context, state) {
          _showSnachBar(context: context, message: 'Counter $state');
        },
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$state',
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
                    onPressed: () => _counterBloc.add(IncrementCounter()),
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
                    onPressed: () => _counterBloc.add(DecrementCounter()),
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
