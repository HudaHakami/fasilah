import 'package:fasilah_m1/features/Doctor/request/events/add_event.dart';
import 'package:fasilah_m1/shared/components/navigator.dart';
import 'package:fasilah_m1/shared/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/components/constants.dart';
import '../../../shared/styles/colors.dart';
import 'courses/add_course.dart';
import 'courses/view.dart';
import 'events/view.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.lightGreen,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Request'),
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
                          CoursesStatus(),
                          EventsStatus(),
                        ],
                      ),
                    ),
                  ),
                ]),
              )
            ],
          ),
        ),
        floatingActionButtonLocation: ExpandableFab.location,
        floatingActionButton: ExpandableFab(
          fanAngle: 90,
          type: ExpandableFabType.up,
          distance: 60,
          openButtonBuilder: RotateFloatingActionButtonBuilder(
            child: const Icon(Icons.add),
            fabSize: ExpandableFabSize.small,
            foregroundColor: AppColors.white,
            backgroundColor: AppColors.lightGreen,
            shape: const CircleBorder(),
          ),
          closeButtonBuilder: FloatingActionButtonBuilder(
            size: 56,
            builder: (BuildContext context, void Function()? onPressed,
                Animation<double> progress) {
              return IconButton(
                onPressed: onPressed,
                icon: const Icon(
                  Icons.close,
                  size: 40,
                  color: AppColors.lightGreen,
                ),
              );
            },
          ),
          children: [
            FloatingActionButton.extended(
              backgroundColor: AppColors.lightGreen,
              icon: const Icon(Icons.add),
              heroTag: null,
              label: Text(
                'course',
                style: AppTextStyles.button,
              ),
              onPressed: () {
                navigateTo(context, const AddCourseScreen());
              },
            ),
            FloatingActionButton.extended(
              backgroundColor: AppColors.lightGreen,
              icon: const Icon(Icons.add),
              heroTag: null,
              label: Text(
                'event',
                style: AppTextStyles.button,
              ),
              onPressed: () {
                navigateTo(context, const AddEvent());
              },
            ),
          ],
        ),
      ),
    );
  }
}
