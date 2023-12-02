import 'package:fasilah_m1/features/Doctor/cubit/user_cubit.dart';
import 'package:fasilah_m1/features/student/favorite/favorite_course_list.dart';
import 'package:fasilah_m1/features/student/favorite/favorite_event_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/components/navigator.dart';
import '../../../shared/styles/colors.dart';
class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    UserCubit.get(context).getFavouriteCourse();
    UserCubit.get(context).getFavouriteEvent();
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
          child: Scaffold(
            backgroundColor: AppColors.lightGreen,
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  navigatePop(context);
                },
              ),
              title: const Text('Favorite'),
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
                      Expanded(
                        child: SizedBox(
                          child: TabBarView(
                            children: [
                              FavouriteCoursesScreen(courseList: UserCubit.get(context).favouriteCoursesList),
                              FavoriteEventsScreen(eventsList: UserCubit.get(context).favouriteEventList),
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
