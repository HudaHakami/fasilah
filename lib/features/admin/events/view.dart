//import 'package:fasilah/features/admin/events/accepted_events.dart';
//import 'package:fasilah/features/admin/events/waiting_events.dart';
import 'package:flutter/material.dart';
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
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.lightGreen,
        appBar: AppBar(
          backgroundColor: AppColors.lightGreen,
          title: const Text('Events',),

          leading: IconButton(
            onPressed: () => navigatePop(context),
            icon: const Icon(Icons.arrow_back),
          ),
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
                      tabs:  <Widget>[
                        Tab(
                          child:  Row(
                            children: [
                              const Text(
                                'Waiting',
                              ),
                              Box(
                                color: AppColors.green,
                                height: 40,
                                width: 40,
                                text:
                                '3',
                                dirction: Alignment.center,
                              )
                            ],
                          ) ,
                        ),  Tab(
                          child:  Row(
                            children: [
                              const Text(
                                'Accepted',
                              ),
                              Box(
                                color: AppColors.green,
                                height: 40,
                                width: 40,
                                text:
                                '3',
                                style: AppTextStyles.name,
                                dirction: Alignment.center,
                              )
                            ],
                          ) ,
                        ),

                      ],
                    )),
                  ),
                  const Expanded(
                    child: SizedBox(





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
