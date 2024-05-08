part of 'singin_cubit.dart';

@immutable
sealed class SinginState {}

final class SinginInitial extends SinginState {}

final class singinLoading extends SinginState {}

final class singinSuccess extends SinginState {}

final class singinFaluier extends SinginState {
  final String error;
  singinFaluier({required this.error});
}

final class UpdateVisablePassing extends SinginState {
  final bool visible;

  UpdateVisablePassing({required this.visible});
}
