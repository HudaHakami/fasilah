// ignore_for_file: library_private_types_in_public_api

import 'package:fasilah_m1/features/Doctor/cubit/user_cubit.dart';
import 'package:fasilah_m1/shared/network/local/constant.dart';

import 'package:fasilah_m1/shared/styles/colors.dart';
import 'package:fasilah_m1/shared/styles/styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/styles/images.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({
    Key? key,
  }) : super(key: key);

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = UserCubit.get(context);
        return Scaffold(
          body: type == 'doctor'
              ? cubit.pages[cubit.currentIndex]
              : cubit.pagesStudent[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            backgroundColor: AppColors.lightGreen,
            selectedLabelStyle: AppTextStyles.w400s,
            unselectedLabelStyle: AppTextStyles.w400s,
            unselectedItemColor: AppColors.black,
            selectedItemColor: AppColors.brown,
            iconSize: 40,
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              type == 'doctor'
                  ? cubit.changeBottomNavDoctor(index)
                  : cubit.changeBottomNavStudent(index);
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
      },
    );
  }
}
