part of 'add_bloc.dart';

@immutable
sealed class AddState {}

final class AddInitial extends AddState {}

class Success extends AddState {}

class Error extends AddState {}

class Loading extends AddState {}

class Offline extends AddState {}
