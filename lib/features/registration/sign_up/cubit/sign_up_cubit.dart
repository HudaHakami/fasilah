import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/network/local/constant.dart';
import '../../../../shared/network/local/shared_preferences.dart';
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
        .then((value) => {
      FirebaseFirestore.instance
          .collection('users')
          .doc(value.user!.uid)
          .set({
        'type': type,
        'name': name,
        'token': token,
        'email': email,
        'uid': value.user!.uid,
      }),
      CacheHelper.saveData(key: 'uid', value: value.user!.uid),
      CacheHelper.saveData(key: 'type', value: type),
      uId = CacheHelper.getData(key: 'uid'),
      type = CacheHelper.getData(key: 'type'),
      print(uId),
      emit(SignUpSuccessState(uid: value.user!.uid, type: type))
    })
        .catchError((error) {
      _status = AuthExceptionHandler.handleException(error);
      emit(SignUpErrorState(_status!));
      return <Future<void>>{};
    });
  }

  IconData suffixIcon = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    // معناها عكس قيمتها اعكس القيمه الى هى فيها
    isPassword = !isPassword;

    suffixIcon =
    isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(RegisterShowPasswordVisibilityState());
  }
}

