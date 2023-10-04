import 'package:fasilah_m1/features/admin/home/view.dart';
import 'package:fasilah_m1/shared/components/navigator.dart';
import 'package:fasilah_m1/shared/network/local/constant.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/components/constants.dart';
import '../../../../shared/styles/colors.dart';
import '../../navigation/view.dart';

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
  final ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(
                  width: width(context, 3),
                  child: RadioListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 5),
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
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
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
                    contentPadding: const EdgeInsets.symmetric(horizontal: 5),
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
            Center(
              child: ButtonTemplate(
                color: AppColors.brown,
                onPressed: () {
                  if (kDebugMode) {
                    print(selectedType);
                  }
                  type = selectedType;
                  if (kDebugMode) {
                    print(type);
                  }
                  // FirebaseAuth.instance.createUserWithEmailAndPassword(email: 'haneengheas@gmail.com', password: '123456').then((value) => {
                  //   debugPrint(value.user!.uid)
                  // });
                  if (type == 'admin') {
                    navigateTo(context, const AdminHomeScreen());
                  } else {
                    navigateTo(context, NavigationScreen());
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
  }
}
