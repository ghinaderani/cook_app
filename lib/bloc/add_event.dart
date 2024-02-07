part of 'add_bloc.dart';

@immutable
sealed class AddEvent {}

class Postbloc extends AddEvent {
  CookModel cooked;
  Postbloc({
    required this.cooked,
  });
}
