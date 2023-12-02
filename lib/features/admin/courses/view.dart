import 'package:fasilah_m1/features/admin/courses/waiting_courses.dart';
import 'package:fasilah_m1/features/admin/home/view.dart';
import 'package:fasilah_m1/shared/components/navigator.dart';
import 'package:fasilah_m1/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/components/components.dart';
import '../../../shared/styles/styles.dart';
import '../cubit/admin_cubit.dart';
import 'accepted_courses.dart';

class MangeCoursesScreen extends StatefulWidget {
  const MangeCoursesScreen({super.key});

  @override
  State<MangeCoursesScreen> createState() => _MangeCoursesScreenState();
}

class _MangeCoursesScreenState extends State<MangeCoursesScreen> {
  @override
  void initState() {
    AdminCubit.get(context).getCourses();
    AdminCubit.get(context).getAcceptedCourses();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminState>(
      listener: (context, state) {},
      builder: (context, state) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: AppColors.lightGreen,
            appBar: AppBar(
              title: const Text(
                'Courses',
              ),
              leading: IconButton(
                onPressed: () => navigateTo(context, const AdminHomeScreen()),
                icon: const Icon(Icons.arrow_back),
              ),
            ),
            body: SingleChildScrollView(
              physics: const ClampingScrollPhysics(
                  parent: NeverScrollableScrollPhysics()),
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 1.1,
                    decoration: const BoxDecoration(
                      color: AppColors.white2,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                      border: Border.fromBorderSide(
                          BorderSide(color: AppColors.lightGreen, width: 3)),
                    ),
                    child: Column(children: [
                      SizedBox(
                        height: 65,
                        child: (TabBar(
                          labelColor: AppColors.brown,
                          unselectedLabelColor: AppColors.greyDark,
                          indicatorColor: AppColors.brown,
                          labelStyle: GoogleFonts.tajawal(
                            textStyle: const TextStyle(
                                fontSize: 20,
                                height: 1.5,
                                fontWeight: FontWeight.w800),
                          ),
                          isScrollable: true,
                          tabs: <Widget>[
                            Tab(
                              child: Row(
                                children: [
                                  const Text(
                                    'Waiting',
                                  ),
                                  Box(
                                    color: AppColors.green,
                                    height: 40,
                                    width: 40,
                                    text:
                                    '${AdminCubit.get(context).courseList.length}',
                                    dirction: Alignment.center,
                                  )
                                ],
                              ),
                            ),
                            Tab(
                              child: Row(
                                children: [
                                  const Text(
                                    'Accepted',
                                  ),
                                  Box(
                                    color: AppColors.green,
                                    height: 40,
                                    width: 40,
                                    text:
                                    '${AdminCubit.get(context).acceptedCourseList.length}',
                                    style: AppTextStyles.name,
                                    dirction: Alignment.center,
                                  )
                                ],
                              ),
                            ),
                          ],
                        )),
                      ),
                      Expanded(
                        child: SizedBox(
                          child: TabBarView(
                            children: [
                              WaitingCourses(
                                coursesList: AdminCubit.get(context).courseList,
                              ),
                              AcceptedCourses(
                                coursesList:
                                AdminCubit.get(context).acceptedCourseList,
                              )
                            ],
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
      },
    );
  }
}
