import 'package:fasilah/features/Doctor/subscriptions_student/my_courses/new_courses_list.dart';
import 'package:fasilah/features/Doctor/subscriptions_student/my_courses/old_courses_llist.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../shared/components/constants.dart';
import '../../../../shared/styles/colors.dart';

class MyCourses extends StatefulWidget {
  const MyCourses({super.key});

  @override
  State<MyCourses> createState() => _MyCoursesState();
}

class _MyCoursesState extends State<MyCourses> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.white2,
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(
              parent: NeverScrollableScrollPhysics()),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 1.5,
                child: Column(children: [
                  SizedBox(
                    height: 65,
                    child: (TabBar.secondary(
                      labelColor: AppColors.brown,
                      unselectedLabelColor: AppColors.greyDark,
                      indicatorColor: AppColors.brown,
                      labelStyle: GoogleFonts.tajawal(
                        textStyle: const TextStyle(
                            fontSize: 20,
                            height: 1.5,
                            fontWeight: FontWeight.w800),
                      ),
                      isScrollable: false,
                      tabs: <Widget>[
                        SizedBox(
                          width: width(context, 3.5),
                          child: const Tab(
                            text: 'new',
                          ),
                        ),
                        SizedBox(
                          width: width(context, 3.5),
                          child: const Tab(
                            text: 'old',
                          ),
                        ),
                      ],
                    )),
                  ),
                  const Expanded(
                    child: SizedBox(
                      child: TabBarView(
                        children: [NewCoursesList(), OldCoursesList()],
                      ),
                    ),
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
