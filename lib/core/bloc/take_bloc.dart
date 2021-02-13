import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:unikoom/core/data/data_entity.dart';
import 'package:unikoom/core/data/repository_interface.dart';

part 'take_event.dart';

part 'take_state.dart';

class TakeBloc<S> extends Bloc<TakeEvent, TakeState> {
  final RepositoryInterface<DataEntity> repository;

  TakeBloc({@required this.repository}) : super(InitialTakeState());

  @override
  Stream<TakeState> mapEventToState(TakeEvent event) async* {
    if (event is SendTakeEvent) {
      yield WaitingTakeState();
      try {
        List<DataEntity> result = await repository.getList(event.value);
        if (result != null)
          yield SuccessTakeState(result);
        else
          yield FailureTakeState('Failure');
      } catch (e, stacktrace) {
        print('RA: ${e.toString()} STACKTRACE: ${stacktrace.toString()}');
        yield FailureTakeState(e.toString());
      }
    }
  }
}
