import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

abstract class AppTextStyles {
  /// - weight: w200
  /// - family: cairo
  static TextStyle boldTitles = GoogleFonts.tajawal(
      fontWeight: FontWeight.bold, fontSize: 25, color: AppColors.black);
  static TextStyle w400b =
      GoogleFonts.tajawal(fontWeight: FontWeight.bold, fontSize: 14);

  /// - weight: w300
  /// - family: cairo
  static const TextStyle w300 =
      TextStyle(fontWeight: FontWeight.w300, fontSize: 30);

  /// - weight: w400
  /// - family: cairo
  static TextStyle w400 =
      GoogleFonts.tajawal(fontWeight: FontWeight.w400, fontSize: 18);
  static TextStyle w400s =
      GoogleFonts.tajawal(fontWeight: FontWeight.w600
          , fontSize: 12 );

  /// - weight: w500
  /// - family: cairo
  static TextStyle smTitles = GoogleFonts.tajawal(
      fontWeight: FontWeight.w500, fontSize: 16, color: AppColors.black);

  /// - weight: w600
  /// - family: cairo
  static const TextStyle w600 = TextStyle(fontWeight: FontWeight.w600);

  /// - weight: w700
  /// - family: cairo
  static const TextStyle lrTitles =
      TextStyle(fontWeight: FontWeight.w500, fontSize: 30);

  /// - weight: w800
  /// - family: cairo
  static TextStyle w800 =
      GoogleFonts.tajawal(fontWeight: FontWeight.w800, fontSize: 18);

  /// - weight: w900
  /// - family: cairo
  static const TextStyle w900 = TextStyle(fontWeight: FontWeight.w900);

  static TextStyle button = GoogleFonts.tajawal(
      fontSize: 22, color: AppColors.white, fontWeight: FontWeight.w600);

  static TextStyle name = GoogleFonts.tajawal(
      fontSize: 18, color: AppColors.black, fontWeight: FontWeight.bold);

  static TextStyle sectionTitles = GoogleFonts.tajawal(
      fontWeight: FontWeight.bold, fontSize: 30, color: AppColors.black);

  static TextStyle smSectionTitles = GoogleFonts.tajawal(
      fontWeight: FontWeight.w600, fontSize: 18, color: AppColors.black);

  static TextStyle sName = GoogleFonts.tajawal(
      fontSize: 20, color: AppColors.black, fontWeight: FontWeight.bold);

  static TextStyle radioButton = GoogleFonts.tajawal(
    fontSize: 16,
    color: AppColors.black,
    fontWeight: FontWeight.w600, height: 1,
  );

  static TextStyle labelStyle = GoogleFonts.tajawal(
    textStyle: const TextStyle(
        fontSize: 20, fontWeight: FontWeight.w600, height: 1, color: AppColors.black),
  );
  static TextStyle hintStyle = GoogleFonts.tajawal(
    textStyle: const TextStyle(
        fontSize: 15, fontWeight: FontWeight.w400, height: 1.5, color: AppColors.greyDark),
  );
}
