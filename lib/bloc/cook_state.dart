// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'cook_bloc.dart';

@immutable
sealed class CookState {}

final class CookInitial extends CookState {}


class Success extends CookState {
  //  CookModel cooked;
  List<CookModel> cooking;
  Success({
    // required this.cooked,
    required this.cooking,
  });
}


class Error extends CookState{}

class Loading extends CookState {}

class Offline extends CookState {}

