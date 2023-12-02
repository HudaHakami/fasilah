import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fasilah_m1/features/admin/courses/view.dart';
import 'package:fasilah_m1/features/admin/cubit/admin_cubit.dart';
import 'package:fasilah_m1/features/admin/events/view.dart';
import 'package:fasilah_m1/features/registration/welcome/view.dart';
import 'package:fasilah_m1/shared/components/navigator.dart';
import 'package:fasilah_m1/shared/network/local/constant.dart';
import 'package:fasilah_m1/shared/network/local/shared_preferences.dart';
import 'package:fasilah_m1/shared/styles/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/components/components.dart';
import '../../../shared/styles/colors.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
  void initState() {
    print(uId);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      AdminCubit()
        ..getData(uId: uId!),
      child: BlocConsumer<AdminCubit, AdminState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return ConditionalBuilder(
              condition: state is GetDataSuccessState, builder: (context) {
            return Scaffold(
              appBar: AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: AppColors.lightGreen,
                  title: Text(
                    'Welcome ${AdminCubit
                        .get(context)
                        .model!
                        .name!}',
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.login_outlined),
                      onPressed: () => {
                        CacheHelper.removeToken(key: 'uid'),
                        CacheHelper.removeToken(key: 'type'),
                        navigateAndReplace(context, const WelcomeScreen()),

                      },
                    ),
                  ]),
              body: BackgroundBox(
                  widget: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      ItemBox(
                        onPressed: () {
                          navigateTo(context, const MangeCoursesScreen());
                        },
                        text: 'Mange Courses',
                        icon: arrow,
                      ),
                      ItemBox(
                          onPressed: () {
                            navigateTo(context, const MangeEventsScreen());
                          },
                          text: 'Mange Events',
                          icon: arrow),
                    ],
                  )),
            );
          }, fallback: (context) {
            return const Scaffold(
              body: LinearProgressIndicator(),
            );
          });
        },
      ),
    );
  }
}
