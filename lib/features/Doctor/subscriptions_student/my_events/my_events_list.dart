import 'package:fasilah_m1/features/Doctor/subscriptions_student/my_events/new_evets_list.dart';
import 'package:fasilah_m1/features/Doctor/subscriptions_student/my_events/old_events_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../shared/components/constants.dart';
import '../../../../shared/styles/colors.dart';
class MyEvents extends StatefulWidget {
  const MyEvents({super.key});

  @override
  State<MyEvents> createState() => _MyEventsState();
}

class _MyEventsState extends State<MyEvents> {
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
                        children: [
                          NewEventList(),
                          OldEventList(),
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
