import 'package:flutter/material.dart';
import 'package:fasilah_m1/shared/components/navigator.dart';
import 'package:fasilah_m1/shared/styles/images.dart';
import 'package:fasilah_m1/features/admin/courses/courses_info.dart';

import '../../../shared/components/constants.dart';
import '../../../shared/styles/colors.dart';
import '../../../shared/styles/styles.dart';

class AcceptedCourses extends StatefulWidget {
  const AcceptedCourses({super.key});

  @override
  State<AcceptedCourses> createState() => _AcceptedCoursesState();
}

class _AcceptedCoursesState extends State<AcceptedCourses> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return InkWell(
          onTap: (){
            navigateTo(context, const CoursesInfo(type: 'accepted'));
          },
          child: Container(
            width: width(context, 1),
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10,),
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
                        onPressed: () {},
                        icon: const Icon(Icons.stop_circle,
                          color: AppColors.green ,
                          size: 25,
                        )),
                    IconButton(
                        onPressed: () {},
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
      itemCount: 3,
    );
  }
}

