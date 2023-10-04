import 'package:fasilah_m1/features/Doctor/subscriptions_student/my_courses/my_courses_list.dart';
import 'package:fasilah_m1/features/Doctor/subscriptions_student/my_events/my_events_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/components/constants.dart';
import '../../../shared/styles/colors.dart';

class SubscriptionStudentScreen extends StatefulWidget {
  const SubscriptionStudentScreen({super.key});

  @override
  State<SubscriptionStudentScreen> createState() => _SubscriptionStudentScreenState();
}

class _SubscriptionStudentScreenState extends State<SubscriptionStudentScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.lightGreen,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Subscription'),
        ),
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(
              parent: NeverScrollableScrollPhysics()),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 1,
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
                        SizedBox(
                          width: width(context, 2.5),
                          child: const Tab(
                            text: 'Courses',
                          ),
                        ),
                        SizedBox(
                          width: width(context, 2.5),
                          child: const Tab(
                            text: 'Events',
                          ),
                        ),
                      ],
                    )),
                  ),
                  const Expanded(
                    child: SizedBox(
                      child: TabBarView(
                        children: [
                          MyCourses(),
                          MyEvents(),
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
