import 'package:fasilah_m1/models/subscribe_event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/components/navigator.dart';
import '../../../shared/styles/colors.dart';
import '../../../shared/styles/images.dart';
import '../../../shared/styles/styles.dart';
import '../cubit/user_cubit.dart';

class UserSubscribeEventInfo extends StatefulWidget {
  final SubscribeEventModel model;


  const UserSubscribeEventInfo({ required this.model, super.key});

  @override
  State<UserSubscribeEventInfo> createState() => _UserSubscribeEventInfoState();
}

class _UserSubscribeEventInfoState extends State<UserSubscribeEventInfo> {
  @override
  void initState() {


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {

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
                        child:  ClipRRect(
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
                    const SizedBox(),

                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
