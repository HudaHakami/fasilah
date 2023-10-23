import 'package:fasilah_m1/features/registration/reset_password/cubit/reset_password_cubit.dart';
import 'package:fasilah_m1/shared/components/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/styles/colors.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResetPasswordCubit(),
      child: BlocListener<ResetPasswordCubit, ResetPasswordState>(
        listener: (context, state) {
          if (state is ResetPasswordSuccessState) {
            showToast(
                text: 'تم الارسال بنجاح الي البريد الإلكتروني',
                state: ToastStates.success);
          }

        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Forget password'),
            leading: IconButton(
                onPressed: () => navigatePop(context),
                icon: const Icon(
                  Icons.arrow_back,
                )),
          ),
          body: BackgroundBox(
            widget: Column(
              children: [
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
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
                      const SizedBox(
                        height: 30,
                      ),
                      ButtonTemplate(
                          minwidth: width(context, 2),
                          color: AppColors.brown,
                          text1: 'send',
                          onPressed: () => {
                            if (formKey.currentState!.validate())
                              {
                                ResetPasswordCubit.get(context)
                                    .resetPassword(email: emailController.text)
                              }
                          }),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
