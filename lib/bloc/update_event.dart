part of 'update_bloc.dart';

@immutable
sealed class UpdateEvent {}

class Upbloc extends UpdateEvent {
  UpdateModel edite;
  String id;
  Upbloc({
    required this.edite,
    required this.id,
  });
}

