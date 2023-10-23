<<<<<<< HEAD
import 'package:fasilah_m1/features/navigation/view.dart';
import 'package:fasilah_m1/features/registration/login/cubit/login_cubit.dart';
=======
>>>>>>> 5c1725bbff958ea0e2045205c008d351b61b45e7
import 'package:fasilah_m1/features/visitors/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/components/navigator.dart';
import '../../../shared/network/local/constant.dart';
import '../../../shared/styles/colors.dart';
import '../../admin/home/view.dart';
import '../reset_password/view.dart';
import '../sign_up/cubit/exception.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            if (state.type == 'doctor' || state.type == 'student') {
              navigateTo(context, NavigationScreen());
            }
            if (state.type == 'admin') {
              navigateTo(context, const AdminHomeScreen());
            }
          }
          if (state is LoginErrorState) {
            final errorMsg = AuthExceptionHandler.generateExceptionMessage(
                state.error);
            showToast(text: errorMsg, state: ToastStates.error);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    // Email TextFiled
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
                    TextFieldTemplate(
                      hintText: '**********',
                      icon: Icons.lock,
                      keyType: TextInputType.visiblePassword,
                      controller: passwordController,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'please enter password ';
                        } else if (value.length < 6) {
                          return 'The password must consist of at least 6 digits ';
                        }
                      },
                      labelText: 'Password',
                    ),
                    //forget password
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: InkWell(
                        onTap: () => navigateTo(context, const ResetPassword()),
                        child: Text("forget password ? ",
                            style: GoogleFonts.tajawal(
                              fontSize: 18,
                              color: AppColors.brown,
                              decoration: TextDecoration.underline,
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    // login button
                    state is LoginLoadingState
                        ? const Center(child: CircularProgressIndicator())
                        :
                    Center(
                      child: ButtonTemplate(
                        color: AppColors.brown,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            LoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text);
                          }
                        },
                        minwidth: width(context, 2),
                        text1: 'login',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: InkWell(
                        onTap: () => {
                          type = 'visitors',
                          navigateTo(context, const VisitorScreen())
                        },
                        child: Text("Continue as a visitor",
                            style: GoogleFonts.tajawal(
                              fontSize: 18,
                              color: AppColors.brown,
                              decoration: TextDecoration.underline,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
<<<<<<< HEAD
            ),
          );
        },
=======
              const SizedBox(
                height: 40,
              ),
              // login button
              Center(
                child: ButtonTemplate(
                  color: AppColors.brown,
                  onPressed: () {
                    navigateTo(context, const AdminHomeScreen());
                  },
                  minwidth: width(context, 2),
                  text1: 'login',
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: InkWell(
                  onTap: () => {
                    type = 'visitors' ,
                    navigateTo(context, const VisitorScreen())},
                  child: Text("Continue as a visitor",
                      style: GoogleFonts.tajawal(
                        fontSize: 18,
                        color: AppColors.brown,
                        decoration: TextDecoration.underline,
                      )),
                ),
              ),
            ],
          ),
        ),
>>>>>>> 5c1725bbff958ea0e2045205c008d351b61b45e7
      ),
    );
  }
}
