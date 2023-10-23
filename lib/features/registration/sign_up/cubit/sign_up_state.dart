part of 'sign_up_cubit.dart';

@immutable
abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpInitialState extends SignUpState {}

class SignUpLoadingState extends SignUpState {}

class SignUpSuccessState extends SignUpState {
  late final String uid;
  late final String type;

  SignUpSuccessState({required this.uid, required this.type});
}


class SignUpErrorState extends SignUpState {
  late final   AuthResultStatus error;

  SignUpErrorState(this.error);
}


