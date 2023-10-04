import 'package:fasilah_m1/features/Doctor/request/courses/refused.dart';
import 'package:fasilah_m1/features/Doctor/request/courses/waiting.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../shared/components/constants.dart';
import '../../../../shared/styles/colors.dart';
import 'accepted.dart';

class CoursesStatus extends StatefulWidget {
  const CoursesStatus({super.key});

  @override
  State<CoursesStatus> createState() => _CoursesStatusState();
}

class _CoursesStatusState extends State<CoursesStatus>
    with TickerProviderStateMixin {




  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
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
                            text: 'waiting',
                          ),
                        ),
                        SizedBox(
                          width: width(context, 3.5),
                          child: const Tab(
                            text: 'accepted',
                          ),
                        ),
                        SizedBox(
                          width: width(context, 3.5),
                          child: const Tab(
                            text: 'refused',
                          ),
                        ),
                      ],
                    )),
                  ),
                  const Expanded(
                    child: SizedBox(
                      child: TabBarView(
                        children: [

                          WaitingCourses(),
                          AcceptedCourses(),
                          RefusedCourses(),
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
  }
}
