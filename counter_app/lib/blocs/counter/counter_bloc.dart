import 'dart:async';

import 'package:bloc/bloc.dart';
// import 'package:counter_app/bloc/blocs.dart';
import 'package:equatable/equatable.dart';

part 'counter_event.dart';
// part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0);

  @override
  Stream<int> mapEventToState(
    CounterEvent event,
  ) async* {
    if (event is IncrementCounter) {
      yield* _mapIncrementEventToState(event);
    } else if (event is DecrementCounter) {
      yield* _mapDecrementEventToState(event);
    }
  }

  Stream<int> _mapIncrementEventToState(CounterEvent event) async* {
    yield state + 1;
  }

  Stream<int> _mapDecrementEventToState(CounterEvent event) async* {
    yield state - 1;
  }
}
