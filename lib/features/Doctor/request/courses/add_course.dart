// ignore_for_file: unnecessary_null_comparison

import 'dart:async';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:fasilah_m1/features/Doctor/cubit/user_cubit.dart';
import 'package:fasilah_m1/shared/components/components.dart';
import 'package:fasilah_m1/shared/components/navigator.dart';
import 'package:fasilah_m1/shared/network/local/constant.dart';
import 'package:fasilah_m1/shared/styles/colors.dart';
import 'package:fasilah_m1/shared/styles/styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../shared/components/constants.dart';
import '../../../navigation/view.dart';

class AddCourseScreen extends StatefulWidget {
  const AddCourseScreen({super.key});

  @override
  State<AddCourseScreen> createState() => _AddCourseScreenState();
}

class _AddCourseScreenState extends State<AddCourseScreen> {
  late List<DateTime?> datesList = [];
  late DateTime dates;

  late List<DateTime?> dateTimeList;
  List<String> stringList = [];

  dataFormat(List<DateTime?> dateTimeList) {
    this.dateTimeList = dateTimeList;

    String formatDateTime(DateTime? dateTime) {
      final formatter = DateFormat('yyyy-MM-dd');
      return formatter.format(dateTime!);
    }

    stringList = dateTimeList.map(formatDateTime).toList();
    print(stringList);
    print(stringList.runtimeType);
  }

  List<DateTime>? date = [];
  TimeOfDay selectedTime = TimeOfDay.now();
  String? selectedType;
  String? time;

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedS = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child!,
          );
        });

    if (pickedS != null && pickedS != selectedTime) {
      setState(() {
        selectedTime = pickedS;
        time = selectedTime.format(context);
        timeController.text = time!;
        if (kDebugMode) {
          print(selectedTime);
          print(time);
        }
      });
    }
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController instructorController = TextEditingController();
  TextEditingController numOfStudentController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    UserCubit.get(context).courseImageFile = null;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is AddCourseSuccessState) {
          showToast(
              text: 'add course successfully', state: ToastStates.success);
          UserCubit.get(context).getMyCoursesAndEvents();
          Timer(const Duration(seconds: 1), () {
            navigateTo(context, NavigationScreen());
          });
        }
        if (state is UploadCourseImageSuccessState) {
          showToast(text: 'add image successfully', state: ToastStates.success);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                navigatePop(context);
              },
            ),
            title: const Text('Add Course'),
          ),
          backgroundColor: AppColors.white,
          body: SingleChildScrollView(
            child: Container(
              width: width(context, 1),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: AppColors.white3,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFieldUser(
                      labelText: 'Title of course',
                      hintText: 'enter title of course',
                      scure: false,
                      keyType: TextInputType.name,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return ' please , enter title of course';
                        }
                      },
                      controller: titleController,
                    ),
                    TextFieldUser(
                      labelText: 'Instructor  of course',
                      hintText: 'enter title of instructor',
                      scure: false,
                      keyType: TextInputType.name,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return ' please , enter title of instructor';
                        }
                      },
                      controller: instructorController,
                    ),
                    TextFieldUser(
                      labelText: 'Number of attendees',
                      hintText: 'enter title of number of attendees',
                      scure: false,
                      keyType: TextInputType.number,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return ' please ,enter title of number of attendees';
                        }
                      },
                      controller: numOfStudentController,
                    ),
                    TextFieldUser(
                      labelText: 'Location',
                      hintText: 'enter location',
                      scure: false,
                      keyType: TextInputType.number,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return ' please , enter location';
                        }
                      },
                      controller: locationController,
                    ),
                    //Date Picker

                    TextFieldClicked(
                      labelText: 'Time',
                      hintText: 'enter time of course',
                      scure: false,
                      keyType: TextInputType.number,
                      controller: timeController,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return ' please , enter time of course';
                        }
                      },
                      onTap: () {
                        _selectTime(context);
                      },
                    ),
                    //Date Picker
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: SizedBox(
                        height: height(context, 3),
                        child: CalendarDatePicker2(
                          config: CalendarDatePicker2Config(
                            calendarType: CalendarDatePicker2Type.single,
                            selectedDayHighlightColor: AppColors.green,
                          ),
                          value: datesList,
                          onValueChanged: (dates) => setState(() {
                            datesList = dates;
                            dataFormat(datesList);
                            if (kDebugMode) {
                              print(dates);
                            }
                          }),
                        ),
                      ),
                    ),
                    //Status of course
                    Column(
                      children: [
                        Header(
                          style: AppTextStyles.radioButton,
                          text: 'Status of course',
                          alignment: Alignment.centerLeft,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: width(context, 3),
                              child: RadioListTile(
                                contentPadding:
                                const EdgeInsets.symmetric(horizontal: 5),
                                title: const Text('offline'),
                                value: 'offline',
                                groupValue: selectedType,
                                onChanged: (value) {
                                  setState(() {
                                    selectedType = value;
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              width: width(context, 3),
                              child: RadioListTile(
                                contentPadding:
                                const EdgeInsets.symmetric(horizontal: 5),
                                title: const Text('online'),
                                value: 'online',
                                groupValue: selectedType,
                                onChanged: (value) {
                                  setState(() {
                                    selectedType = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    //upload image button

                    state is UploadCourseImageLoadingState
                        ? const Center(child: CircularProgressIndicator())
                        : ButtonTemplate(
                      color: AppColors.lightGreen,
                      text1: 'upload image',
                      onPressed: () {
                        UserCubit.get(context).showBottomSheet(context);
                      },
                      minwidth: width(context, 1.5),
                    ),
                    UserCubit.get(context).courseImageFile == null
                        ? const SizedBox()
                        : ButtonTemplate(
                      color: AppColors.brown,
                      text1: 'send',
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          if (datesList == null) {
                            showToast(
                                text: 'please , choose date for course',
                                state: ToastStates.error);
                          } else {
                            UserCubit.get(context).addCourse(
                              time: time!,
                              nameInstructor: instructorController.text,
                              title: titleController.text,
                              date: stringList,
                              type: selectedType!,
                              numOfStudent: numOfStudentController.text,
                              location: locationController.text,
                              uidUser: uId!,
                            );
                          }
                        }
                      },
                      minwidth: width(context, 2),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
