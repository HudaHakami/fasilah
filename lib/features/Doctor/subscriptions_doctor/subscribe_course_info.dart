import 'package:fasilah_m1/features/Doctor/cubit/user_cubit.dart';
import 'package:fasilah_m1/models/subscribe_course_model.dart';
import 'package:fasilah_m1/shared/components/components.dart';
import 'package:fasilah_m1/shared/components/navigator.dart';
import 'package:fasilah_m1/shared/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/styles/colors.dart';
import '../../../shared/styles/images.dart';

class UserCoursesSubscribeInfo extends StatefulWidget {

  final SubscribeCourseModel courseModel;

  const UserCoursesSubscribeInfo(
      {required this.courseModel, super.key});
  @override
  State<UserCoursesSubscribeInfo> createState() => _UserCoursesSubscribeInfoState();
}

class _UserCoursesSubscribeInfoState extends State<UserCoursesSubscribeInfo> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.lightGreen,
          appBar: AppBar(
            title: const Text('Course'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                navigatePop(context);
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
                        child:  ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25),
                          ),
                          child: Image(
                            image: NetworkImage(widget.courseModel.image!),

                            fit: BoxFit.fill,
                          ),
                        ),
                      ),

                    ],
                  ),
                  DataItem(
                    text: widget.courseModel.title,
                    image: name,
                    textStyle: AppTextStyles.smSectionTitles,
                  ),
                  DataItem(
                      text: widget.courseModel.nameInstructor,
                      image: instructor,
                      textStyle: AppTextStyles.smSectionTitles),
                  DataItem(
                      text: widget.courseModel.date![0],
                      image: date,
                      textStyle: AppTextStyles.smSectionTitles),
                  DataItem(
                      text: widget.courseModel.time,
                      image: time,
                      textStyle: AppTextStyles.smSectionTitles),
                  DataItem(
                      text: widget.courseModel.numOfStudent,
                      image: audience,
                      textStyle: AppTextStyles.smSectionTitles),
                  DataItem(
                      text: widget.courseModel.type,
                      image: learn,
                      textStyle: AppTextStyles.smSectionTitles),
                  DataItem(
                      text: widget.courseModel.location,
                      image: location,
                      textStyle: AppTextStyles.smSectionTitles),

                    const SizedBox(),

                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
