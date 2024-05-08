import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_app/holper.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  LodIn({required String username, required String pass}) async {
    emit(LoginLoading());
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: username, password: pass);
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginFaluier(error: 'No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        emit(LoginFaluier(error: 'Wrong password provided for that user.'));
      } else {
        emit(LoginFaluier(error: 'There is an error'));
      }
    }
  }
}
