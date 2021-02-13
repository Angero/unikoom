part of 'take_bloc.dart';

@immutable
abstract class TakeState {}

class InitialTakeState extends TakeState {}

class SuccessTakeState<S> extends TakeState {
  final S success;

  SuccessTakeState(this.success);
}

class FailureTakeState extends TakeState {
  final String error;

  FailureTakeState(this.error);
}

class WaitingTakeState extends TakeState {}
