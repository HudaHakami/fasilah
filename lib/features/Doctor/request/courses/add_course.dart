import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:fasilah/shared/components/components.dart';
import 'package:fasilah/shared/components/navigator.dart';
import 'package:fasilah/shared/styles/colors.dart';
import 'package:fasilah/shared/styles/styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../shared/components/constants.dart';

class AddCourseScreen extends StatefulWidget {
  const AddCourseScreen({super.key});

  @override
  State<AddCourseScreen> createState() => _AddCourseScreenState();
}

enum Type { online, offline }

Type? selectedType;

class _AddCourseScreenState extends State<AddCourseScreen> {
  List<DateTime>? date = [];
  TimeOfDay selectedTime = TimeOfDay.now();

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
        if (kDebugMode) {
          print(selectedTime);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
          child: Column(
            children: [
              TextFieldUser(
                labelText: 'Title of course',
                hintText: 'enter title of course',
                scure: false,
                keyType: TextInputType.name,
                validator: () {},
                onTap: () {},
              ),
              TextFieldUser(
                labelText: 'Instructor  of course',
                hintText: 'enter title of instructor',
                scure: false,
                keyType: TextInputType.name,
                validator: () {},
                onTap: () {},
              ),
              TextFieldUser(
                labelText: 'Number of attendees',
                hintText: 'enter title of number of attendees',
                scure: false,
                keyType: TextInputType.number,
                validator: () {},
                onTap: () {},
              ),
              TextFieldUser(
                labelText: 'Location',
                hintText: 'enter location',
                scure: false,
                keyType: TextInputType.number,
                validator: () {},
                onTap: () {
                },
              ),
              //Date Picker

              TextFieldUser(
                labelText: 'Time',
                hintText: 'enter time of course',
                scure: false,
                keyType: TextInputType.number,
                validator: () {},
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
                    value: date!,
                    onValueChanged: (dates) => setState(() {
                      date = dates.cast<DateTime>();
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
                        child: RadioListTile<Type>(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 5),
                          title: const Text('offline'),
                          value: Type.offline,
                          groupValue: selectedType,
                          onChanged: (Type? value) {
                            setState(() {
                              selectedType = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: width(context, 3),
                        child: RadioListTile<Type>(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 5),
                          title: const Text('online'),
                          value: Type.online,
                          groupValue: selectedType,
                          onChanged: (Type? value) {
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

              ButtonTemplate(
                color: AppColors.lightGreen,
                text1: 'upload image',
                onPressed: () {},
                minwidth: width(context, 1.5),
              ),
              ButtonTemplate(
                color: AppColors.brown,
                text1: 'send',
                onPressed: () {},
                minwidth: width(context, 2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
