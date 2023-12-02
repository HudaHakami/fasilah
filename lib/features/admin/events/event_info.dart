import 'dart:async';

import 'package:fasilah_m1/features/admin/cubit/admin_cubit.dart';
import 'package:fasilah_m1/features/admin/events/view.dart';
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
import '../../visitors/view.dart';

class EventInfo extends StatefulWidget {
  final String? type;
  final EventModel? eventModel;

  const EventInfo({required this.type, this.eventModel, super.key});

  @override
  State<EventInfo> createState() => _EventInfoState();
}

class _EventInfoState extends State<EventInfo> {
  @override
  void initState() {
    if (kDebugMode) {
      print(widget.type);
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminState>(
      listener: (context, state) {
        if (state is AcceptEventsSuccessState) {
          showToast(
              text: 'you accepted successfully', state: ToastStates.success);
          Timer(const Duration(seconds: 1), () {
            navigateTo(context, const MangeEventsScreen());
          });
        }
        if (state is RefuseEventsSuccessState) {
          showToast(
              text: 'you refused successfully', state: ToastStates.success);
          Timer(const Duration(seconds: 1), () {
            navigateTo(context, const MangeEventsScreen());
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.lightGreen,
          appBar: AppBar(
            title: const Text('Events'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                if (widget.type == 'visitors') {
                  navigateTo(context, VisitorScreen());
                }
                else navigateTo(context, const MangeEventsScreen());
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
                            image: NetworkImage(widget.eventModel!.image!),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      type == 'student'
                          ? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5),
                        child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.favorite_border,
                              color: AppColors.white,
                              size: 35,
                            )),
                      )
                          : const SizedBox(),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DataItem(
                    text: widget.eventModel!.title!,
                    image: eventIcon,
                    textStyle: AppTextStyles.smSectionTitles,
                  ),
                  DataItem(
                      text: widget.eventModel!.date![0],
                      image: date,
                      textStyle: AppTextStyles.smSectionTitles),
                  DataItem(
                      text: widget.eventModel!.time!,
                      image: time,
                      textStyle: AppTextStyles.smSectionTitles),
                  DataItem(
                      text: widget.eventModel!.location!,
                      image: location,
                      textStyle: AppTextStyles.smSectionTitles),
                  DataItem(
                      text: widget.eventModel!.numberAttendees!,
                      image: audience,
                      textStyle: AppTextStyles.smSectionTitles),

                  SizedBox(
                    height: height(context, 8),
                  ),
                  if (widget.type == 'book') ...[
                    const SizedBox(
                      height: 20,
                    ),
                    ButtonTemplate(
                        minwidth: width(context, 2),
                        color: AppColors.brown,
                        text1: 'subscribe now',
                        onPressed: () {})
                  ] else if (widget.type == 'waiting') ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        state is AcceptEventsLoadingState
                            ? const Center(child: CircularProgressIndicator())
                            : SmallButtonTemplate(
                            color: AppColors.green,
                            text1: 'accept',
                            onPressed: () {
                              AdminCubit.get(context).acceptEvent(
                                  uidDoc: widget.eventModel!.uid!);
                            }),
                        state is RefuseEventsLoadingState
                            ? const Center(child: CircularProgressIndicator())
                            : SmallButtonTemplate(
                            color: AppColors.darkRed,
                            text1: 'refuse',
                            onPressed: () {
                              AdminCubit.get(context).refuseEvent(
                                  uidDoc: widget.eventModel!.uid!);
                            }),
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
      },
    );
  }
}
