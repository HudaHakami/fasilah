import 'package:fasilah_m1/models/event_model.dart';
import 'package:flutter/material.dart';
import '../../../../shared/components/constants.dart';
import '../../../../shared/components/navigator.dart';
import '../../../../shared/styles/colors.dart';
import '../../../../shared/styles/styles.dart';
import '../../userEventInfo.dart';
class NewEventList extends StatefulWidget {
  final List<EventModel> eventList;
  const NewEventList({required this.eventList , super.key});

  @override
  State<NewEventList> createState() => _NewEventListState();
}

class _NewEventListState extends State<NewEventList> {
  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
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
                    color: AppColors.lightGrey,
                    blurRadius: 1,
                    spreadRadius: 1)
              ]),
          child: Row(
            children: [
              SizedBox(
                  height: 100,
                  width: 90,
                  child: Image(
                    image: NetworkImage(widget.eventList[index].image!),
                    fit: BoxFit.fill,
                  )),
              const SizedBox(width: 20,),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.eventList[index].title!,
                    style: AppTextStyles.name,
                  ),
                  Text(
                    widget.eventList[index].date![0],
                    style: AppTextStyles.smTitles,
                  ),
                ],
              ),
              const Expanded(child: SizedBox()),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        navigateTo(context,   UserEventInfo(type: 'subscribe',model: widget.eventList[index],));
                      },
                      icon: const Icon(Icons.arrow_forward_ios,
                        color: AppColors.green ,
                        size: 25,
                      )),
                ],
              )
            ],
          ),
        );
      },
      itemCount: widget.eventList.length
      ,
    );
  }
}
