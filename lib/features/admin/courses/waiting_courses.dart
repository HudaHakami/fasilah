import 'package:fasilah_m1/models/courses_model.dart';
import 'package:fasilah_m1/shared/components/navigator.dart';
import 'package:flutter/material.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/styles/colors.dart';
import '../../../shared/styles/styles.dart';
import 'courses_info.dart';

class WaitingCourses extends StatefulWidget {
  final List<CourseModel> coursesList;

  const WaitingCourses({required this.coursesList, super.key});

  @override
  State<WaitingCourses> createState() => _WaitingCoursesState();
}

class _WaitingCoursesState extends State<WaitingCourses> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Container(
          width: width(context, 1),
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
              color: AppColors.white2,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: AppColors.green, width: 1.5),
              boxShadow: const [
                BoxShadow(
                    color: AppColors.lightGrey, blurRadius: 1, spreadRadius: 1)
              ]),
          child: Row(
            children: [
              SizedBox(
                  height: 100,
                  width: 90,
                  child: Image(
                    image: NetworkImage(
                        widget.coursesList[index].image!),
                    fit: BoxFit.fill,
                  )),
              const SizedBox(width: 20,),
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
                        navigateTo(
                            context,
                            CoursesInfo(
                              type: 'waiting',
                              courseModel: widget.coursesList[index],
                            ));
                      },
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.green,
                        size: 25,
                      )),
                ],
              )
            ],
          ),
        );
      },
      itemCount: widget.coursesList.length,
    );
  }
}
