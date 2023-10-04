import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/components/constants.dart';
import '../../../../shared/components/navigator.dart';
import '../../../../shared/styles/colors.dart';
class AddEvent extends StatefulWidget {
  const AddEvent({super.key});

  @override
  State<AddEvent> createState() => _AddEventState();
}
enum Type { online, offline }

Type? selectedType;
class _AddEventState extends State<AddEvent> {
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
          child: Column(
            children: [
              TextFieldUser(
                labelText: 'Title of event',
                hintText: 'enter title of event',
                scure: false,
                keyType: TextInputType.name,
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
                  _selectTime(context);
                },
              ),
              //Date Picker
              TextFieldUser(
                labelText: 'Time',
                hintText: 'enter time of event',
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
