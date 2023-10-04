import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fasilah_m1/shared/components/components.dart';
import 'package:fasilah_m1/shared/components/constants.dart';
import 'package:fasilah_m1/shared/components/navigator.dart';
import '../../../shared/styles/colors.dart';
import '../../admin/home/view.dart';
import '../reset_password/view.dart';

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
                padding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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

              ),
            ],
          ),
        ),
      ),
    );
  }
}
