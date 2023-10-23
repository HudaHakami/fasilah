import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/network/local/constant.dart';
import 'exception.dart';
part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  static SignUpCubit get(context) => BlocProvider.of(context);
  AuthResultStatus? _status;

  signUp({
    required String name,
    required String email,
    required String password,
    required String type,
  }) {
    emit(SignUpLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) =>
    {
      FirebaseFirestore.instance
          .collection('users')
          .doc(value.user!.uid)
          .set({
        'type': type,
        'name': name,
        'token': token,
        'email' : email,
        'uid' : value.user!.uid,

      }),
      emit(SignUpSuccessState(uid: value.user!.uid, type: type))
    }).catchError((error) {
      _status = AuthExceptionHandler.handleException(error);
      emit(SignUpErrorState(_status!));
      return <Future<void>>{};
    });
  }




}