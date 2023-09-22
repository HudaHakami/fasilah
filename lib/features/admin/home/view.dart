import 'package:fasilah_m1/features/admin/courses/view.dart';
import 'package:fasilah_m1/features/admin/events/view.dart';
import 'package:fasilah_m1/shared/components/navigator.dart';
import 'package:fasilah_m1/shared/styles/images.dart';
import 'package:flutter/material.dart';
import '../../../shared/components/components.dart';
import '../../../shared/styles/colors.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.lightGreen,
          title: const Text(
            'Welcome',
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.login_outlined),
              onPressed: () => navigatePop(context),
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
  }
}
