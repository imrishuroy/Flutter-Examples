import 'package:counter_app/providers/counter_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'blocs/counter/counter_bloc.dart';

import 'screens/provider_counter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CounterProvider>(
          create: (_) => CounterProvider(),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<CounterBloc>(
            create: (context) => CounterBloc(),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          // home: BlocCounter(),
          home: ProviderCounter(),
        ),
      ),
    );
  }
}
