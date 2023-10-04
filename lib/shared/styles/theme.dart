import 'package:fasilah_m1/shared/styles/styles.dart';
import 'package:flutter/material.dart';
import 'colors.dart';

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.white,
  radioTheme: RadioThemeData(
    fillColor: MaterialStateColor.resolveWith((states) => AppColors.brown),
  ),
  appBarTheme: AppBarTheme(
      backgroundColor: AppColors.lightGreen,
      toolbarHeight: 60,
      elevation: 0,
      centerTitle: true,
      iconTheme: const IconThemeData(color: AppColors.white),
      titleTextStyle: AppTextStyles.boldTitles.apply(color: AppColors.white),
      actionsIconTheme: const IconThemeData(color: AppColors.black)),
);
