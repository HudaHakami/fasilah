import 'package:fasilah_m1/features/admin/cubit/admin_cubit.dart';
import 'package:fasilah_m1/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/event_model.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/components/navigator.dart';
import '../../../shared/styles/colors.dart';
import '../../../shared/styles/styles.dart';
import 'event_info.dart';

class AdminAcceptedEvents extends StatefulWidget {
  final List<EventModel> acceptEventList;

  const AdminAcceptedEvents({required this.acceptEventList, super.key});

  @override
  State<AdminAcceptedEvents> createState() => _AdminAcceptedEventsState();
}

class _AdminAcceptedEventsState extends State<AdminAcceptedEvents> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminState>(
      listener: (context, state) {
        if (state is DeleteEventsSuccessState) {
          showToast(text: 'deleted successfully', state: ToastStates.success);
        }
        if (state is StopEventsSuccessState) {
          showToast(text: 'stopped successfully', state: ToastStates.success);
        }
      },
      builder: (context, state) {
        return ListView.builder(
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                navigateTo(
                    context,
                    EventInfo(
                      type: widget.acceptEventList[index].status,
                      eventModel: widget.acceptEventList[index],
                    ));
              },
              child: Container(
                width: width(context, 1),
                margin:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                          image: NetworkImage(
                              widget.acceptEventList[index].image!),
                          fit: BoxFit.fill,
                        )),
                    const SizedBox(width: 20,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.acceptEventList[index].title!,
                          style: AppTextStyles.name,
                        ),
                        Text(
                          widget.acceptEventList[index].date![0],
                          style: AppTextStyles.smTitles,
                        ),
                      ],
                    ),
                    const Expanded(child: SizedBox()),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              AdminCubit.get(context).stopEvent(
                                  uidDoc: widget.acceptEventList[index].uid!);
                            },
                            icon: const Icon(
                              Icons.stop_circle,
                              color: AppColors.green,
                              size: 25,
                            )),
                        IconButton(
                            onPressed: () {
                              AdminCubit.get(context).deleteEvent(
                                  uidDoc: widget.acceptEventList[index].uid!);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: AppColors.darkRed,
                              size: 25,
                            ))
                      ],
                    )
                  ],
                ),
              ),
            );
          },
          itemCount: widget.acceptEventList.length,
        );
      },
    );
  }
}
