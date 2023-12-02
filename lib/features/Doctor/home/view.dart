import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fasilah_m1/features/Doctor/cubit/user_cubit.dart';
import 'package:fasilah_m1/features/Doctor/home/events_list.dart';
import 'package:fasilah_m1/features/Doctor/profile/view.dart';
import 'package:fasilah_m1/features/registration/welcome/view.dart';
import 'package:fasilah_m1/features/student/favorite/view.dart';
import 'package:fasilah_m1/shared/components/components.dart';
import 'package:fasilah_m1/shared/components/constants.dart';
import 'package:fasilah_m1/shared/components/navigator.dart';
import 'package:fasilah_m1/shared/network/local/shared_preferences.dart';
import 'package:fasilah_m1/shared/styles/colors.dart';
import 'package:fasilah_m1/shared/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  String filter = '';

  @override
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
          length: 2,
          child: ConditionalBuilder(
              condition: UserCubit.get(context).model != null,
              builder: (context) {
                return Scaffold(
                  drawer: Drawer(
                    backgroundColor: AppColors.white3,
                    child: Column(
                      children: [
                        DrawerHeader(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
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
                                '  Welcome ${UserCubit.get(context).model!.name!}',
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
                            navigateTo(context,  DoctorProfile(userModel: UserCubit.get(context).model!,));
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.favorite),
                          title: Text(
                            'Favorite',
                            style: AppTextStyles.name,
                          ),
                          onTap: () {
                            navigateTo(context, const FavoriteScreen());
                          },
                        ),

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
                                CacheHelper.removeToken(key: 'uid');
                                CacheHelper.removeToken(key: 'type');
                                uId = '';
                                type = '';
                                navigateAndReplace(
                                    context, const WelcomeScreen());
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  appBar: AppBar(
                    title: Text(
                      'Welcome ${UserCubit.get(context).model!.name!}',
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
                          height: MediaQuery.of(context).size.height / 1.1,
                          decoration: const BoxDecoration(
                            color: AppColors.white2,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25),
                            ),
                            border: Border.fromBorderSide(BorderSide(
                                color: AppColors.lightGreen, width: 3)),
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
                            Expanded(
                              child: SizedBox(
                                child: TabBarView(
                                  children: [
                                    CoursesScreen(
                                      courseList:
                                      UserCubit.get(context).coursesList,
                                      filter: filter,
                                    ),
                                    EventsScreen(
                                      eventsList:
                                      UserCubit.get(context).eventsList,
                                      filter: filter,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ]),
                        )
                      ],
                    ),
                  ),
                );
              },
              fallback: (context) {
                return Scaffold(
                  drawer: Drawer(
                    backgroundColor: AppColors.white3,
                    child: Column(
                      children: [
                        DrawerHeader(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
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
                                '  Welcome ${UserCubit.get(context).model!.name!}',
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
                            navigateTo(context,  DoctorProfile(userModel: UserCubit.get(context).model!));
                          },
                        ),
                        type == 'student'
                            ? ListTile(
                          leading: const Icon(Icons.favorite),
                          title: Text(
                            'Favorite',
                            style: AppTextStyles.name,
                          ),
                          onTap: () {
                            navigateTo(context, const FavoriteScreen());
                          },
                        )
                            : const SizedBox(),
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
                    title: Text(
                      'Welcome ${UserCubit.get(context).model!.name!}',
                    ),
                  ),
                  body: const LinearProgressIndicator(),
                );
              }),
        );
      },
    );
  }
}
