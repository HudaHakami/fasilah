// ignore_for_file: unnecessary_null_comparison

import 'dart:async';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:fasilah_m1/features/Doctor/cubit/user_cubit.dart';
import 'package:fasilah_m1/features/navigation/view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/components/constants.dart';
import '../../../../shared/components/navigator.dart';
import '../../../../shared/network/local/constant.dart';
import '../../../../shared/styles/colors.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({super.key});

  @override
  State<AddEvent> createState() => _AddEventState();
}

enum Type { online, offline }

Type? selectedType;

class _AddEventState extends State<AddEvent> {
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

  TimeOfDay selectedTime = TimeOfDay.now();
  String? time;
  TextEditingController titleController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  final formKey = GlobalKey<FormState>();

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
        if (state is AddEventSuccessState) {
          showToast(text: 'add event successfully', state: ToastStates.success);
          UserCubit.get(context).getMyCoursesAndEvents();
          Timer(Duration(seconds: 1), () {
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
            title: const Text('Add Event'),
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
                      labelText: 'Title of event',
                      hintText: 'enter title of event',
                      scure: false,
                      keyType: TextInputType.name,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return ' please , enter title of event';
                        }
                      },
                      controller: titleController,
                    ),
                    TextFieldUser(
                      labelText: 'Location',
                      hintText: 'enter location',
                      scure: false,
                      keyType: TextInputType.number,
                      controller: locationController,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return ' please , enter location';
                        }
                      },
                    ),
                    //Date Picker
                    TextFieldClicked(
                      labelText: 'Time',
                      hintText: 'enter time of event',
                      scure: false,
                      keyType: TextInputType.number,
                      onTap: () {
                        _selectTime(context);
                      },
                      controller: timeController,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return ' please , enter time of course';
                        }
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
                              print(stringList);
                            }
                          }),
                        ),
                      ),
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
                    state is AddEventLoadingState
                        ? const Center(child: CircularProgressIndicator())
                        : UserCubit.get(context).courseImageFile == null
                        ? const SizedBox()
                        : ButtonTemplate(
                      color: AppColors.brown,
                      text1: 'send',
                      onPressed: () {
                        if (datesList == null) {
                          showToast(
                              text: 'please , choose date for course',
                              state: ToastStates.error);
                        }
                        if (formKey.currentState!.validate()) {
                          UserCubit.get(context).addEvent(
                              time: timeController.text,
                              title: titleController.text,
                              date: stringList,
                              location: locationController.text,
                              uidUser: uId!);
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
