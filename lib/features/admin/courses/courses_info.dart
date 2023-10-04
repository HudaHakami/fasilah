import 'package:fasilah_m1/shared/components/components.dart';
import 'package:fasilah_m1/shared/components/navigator.dart';
import 'package:fasilah_m1/shared/styles/styles.dart';
import 'package:fasilah_m1/shared/network/local/constant.dart';
import 'package:flutter/material.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/styles/colors.dart';
import '../../../shared/styles/images.dart';
import '../certificate/upload_certificate.dart';

class CoursesInfo extends StatefulWidget {
  final String? type;

  const CoursesInfo({required this.type, super.key});

  @override
  State<CoursesInfo> createState() => _CoursesInfoState();
}

class _CoursesInfoState extends State<CoursesInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreen,
      appBar: AppBar(
        title: const Text('Course'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            navigatePop(context);
          },
        ),
      ),
      body: Container(
        height: height(context, 1, hasAppBar: true),
        width: width(context, 1),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          border: Border.all(color: AppColors.lightGreen, width: 2),
          color: AppColors.white2,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // image course
              Stack(

                alignment: Alignment.topRight,
                children: [
                  SizedBox(
                    height: height(context, 2.5, hasAppBar: true),
                    width: width(context, 1),
                    child:  const ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                      child: Image(
                        image: AssetImage(course),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  type == 'student' ?   Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0 ,vertical: 5),
                    child: IconButton(onPressed: (){}, icon: const Icon(Icons.favorite_border ,  color: AppColors.white,size: 35,)),
                  ) : const SizedBox() ,

                ],
              ),
              DataItem(
                text: 'name of course',
                image: name,
                textStyle: AppTextStyles.smSectionTitles,
              ),
              DataItem(
                  text: 'name of instructor',
                  image: instructor,
                  textStyle: AppTextStyles.smSectionTitles),
              DataItem(
                  text: '30/10/2023',
                  image: date,
                  textStyle: AppTextStyles.smSectionTitles),
              DataItem(
                  text: '3:00 Am',
                  image: time,
                  textStyle: AppTextStyles.smSectionTitles),
              DataItem(
                  text: '30 student',
                  image: audience,
                  textStyle: AppTextStyles.smSectionTitles),
              DataItem(
                  text: 'online sessions',
                  image: learn,
                  textStyle: AppTextStyles.smSectionTitles),
              DataItem(
                  text: 'address',
                  image: location,
                  textStyle: AppTextStyles.smSectionTitles),

              if (widget.type == 'book') ...[
                ButtonTemplate(
                    minwidth: width(context, 2),
                    color: AppColors.brown,
                    text1: 'subscribe now',
                    onPressed: () {})
              ] else if (widget.type == 'accepted') ...[
                ButtonTemplate(
                    minwidth: width(context, 2),
                    color: AppColors.brown,
                    text1: 'view enrollees',
                    onPressed: () {
                      navigateTo(context, const UploadCertificate());
                    }),
              ] else if (widget.type == 'waiting') ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SmallButtonTemplate(
                        color: AppColors.green,
                        text1: 'accept',
                        onPressed: () {}),
                    SmallButtonTemplate(
                        color: AppColors.darkRed,
                        text1: 'refuse',
                        onPressed: () {}),
                  ],
                )
              ] else ...[
                const SizedBox(),
              ],

            ],
          ),
        ),
      ),
    );
  }
}

