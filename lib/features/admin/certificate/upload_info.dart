import 'dart:async';
import 'package:fasilah_m1/features/admin/certificate/upload_certificate.dart';
import 'package:fasilah_m1/features/admin/cubit/admin_cubit.dart';
import 'package:fasilah_m1/models/subscribe_course_model.dart';
import 'package:fasilah_m1/shared/components/components.dart';
import 'package:fasilah_m1/shared/components/navigator.dart';
import 'package:fasilah_m1/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/components/constants.dart';
import '../../../models/courses_model.dart';

class AddCertificateScreen extends StatefulWidget {
  final SubscribeCourseModel? subscribeCourseModel;
  final CourseModel ?  model;

  const AddCertificateScreen({required this.subscribeCourseModel, required this.model ,super.key});

  @override
  State<AddCertificateScreen> createState() => _AddCertificateScreenState();
}

class _AddCertificateScreenState extends State<AddCertificateScreen> {
  TextEditingController nameController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    nameController =
        TextEditingController(text: widget.subscribeCourseModel!.nameStudent!);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminState>(
      listener: (context, state) {
        if (state is UploadCertificateSuccessState) {
          showToast(
              text: 'upload certificate successfully',
              state: ToastStates.success);
          AdminCubit.get(context).certificateImage == null ;
          AdminCubit.get(context).certificateFile == null ;
          Timer(const Duration(seconds: 1), () {
            navigateTo(
                context,
                UploadCertificate(
                    uidDoc: widget.subscribeCourseModel!.uidCourse! ,
                  model: widget.model,

                ));
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                navigatePop(context);
              },
            ),
            title: const Text('Add Certificate'),
          ),
          backgroundColor: AppColors.white,
          body: SingleChildScrollView(
            child: Container(
              width: width(context, 1),
              height: height(context, 2),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: AppColors.white3,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFieldUser(
                      labelText: 'Student Name',
                      hintText: 'enter Student Name',
                      scure: false,
                      keyType: TextInputType.name,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return ' please , enter Student Name';
                        }
                      },
                      controller: nameController,
                    ),
                    //upload image button
                    const SizedBox(
                      height: 30,
                    ),
                    state is UploadCertificateImageLoadingState
                        ? const Center(child: CircularProgressIndicator())
                        : ButtonTemplate(
                            color: AppColors.lightGreen,
                            text1: 'upload certificate',
                            onPressed: () {
                              AdminCubit.get(context).showBottomSheet(context);
                            },
                            minwidth: width(context, 1.5),
                          ),
                    const SizedBox(
                      height: 30,
                    ),
                    state is UploadCertificateLoadingState
                        ? const Center(child: CircularProgressIndicator())
                        : ButtonTemplate(
                            color: AppColors.brown,
                            text1: 'send',
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                if (AdminCubit.get(context).certificateImage ==
                                    null) {
                                  showToast(
                                      text: 'please , upload certificate ',
                                      state: ToastStates.error);
                                } else {
                                  AdminCubit.get(context).uploadCertificate(
                                    nameStudent: widget
                                        .subscribeCourseModel!.nameStudent!,
                                    uidCourse:
                                        widget.subscribeCourseModel!.uidCourse!,
                                    uidSubscribe: widget
                                        .subscribeCourseModel!.uidSubscribe!,
                                    docUid: widget.subscribeCourseModel!.uid!,
                                    nameCourse:
                                        widget.subscribeCourseModel!.title!,
                                  );
                                }
                              }
                            },
                            minwidth: width(context, 2),
                          ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
