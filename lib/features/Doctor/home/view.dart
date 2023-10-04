import 'package:fasilah_m1/features/Doctor/home/events_list.dart';
import 'package:fasilah_m1/features/Doctor/profile/view.dart';
import 'package:fasilah_m1/shared/components/components.dart';
import 'package:fasilah_m1/features/student/favorite/view.dart';
import 'package:fasilah_m1/shared/components/constants.dart';
import 'package:fasilah_m1/shared/components/navigator.dart';
import 'package:fasilah_m1/shared/styles/colors.dart';
import 'package:fasilah_m1/shared/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/network/local/constant.dart';
import 'courses_list.dart';

class DoctorHomeScreen extends StatefulWidget {
  const DoctorHomeScreen({super.key});

  @override
  State<DoctorHomeScreen> createState() => _DoctorHomeScreenState();
}

class _DoctorHomeScreenState extends State<DoctorHomeScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: Drawer(
          backgroundColor: AppColors.white3,
          child: Column(
            children: [
              DrawerHeader(
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: const BoxDecoration(),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundColor: AppColors.lightGreen,
                      child: ImageIcon(
                        AssetImage('assets/images/user.png'),
                        size: 70,
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Welcome Doctor',
                      style: AppTextStyles.name,
                    )
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: Text(
                  'Profile',
                  style: AppTextStyles.name,
                ),
                onTap: () {
                  navigateTo(context, const DoctorProfile());
                },
              ),
              type == 'student' ?    ListTile(
                leading: const Icon(Icons.favorite),
                title: Text(
                  'Favorite',
                  style: AppTextStyles.name,
                ),
                onTap: () {
                  navigateTo(context, const FavoriteScreen());
                },
              ) : const SizedBox(),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: ListTile(
                    leading: const Icon(Icons.logout),
                    title: Text(
                      'Log out',
                      style: AppTextStyles.name,
                    ),
                    onTap: () {
                      navigatePop(context);
                      navigatePop(context);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: const Text('Welcome'),
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
                          CoursesScreen(),
                          EventsScreen(),
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
