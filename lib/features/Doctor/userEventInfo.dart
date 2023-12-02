import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fasilah_m1/models/event_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/components/navigator.dart';
import '../../../shared/network/local/constant.dart';
import '../../../shared/styles/colors.dart';
import '../../../shared/styles/images.dart';
import '../../../shared/styles/styles.dart';
import '../navigation/view.dart';
import 'cubit/user_cubit.dart';

class UserEventInfo extends StatefulWidget {
  final EventModel model;
  final String? type;

  const UserEventInfo({required this.type, required this.model, super.key});

  @override
  State<UserEventInfo> createState() => _UserEventInfoState();
}

class _UserEventInfoState extends State<UserEventInfo> {
  DateTime? datetime;

  @override
  void initState() {
    if (kDebugMode) {
      print(widget.type);
    }
    datetime = DateTime.parse(widget.model.date![0]);
    print(datetime);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is SubscribeEventSuccessState) {
          showToast(text: 'subscribe successfully', state: ToastStates.success);
          navigateTo(context, const NavigationScreen());
        }
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.lightGreen,
          appBar: AppBar(
            title: const Text('Events'),
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
                            image: NetworkImage(widget.model.image!),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5),
                        child: IconButton(
                            onPressed: () async {
                              DocumentSnapshot docRef = await FirebaseFirestore
                                  .instance
                                  .collection('events')
                                  .doc(widget.model.uid)
                                  .get();

                              Map<String, dynamic> docIsFav =
                                  docRef.get("favourite");

                              if (docIsFav.containsKey(uId)) {
                                docIsFav.addAll({
                                  uId.toString():
                                      widget.model.favourite! ? false : true
                                });
                              } else {
                                docIsFav.addAll({
                                  uId!: widget.model.favourite! ? false : true
                                });
                              }

                              widget.model.favourite = !widget.model.favourite!;
                              setState(() {});
                              await FirebaseFirestore.instance
                                  .collection('events')
                                  .doc(widget.model.uid)
                                  .update({'favourite': docIsFav});

                              setState(() {});
                            },
                            icon: !widget.model.favourite!
                                ? const Icon(
                                    Icons.favorite_border,
                                    color: AppColors.white,
                                    size: 35,
                                  )
                                : const Icon(
                                    Icons.favorite,
                                    color: AppColors.white,
                                    size: 35,
                                  )),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DataItem(
                    text: widget.model.title,
                    image: eventIcon,
                    textStyle: AppTextStyles.smSectionTitles,
                  ),
                  DataItem(
                      text: widget.model.date![0],
                      image: date,
                      textStyle: AppTextStyles.smSectionTitles),
                  DataItem(
                      text: widget.model.time,
                      image: time,
                      textStyle: AppTextStyles.smSectionTitles),
                  DataItem(
                      text: widget.model.location,
                      image: location,
                      textStyle: AppTextStyles.smSectionTitles),
                  // DataItem(
                  //     text: widget.model.numberAttendees,
                  //     image: audience,
                  //     textStyle: AppTextStyles.smSectionTitles),
                  const SizedBox(
                    height: 30,
                  ),
                  if (widget.type == 'book') ...[
                    const SizedBox(
                      height: 20,
                    ),
                    widget.model.subscribers!.contains(uId)
                        ? const SizedBox()
                        : ButtonTemplate(
                            minwidth: width(context, 2),
                            color: AppColors.brown,
                            text1: 'subscribe now',
                            onPressed: () {
                              AwesomeNotifications().createNotification(
                                  content: NotificationContent(
                                      id: 1,
                                      channelKey: 'alert key',
                                      title: 'time of course',
                                      body: widget.model.title!),
                                  schedule: NotificationCalendar.fromDate(
                                      date: DateTime(
                                    datetime!.year,
                                    datetime!.month,
                                    datetime!.day,
                                  )));
                              print(widget.model.numberAttendees!);
                              int numberAttendees =
                                  int.parse(widget.model.numberAttendees!) + 1;
                              widget.model.subscribers!.add(uId);
                              print(widget.model.subscribers);
                              if (kDebugMode) {
                                print(numberAttendees);
                              }
                              UserCubit.get(context).subscribeEvent(
                                time: widget.model.time!,
                                title: widget.model.title!,
                                date: widget.model.date!,
                                numberAttendees: numberAttendees.toString(),
                                location: widget.model.location!,
                                uidSubscribe: uId!,
                                uidEvent: widget.model.uid!,
                                eventImage: widget.model.image!,
                                subscribers: widget.model.subscribers!,
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
