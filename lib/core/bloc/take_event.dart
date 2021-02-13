part of 'take_bloc.dart';

@immutable
abstract class TakeEvent {}

class SendTakeEvent implements TakeEvent {
  final String value;

  SendTakeEvent(this.value);
}
