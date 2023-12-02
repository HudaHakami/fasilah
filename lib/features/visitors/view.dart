import 'package:fasilah_m1/features/Doctor/cubit/user_cubit.dart';
import 'package:fasilah_m1/features/registration/welcome/view.dart';
import 'package:fasilah_m1/features/visitors/events_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/components/components.dart';
import '../../shared/components/navigator.dart';
import '../../shared/styles/colors.dart';

class VisitorScreen extends StatefulWidget {
  const VisitorScreen({super.key});

  @override
  State<VisitorScreen> createState() => _VisitorScreenState();
}

class _VisitorScreenState extends State<VisitorScreen> {
  TextEditingController searchController = TextEditingController();
  String filter = '';

  void initState() {
    searchController.addListener(() {
      filter = searchController.text;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return DefaultTabController(
          length: 1,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Welcome'),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  navigateTo(context, const WelcomeScreen());
                },
              ),
            ),
            body: SingleChildScrollView(
              physics: const ClampingScrollPhysics(
                  parent: NeverScrollableScrollPhysics()),
              child: Column(
                children: [
                  SearchTextField(
                    text: 'search',
                    controller: searchController,
                  ),
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
                          isScrollable: false,
                          tabs: const <Widget>[
                            Tab(
                              text: 'Events',
                            ),
                          ],
                        )),
                      ),
                      Expanded(
                        child: SizedBox(
                          child: TabBarView(
                            children: [
                              EventsScreen(
                                  eventsList:
                                  UserCubit.get(context).eventsVisitorList,
                                  filter: filter),
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
