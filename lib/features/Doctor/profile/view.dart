import 'package:fasilah_m1/features/Doctor/cubit/user_cubit.dart';
import 'package:fasilah_m1/features/navigation/view.dart';
import 'package:fasilah_m1/models/user_model.dart';
import 'package:fasilah_m1/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/components/navigator.dart';
import '../../../shared/styles/colors.dart';
import '../../../shared/styles/styles.dart';

class DoctorProfile extends StatefulWidget {
  final UserModel userModel;

  const DoctorProfile({required this.userModel, super.key});

  @override
  State<DoctorProfile> createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    UserCubit.get(context).getData();
    nameController = TextEditingController(text: widget.userModel.name);
    emailController = TextEditingController(text: widget.userModel.email);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is UpdateProfileSuccessState) {
          showToast(text: 'profile updated', state: ToastStates.success);
          navigateTo(context, NavigationScreen());
        }
      },
      builder: (context, state) {
        return BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    navigateTo(context, const NavigationScreen());
                  },
                ),
                title: const Text('Profile'),
              ),
              backgroundColor: AppColors.white,
              body: SingleChildScrollView(
                child: Container(
                  width: width(context, 1),
                  height: height(context, 1.5),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 10),
                  margin: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: AppColors.white3,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      TextFieldTemplate(
                        hintText: 'doctor name',
                        labelText: 'Name',
                        icon: Icons.person,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'please enter your name';
                          }
                        },
                        controller: nameController,
                        readOnly: true,
                      ),
                      TextFieldTemplate(
                        hintText: 'email@example.com',
                        labelText: 'Email',
                        icon: Icons.mail,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'please enter your email';
                          } else if (value.length < 5) {
                            return 'please write email in correct way';
                          } else if (!value.toString().contains('@')) {
                            return 'email must contain @';
                          }
                        },
                        controller: emailController,
                        readOnly: true,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ButtonTemplate(
                        color: AppColors.brown,
                        text1: 'edit',
                        onPressed: () {
                          editProfile(context: context,
                              model: widget.userModel,
                              state: state);
                        },
                        minwidth: width(context, 2.5),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}


Future editProfile({
  required BuildContext context,
  required UserModel model,
  required UserState state
}) {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController(text: model.name);
  final emailController = TextEditingController(text: model.email);


  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.white3,
          title: const Center(child: Text('edit profile')),
          titleTextStyle: AppTextStyles.smTitles.apply(color: AppColors.black),
          insetPadding: const EdgeInsets.all(10),
          shape: const RoundedRectangleBorder(
              side: BorderSide(
                color: AppColors.green,
              ),
              borderRadius: BorderRadius.all(Radius.circular(15))),
          content: SingleChildScrollView(
            child: SizedBox(
              width: width(context, 1),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFieldTemplate(
                      hintText: 'doctor name',
                      labelText: 'Name',
                      icon: Icons.person,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'please enter your name';
                        }
                      },
                      controller: nameController,

                    ),
                    TextFieldTemplate(
                      hintText: 'email@example.com',
                      labelText: 'Email',
                      icon: Icons.mail,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'please enter your email';
                        } else if (value.length < 5) {
                          return 'please write email in correct way';
                        } else if (!value.toString().contains('@')) {
                          return 'email must contain @';
                        }
                      },
                      controller: emailController,

                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SmallButtonTemplate(
                  minwidth: width(context, 4),
                  color: AppColors.brown,
                  minHeight: 40,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      UserCubit.get(context).updateProfile(
                          name: nameController.text,
                          email: emailController.text,
                          uid: model.uid!);
                      navigatePop(context);
                    }
                  },
                  text1: 'edit',

                ),
                SmallButtonTemplate(
                  minwidth: width(context, 4),
                  color: AppColors.green,
                  minHeight: 40,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      Navigator.pop(context);
                    }
                  },
                  text1: 'cancel',

                ),
              ],
            ),
          ],
        );
      });
}

