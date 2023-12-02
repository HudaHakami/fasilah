import 'package:fasilah_m1/models/courses_model.dart';
import 'package:flutter/material.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/components/navigator.dart';
import '../../../shared/styles/colors.dart';
import '../../../shared/styles/styles.dart';
import '../../Doctor/user_course_info.dart';

class FavouriteCoursesScreen extends StatefulWidget {
  final List<CourseModel> courseList;

  const FavouriteCoursesScreen(
      {required this.courseList,  super.key});

  @override
  State<FavouriteCoursesScreen> createState() => _FavouriteCoursesScreenState();
}

class _FavouriteCoursesScreenState extends State<FavouriteCoursesScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return buildCourseBox(widget.courseList[index]);
      },
      itemCount: widget.courseList.length,
    );
  }

  Widget buildCourseBox(CourseModel model ) {
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
          SizedBox(
              height: 100,
              width: 90,
              child: Image(
                image: NetworkImage(model.image!),
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
                model.title!,
                style: AppTextStyles.name,
              ),
              Text(
                model.nameInstructor!,
                style: AppTextStyles.smTitles,
              ),
              Text(
                model.date![0],
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
                        UserCoursesInfo(
                          type: 'favourite',
                          courseModel: model,
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
    ) ;
  }

}
