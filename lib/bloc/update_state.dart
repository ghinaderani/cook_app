part of 'update_bloc.dart';

@immutable
sealed class UpdateState {}

final class UpdateInitial extends UpdateState {}

class Success extends UpdateState {}

class Error extends UpdateState {}

class Loading extends UpdateState {}

class Offline extends UpdateState {}
