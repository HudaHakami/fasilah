import '../../../shared/components/navigator.dart';
import '../../../shared/styles/images.dart';
import 'package:flutter/material.dart';

import '../../../shared/components/constants.dart';
import '../../../shared/styles/colors.dart';
import '../../../shared/styles/styles.dart';
import 'courses_info.dart';

class WaitingCourses extends StatefulWidget {
  const WaitingCourses({super.key});

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                  height: 100,
                  width: 90,
                  child: Image(image: AssetImage(course),)
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'name of course',
                    style: AppTextStyles.name,
                  ),
                  Text(
                    'name of instructor',
                    style: AppTextStyles.smTitles,
                  ),
                  Text(
                    'date',
                    style: AppTextStyles.smTitles,
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                       navigateTo(context,  const CoursesInfo(type: 'waiting',));
                      },
                      icon: const Icon(Icons.arrow_forward_ios,
                        color: AppColors.green ,
                        size: 25,
                      )),
                ],
              )
            ],
          ),
        );
      },
      itemCount: 3,
    );
  }
}