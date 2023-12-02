import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/user_model.dart';
import '../../../../shared/network/local/constant.dart';
import '../../../../shared/network/local/shared_preferences.dart';
import '../../sign_up/cubit/exception.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);
  UserModel? model;
  AuthResultStatus? _status;

  userLogin({required String email, required String password}) {
    emit(LoginLoadingState());

    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      if (kDebugMode) {
        print(value.user!.uid);
        print(value.user!.email);
      }
      getUser(uid: value.user!.uid);
    }).catchError((error) {
      _status = AuthExceptionHandler.handleException(error);
      emit(LoginErrorState(_status!));
    });
  }

  getUser({required String uid}) {
    FirebaseMessaging.instance.getToken().then((value) => {
      FirebaseFirestore.instance.collection('users').doc(uid).update({
        'token': value,
      }),
    });

    FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) {
      model = UserModel.fromJson(value.data()!);
      CacheHelper.saveData(key: 'uid', value: uid);
      CacheHelper.saveData(key: 'type', value: model!.type.toString());
      uId = CacheHelper.getData(key: 'uid');
      type = CacheHelper.getData(key: 'type');
      print(uId);
      emit(LoginSuccessState(uid: uid, type: model!.type.toString()));
    }).catchError((error) {
      emit(GetDataErrorState(error.toString()));
    });
  }

  IconData suffixIcon = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;

    suffixIcon =
    isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(RegisterShowPasswordVisibilityState());
  }
}



















