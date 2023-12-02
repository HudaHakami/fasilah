import 'package:fasilah_m1/features/Doctor/cubit/user_cubit.dart';
import 'package:fasilah_m1/features/Doctor/request/events/refused.dart';
import 'package:fasilah_m1/features/Doctor/request/events/waiting.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../shared/components/constants.dart';
import '../../../../shared/styles/colors.dart';
import 'accepted.dart';

class EventsStatus extends StatefulWidget {
  const EventsStatus({super.key});

  @override
  State<EventsStatus> createState() => _EventsStatusState();
}

class _EventsStatusState extends State<EventsStatus>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.white2,
        body: SingleChildScrollView(
          physics:
          const ClampingScrollPhysics(parent: NeverScrollableScrollPhysics()),
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
                  Expanded(
                    child: SizedBox(
                      child: TabBarView(
                        children: [
                          WaitingEvents(waitingEventsList: UserCubit.get(context).myWaitingEventsList),
                          AcceptedEvents(acceptedEventsList: UserCubit.get(context).myAcceptedEventsList),
                          RefusedEvents(refusedEventsList:  UserCubit.get(context).myRefusedEventsList),
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
