import 'package:fasilah_m1/features/admin/home/view.dart';
import 'package:fasilah_m1/features/registration/sign_up/cubit/sign_up_cubit.dart';
import 'package:fasilah_m1/shared/components/navigator.dart';
import 'package:fasilah_m1/shared/network/local/constant.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/components/constants.dart';
import '../../../../shared/styles/colors.dart';
import '../../navigation/view.dart';
import 'cubit/exception.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

String? selectedType;

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: BlocConsumer<SignUpCubit, SignUpState>(
        listener: (context, state) {
          if (state is SignUpSuccessState) {
            if (state.type == 'doctor' || state.type == 'student') {
              navigateTo(context, NavigationScreen());
            } else {
              navigateTo(context, const AdminHomeScreen());
            }
          }
          if (state is SignUpErrorState) {
            final errorMsg =
            AuthExceptionHandler.generateExceptionMessage(state.error);
            showToast(text: errorMsg, state: ToastStates.error);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(children: [
                  //Name TextFiled
                  TextFieldTemplate(
                    hintText: 'enter your name',
                    icon: Icons.person,
                    keyType: TextInputType.name,
                    controller: nameController,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'please enter your name';
                      }
                    },
                    labelText: 'Name',
                  ),
                  //Email TextFiled
                  TextFieldTemplate(
                    hintText: 'example@gmail.com',
                    icon: Icons.mail_outlined,
                    keyType: TextInputType.emailAddress,
                    controller: emailController,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'please enter your email';
                      } else if (value.length < 5) {
                        return 'please write email in correct way';
                      } else if (!value.toString().contains('@')) {
                        return 'email must contain @';
                      }
                    },
                    labelText: 'Email',
                  ),

                  //Password TextFiled

                  defaultFormField(
                    hintText: '**********',
                    controller: passwordController,
                    isPassword: SignUpCubit.get(context).isPassword,
                    type: TextInputType.visiblePassword,
                    suffixIcon: SignUpCubit.get(context).suffixIcon,
                    suffixPressed: () {
                      SignUpCubit.get(context).changePasswordVisibility();
                    },
                    label: 'Password',
                    labelText: 'Password',
                    prefixIcon: Icons.lock_outline,
                    icon: Icons.lock,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'please enter password ';
                      } else if (value.length < 6) {
                        return 'The password must consist of at least 6 digits ';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: width(context, 3),
                        child: RadioListTile(
                          contentPadding:
                          const EdgeInsets.symmetric(horizontal: 5),
                          title: const Text('Student'),
                          value: 'student',
                          groupValue: selectedType,
                          onChanged: (value) {
                            setState(() {
                              selectedType = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: width(context, 3),
                        child: RadioListTile(
                          contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
                          title: const Text('Doctor'),
                          value: 'doctor',
                          groupValue: selectedType,
                          onChanged: (value) {
                            setState(() {
                              selectedType = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: width(context, 3),
                        child: RadioListTile(
                          contentPadding:
                          const EdgeInsets.symmetric(horizontal: 5),
                          title: const Text('admin'),
                          value: 'admin',
                          groupValue: selectedType,
                          onChanged: (value) {
                            setState(() {
                              selectedType = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // زر تسجيل الدخول
                  state is SignUpLoadingState
                      ? const Center(child: CircularProgressIndicator())
                      : Center(
                    child: ButtonTemplate(
                      color: AppColors.brown,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          if (kDebugMode) {
                            print(selectedType);
                          }
                          type = selectedType;
                          if (kDebugMode) {
                            print(type);
                          }
                          SignUpCubit.get(context).signUp(
                              name: nameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                              type: type!);
                        }
                      },
                      minwidth: width(context, 2),
                      text1: 'sign up',
                    ),
                  ),
                ]),
              ),
            ),
          );
        },
      ),
    );
  }
}
