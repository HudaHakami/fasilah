import 'package:fasilah_m1/models/event_model.dart';
import 'package:flutter/material.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/components/navigator.dart';
import '../../../shared/styles/colors.dart';
import '../../../shared/styles/styles.dart';
import '../userEventInfo.dart';

class EventsScreen extends StatefulWidget {
  final List<EventModel> eventsList;
  final String? filter;

  const EventsScreen(
      {required this.eventsList, required this.filter, super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        print(widget.eventsList.length);
        return widget.filter == null || widget.filter == ""
            ? buildEventBox(
          widget.eventsList[index],
        )
            : widget.eventsList[index].title!
            .toLowerCase()
            .contains(widget.filter!.toLowerCase())
            ? buildEventBox(
          widget.eventsList[index],
        )
            : Container();
      },
      itemCount: widget.eventsList.length,
    );
  }
  Widget buildEventBox(EventModel model ) {
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
                image: NetworkImage(model.image!),
                fit: BoxFit.fill,
              )),
          const SizedBox(
            width: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.title!,
                style: AppTextStyles.name,
              ),
              Text(
                model.date![0],
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
                          type: 'book',
                          model: model,
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
    ) ;
  }

}


