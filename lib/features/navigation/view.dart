// ignore_for_file: library_private_types_in_public_api

import 'package:fasilah_m1/features/Doctor/certificate/view.dart';
import 'package:fasilah_m1/features/Doctor/request/view.dart';
import 'package:fasilah_m1/features/Doctor/subscriptions_doctor/view.dart';
import 'package:fasilah_m1/shared/styles/colors.dart';
import 'package:fasilah_m1/shared/styles/styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../shared/styles/images.dart';
import '../../shared/network/local/constant.dart';
import '../Doctor/home/view.dart';
import '../Doctor/subscriptions_student/view.dart';

class NavigationScreen extends StatefulWidget {
  late final List<Widget> pages;

  NavigationScreen({
    Key? key,
  }) : super(key: key) {
    pages = [
      const DoctorHomeScreen(),
      type == 'student'?  const SubscriptionStudentScreen() : const SubscriptionDoctorScreen(),
      const RequestScreen(),
      const MyCertificate(),
    ];
  }

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.pages[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        backgroundColor: AppColors.lightGreen,
        selectedLabelStyle: AppTextStyles.w400s,
       unselectedLabelStyle: AppTextStyles.w400s,
       unselectedItemColor: AppColors.black,
       selectedItemColor: AppColors.brown,
        iconSize: 40,
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          setState(() {
            index = value;
            if (kDebugMode) {
              print(index);
            }
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: ImageIcon(
                 AssetImage(name),
                size: 25,

              ),
              label: 'courses/events'),
          BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage(subscribe),
                size: 25,
              ),
              label: 'Subscriptions'),
          BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage(requests),
                size: 25,

              ),
              label: 'requests'),
          BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage(certificate),
                size: 25,
              ),
              label: 'certificate'),
        ],
      ),
    );
  }
}
