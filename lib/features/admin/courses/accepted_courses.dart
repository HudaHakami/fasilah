import 'package:fasilah_m1/features/admin/courses/courses_info.dart';
import 'package:fasilah_m1/features/admin/cubit/admin_cubit.dart';
import 'package:fasilah_m1/shared/components/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/courses_model.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/styles/colors.dart';
import '../../../shared/styles/styles.dart';

class AcceptedCourses extends StatefulWidget {
  final List<CourseModel>  coursesList;

  const AcceptedCourses({ required this.coursesList, super.key});

  @override
  State<AcceptedCourses> createState() => _AcceptedCoursesState();
}

class _AcceptedCoursesState extends State<AcceptedCourses> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminState>(
      listener: (context, state) {
        if (state is DeleteCoursesSuccessState) {
          showToast(text: 'deleted successfully', state: ToastStates.success);
        }
        if (state is StopCoursesSuccessState) {
          showToast(text: 'stopped successfully', state: ToastStates.success);
        }
      },
      builder: (context, state) {
        return ListView.builder(
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                navigateTo(
                    context,
                    CoursesInfo(
                      type: 'accepted',
                      courseModel: widget.coursesList[index],

                    ));
              },
              child: Container(
                width: width(context, 1),
                margin:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                    color: AppColors.white2,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: AppColors.green, width: 1.5),
                    boxShadow: const [
                      BoxShadow(
                          color: AppColors.lightGrey,
                          blurRadius: 1,
                          spreadRadius: 1)
                    ]),
                child: Row(
                  children: [
                    SizedBox(
                        height: 100,
                        width: 90,
                        child: Image(
                          image: NetworkImage(widget.coursesList[index].image!),
                          fit: BoxFit.fill,
                        )),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.coursesList[index].title!,
                          style: AppTextStyles.name,
                        ),
                        Text(
                          widget.coursesList[index].nameInstructor!,
                          style: AppTextStyles.smTitles,
                        ),
                        Text(
                          widget.coursesList[index].date![0],
                          style: AppTextStyles.smTitles,
                        ),
                      ],
                    ),
                    const Expanded(child: SizedBox()),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              AdminCubit.get(context).stopCourse(
                                  uidDoc: widget.coursesList[index].uid!);
                            },
                            icon: const Icon(
                              Icons.stop_circle,
                              color: AppColors.green,
                              size: 25,
                            )),
                        IconButton(
                            onPressed: () {
                              AdminCubit.get(context).deleteCourse(
                                  uidDoc: widget.coursesList[index].uid!);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: AppColors.darkRed,
                              size: 25,
                            ))
                      ],
                    )
                  ],
                ),
              ),
            );
          },
          itemCount: widget.coursesList.length,
        );
      },
    );
  }
}

