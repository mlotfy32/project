import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'singin_state.dart';

class SinginCubit extends Cubit<SinginState> {
  SinginCubit() : super(SinginInitial());
  singin({required username, required String pass}) async {
    emit(singinLoading());
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: username,
        password: pass,
      );
      print('sssssssssssssss');
      emit(singinSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(singinFaluier(error: 'No user found for that email'));
      } else if (e.code == 'wrong-password') {
        emit(singinFaluier(error: 'Wrong password provided for that user'));
      } else {
        emit(singinFaluier(error: '$e'));
      }
    }
  }
}
