import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fasilah_m1/features/Doctor/cubit/user_cubit.dart';
import 'package:fasilah_m1/models/courses_model.dart';
import 'package:fasilah_m1/shared/components/components.dart';
import 'package:fasilah_m1/shared/components/navigator.dart';
import 'package:fasilah_m1/shared/network/local/constant.dart';
import 'package:fasilah_m1/shared/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/styles/colors.dart';
import '../../../shared/styles/images.dart';

class UserCoursesInfo extends StatefulWidget {
  final String? type;
  final CourseModel courseModel;

  const UserCoursesInfo(
      {required this.type, required this.courseModel, super.key});

  @override
  State<UserCoursesInfo> createState() => _UserCoursesInfoState();
}

class _UserCoursesInfoState extends State<UserCoursesInfo> {
  DateTime ?  datetime;
  @override
  void initState() {
     datetime  = DateTime.parse(widget.courseModel.date![0]);
    print(datetime);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is SubscribeCourseSuccessState) {
          showToast(text: 'subscribe successfully', state: ToastStates.success);
        }
      },
      builder: (context, state) {
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
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25),
                          ),
                          child: Image(
                            image: NetworkImage(widget.courseModel.image!),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                     Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 5),
                              child: IconButton(
                                  onPressed: () async {
                                    DocumentSnapshot docRef =
                                        await FirebaseFirestore.instance
                                            .collection('courses')
                                            .doc(widget.courseModel.uid)
                                            .get();

                                    Map<String, dynamic> docIsFav =
                                        docRef.get("favourite");

                                    if (docIsFav.containsKey(uId)) {
                                      docIsFav.addAll({
                                        uId.toString():
                                            widget.courseModel.favourite!
                                                ? false
                                                : true
                                      });
                                    } else {
                                      docIsFav.addAll({
                                        uId!: widget.courseModel.favourite!
                                            ? false
                                            : true
                                      });
                                    }

                                    widget.courseModel.favourite = !widget.courseModel.favourite !;
                                    setState(() {});
                                    await FirebaseFirestore.instance
                                        .collection('courses')
                                        .doc(widget.courseModel.uid)
                                        .update({'favourite': docIsFav});

                                    setState(() {});
                                  },
                                  icon: !widget.courseModel.favourite!
                                      ?  const Icon(
                                    Icons.favorite_border,
                                    color: AppColors.white,
                                    size: 35,
                                  )
                                      : const Icon(
                                    Icons.favorite,
                                    color: AppColors.white,
                                    size: 35,
                                  )
                                ),
                            ),
                    ],
                  ),
                  DataItem(
                    text: widget.courseModel.title,
                    image: name,
                    textStyle: AppTextStyles.smSectionTitles,
                  ),
                  DataItem(
                      text: widget.courseModel.nameInstructor,
                      image: instructor,
                      textStyle: AppTextStyles.smSectionTitles),
                  DataItem(
                      text: widget.courseModel.date![0],
                      image: date,
                      textStyle: AppTextStyles.smSectionTitles),
                  DataItem(
                      text: widget.courseModel.time,
                      image: time,
                      textStyle: AppTextStyles.smSectionTitles),
                  DataItem(
                      text: widget.courseModel.numOfStudent,
                      image: audience,
                      textStyle: AppTextStyles.smSectionTitles),
                  DataItem(
                      text: widget.courseModel.type,
                      image: learn,
                      textStyle: AppTextStyles.smSectionTitles),
                  DataItem(
                      text: widget.courseModel.location,
                      image: location,
                      textStyle: AppTextStyles.smSectionTitles),

                  if (widget.type == 'book') ...[
                    state is SubscribeCourseLoadingState
                        ? const Center(child: CircularProgressIndicator())
                        : widget.courseModel.subscribers!.contains(uId)
                            ? const SizedBox()
                            : ButtonTemplate(
                                minwidth: width(context, 2),
                                color: AppColors.brown,
                                text1: 'subscribe now',
                                onPressed: () {
                                  print(widget.courseModel.date);
                                  AwesomeNotifications().createNotification(
                                      content: NotificationContent(
                                          id: 1,
                                          channelKey: 'alert key',
                                          title: 'time of course',
                                          body: widget.courseModel.title!),
                                      schedule: NotificationCalendar.fromDate(
                                          date: DateTime(
                                              datetime!.year,
                                              datetime!.month,
                                              datetime!.day,
                                              )));
                                  int numOfStudent = int.parse(
                                          widget.courseModel.numOfStudent!) -
                                      1;

                                  widget.courseModel.subscribers!.add(uId);
                                  UserCubit.get(context).subscribeCourse(
                                    time: widget.courseModel.time!,
                                    nameInstructor:
                                        widget.courseModel.nameInstructor!,
                                    title: widget.courseModel.title!,
                                    date: widget.courseModel.date!,
                                    type: type!,
                                    numOfStudent: numOfStudent.toString(),
                                    location: widget.courseModel.location!,
                                    uidUser: widget.courseModel.uidUser!,
                                    uidSubscribe: uId!,
                                    uidCourse: widget.courseModel.uid!,
                                    courseImage: widget.courseModel.image!,
                                    nameStudent:
                                        UserCubit.get(context).model!.name!,
                                    subscribers:
                                        widget.courseModel.subscribers!,
                                  );
                                })
                  ] else ...[
                    const SizedBox(),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
