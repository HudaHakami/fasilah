import 'package:fasilah_m1/features/admin/cubit/admin_cubit.dart';
import 'package:fasilah_m1/features/admin/events/accepted_events.dart';
import 'package:fasilah_m1/features/admin/events/waiting_events.dart';
import 'package:fasilah_m1/features/admin/home/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/components/components.dart';
import '../../../shared/components/navigator.dart';
import '../../../shared/styles/colors.dart';
import '../../../shared/styles/styles.dart';

class MangeEventsScreen extends StatefulWidget {
  const MangeEventsScreen({super.key});

  @override
  State<MangeEventsScreen> createState() => _MangeEventsScreenState();
}

class _MangeEventsScreenState extends State<MangeEventsScreen> {
  @override
  void initState() {
    AdminCubit.get(context).getEvents();
    AdminCubit.get(context).getAcceptedEvents();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminState>(
      listener: (context, state) {},
      builder: (context, state) {
        print(AdminCubit.get(context).eventList.length);
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: AppColors.lightGreen,
            appBar: AppBar(
              backgroundColor: AppColors.lightGreen,
              title: const Text(
                'Events',
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
                                    '${AdminCubit.get(context).eventList.length}',
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
                                    '${AdminCubit.get(context).acceptedEventList.length}',
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
                              WaitingEvents(
                                eventlist: AdminCubit.get(context).eventList,
                              ),
                              AdminAcceptedEvents(
                                acceptEventList:
                                AdminCubit.get(context).acceptedEventList,
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

