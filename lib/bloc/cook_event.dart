part of 'cook_bloc.dart';

@immutable
sealed class CookEvent {}


class GetRecipes extends CookEvent{}