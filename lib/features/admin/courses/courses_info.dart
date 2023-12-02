import 'dart:async';

import 'package:fasilah_m1/features/admin/courses/view.dart';
import 'package:fasilah_m1/features/admin/cubit/admin_cubit.dart';
import 'package:fasilah_m1/models/courses_model.dart';
import 'package:fasilah_m1/shared/components/components.dart';
import 'package:fasilah_m1/shared/components/navigator.dart';
import 'package:fasilah_m1/shared/network/local/constant.dart';
import 'package:fasilah_m1/shared/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/styles/colors.dart';
import '../../../shared/styles/images.dart';
import '../certificate/upload_certificate.dart';

class CoursesInfo extends StatefulWidget {
  final String? type;
  final CourseModel? courseModel;


  const CoursesInfo({required this.type, required this.courseModel, super.key});

  @override
  State<CoursesInfo> createState() => _CoursesInfoState();
}

class _CoursesInfoState extends State<CoursesInfo> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminState>(
      listener: (context, state) {
        if (state is AcceptCoursesSuccessState) {
          showToast(
              text: 'you accepted successfully', state: ToastStates.success);
          Timer(const Duration(seconds: 1), () {
            AdminCubit.get(context).courseList.clear();
            AdminCubit.get(context).getCourses();
            navigateTo(context, const MangeCoursesScreen());
          });
        }
        if (state is RefuseCoursesSuccessState) {
          showToast(
              text: 'you refused successfully', state: ToastStates.success);
          Timer(const Duration(seconds: 1), () {
            AdminCubit.get(context).courseList.clear();
            AdminCubit.get(context).getCourses();
            navigateTo(context, const MangeCoursesScreen());
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.lightGreen,
          appBar: AppBar(
            title: const Text('Course'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                navigateTo(context, const MangeCoursesScreen());
              },
            ),
          ),
          body: Container(
            height: height(context, 1, hasAppBar: true),
            width: width(context, 1),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              border: Border.all(color: AppColors.lightGreen, width: 2),
              color: AppColors.white2,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // image course
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      SizedBox(
                        height: height(context, 2.5, hasAppBar: true),
                        width: width(context, 1),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25),
                          ),
                          child: Image(
                            image: NetworkImage(widget.courseModel!.image!),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      type == 'student'
                          ? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5),
                        child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.favorite_border,
                              color: AppColors.white,
                              size: 35,
                            )),
                      )
                          : const SizedBox(),
                    ],
                  ),
                  DataItem(
                    text: widget.courseModel!.title!,
                    image: name,
                    textStyle: AppTextStyles.smSectionTitles,
                  ),
                  DataItem(
                      text: widget.courseModel!.nameInstructor!,
                      image: instructor,
                      textStyle: AppTextStyles.smSectionTitles),
                  DataItem(
                      text: widget.courseModel!.date![0],
                      image: date,
                      textStyle: AppTextStyles.smSectionTitles),
                  DataItem(
                      text: widget.courseModel!.time!,
                      image: time,
                      textStyle: AppTextStyles.smSectionTitles),
                  DataItem(
                      text: widget.courseModel!.numOfStudent!,
                      image: audience,
                      textStyle: AppTextStyles.smSectionTitles),
                  DataItem(
                      text: widget.courseModel!.type!,
                      image: learn,
                      textStyle: AppTextStyles.smSectionTitles),
                  DataItem(
                      text: widget.courseModel!.location!,
                      image: location,
                      textStyle: AppTextStyles.smSectionTitles),

                  if (widget.type == 'book') ...[
                    ButtonTemplate(
                        minwidth: width(context, 2),
                        color: AppColors.brown,
                        text1: 'subscribe now',
                        onPressed: () {})
                  ] else if (widget.type == 'accepted') ...[
                    ButtonTemplate(
                        minwidth: width(context, 2),
                        color: AppColors.brown,
                        text1: 'view enrollees',
                        onPressed: () {
                          navigateTo(
                              context,
                              UploadCertificate(
                                uidDoc: widget.courseModel!.uid!,
                                model: widget.courseModel!,
                              ));
                        }),
                  ] else if (widget.type == 'waiting') ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        state is AcceptCoursesLoadingState
                            ? const Center(child: CircularProgressIndicator())
                            : SmallButtonTemplate(
                            color: AppColors.green,
                            text1: 'accept',
                            onPressed: () {
                              AdminCubit.get(context).acceptCourse(
                                uidDoc: widget.courseModel!.uid!,
                              );
                            }),
                        state is RefuseCoursesLoadingState
                            ? const Center(child: CircularProgressIndicator())
                            : SmallButtonTemplate(
                            color: AppColors.darkRed,
                            text1: 'refuse',
                            onPressed: () {
                              AdminCubit.get(context).refuseCourse(
                                uidDoc: widget.courseModel!.uid!,
                              );
                            }),
                      ],
                    )
                  ] else ...[
                    const SizedBox(),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
