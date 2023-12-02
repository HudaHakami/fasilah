import 'package:flutter/material.dart';
import '../../../../models/event_model.dart';
import '../../../../shared/components/constants.dart';
import '../../../../shared/components/navigator.dart';
import '../../../../shared/styles/colors.dart';
import '../../../../shared/styles/styles.dart';
import '../../userEventInfo.dart';

class RefusedEvents extends StatefulWidget {
  final List<EventModel> refusedEventsList;

  const RefusedEvents({required this.refusedEventsList, super.key});

  @override
  State<RefusedEvents> createState() => _RefusedEventsState();
}

class _RefusedEventsState extends State<RefusedEvents> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Container(
          width: width(context, 1),
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
              color: AppColors.white2,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: AppColors.green, width: 1.5),
              boxShadow: const [
                BoxShadow(
                    color: AppColors.lightGrey, blurRadius: 1, spreadRadius: 1)
              ]),
          child: Row(

            children: [
              SizedBox(
                  height: 100,
                  width: 90,
                  child: Image(
                    image: NetworkImage(widget.refusedEventsList[index].image!),
                    fit: BoxFit.fill,
                  )),
              const SizedBox(width: 20,),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.refusedEventsList[index].title!,
                    style: AppTextStyles.name,
                  ),
                  Text(
                    widget.refusedEventsList[index].date![0],
                    style: AppTextStyles.smTitles,
                  ),
                ],
              ),
              const Expanded(child: SizedBox()),

              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        navigateTo(
                            context,
                            UserEventInfo(
                              type: 'request',
                              model: widget.refusedEventsList[index],
                            ));
                      },
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.green,
                        size: 25,
                      )),
                ],
              )
            ],
          ),
        );
      },
      itemCount: widget.refusedEventsList.length,
    );
  }
}
