part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {}

final class LoginFaluier extends LoginState {
  final String error;
  LoginFaluier({required this.error});
}

final class UpdateVisablePass extends LoginState {
  final bool visible;

  UpdateVisablePass({required this.visible});
}
