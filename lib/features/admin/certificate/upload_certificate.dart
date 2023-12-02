import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fasilah_m1/features/admin/certificate/upload_info.dart';
import 'package:fasilah_m1/features/admin/courses/courses_info.dart';
import 'package:fasilah_m1/features/admin/cubit/admin_cubit.dart';
import 'package:fasilah_m1/models/courses_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/components/navigator.dart';
import '../../../shared/styles/colors.dart';
import '../../../shared/styles/images.dart';
import '../../../shared/styles/styles.dart';

class UploadCertificate extends StatefulWidget {
  final String uidDoc;
  final CourseModel ?  model;
  const UploadCertificate({required this.uidDoc, this.model, super.key});
  @override
  State<UploadCertificate> createState() => _UploadCertificateState();
}

class _UploadCertificateState extends State<UploadCertificate> {
  TextEditingController nameController = TextEditingController();
  bool? status = false;

  @override
  void initState() {
    AdminCubit.get(context).getEnrolled(uidDoc: widget.uidDoc);
    AdminCubit.get(context).getCertificates();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminState>(
      listener: (context, state) {
        if (state is UploadCertificateSuccessState) {
          showToast(
              text: 'upload certificate successfully',
              state: ToastStates.success);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () => navigateTo(context, CoursesInfo(type: 'accepted', courseModel: widget.model)),
              icon: const Icon(Icons.arrow_back),
            ),
            backgroundColor: AppColors.lightGreen,
            title: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                'Enrollees',
                style: AppTextStyles.boldTitles.apply(color: AppColors.white),
              ),
            ),
          ),
          body: ConditionalBuilder(
              condition: AdminCubit.get(context).subscribeCourseList.isNotEmpty,
              builder: (context) {
                return BackgroundBox(
                    widget: ListView.builder(
                        itemCount:
                            AdminCubit.get(context).subscribeCourseList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              navigateTo(
                                  context,
                                  AddCertificateScreen(
                                    subscribeCourseModel:
                                        AdminCubit.get(context)
                                            .subscribeCourseList[index],
                                    model: widget.model,
                                  ));
                            },
                            child: Container(
                              height: height(context, 11),
                              width: width(context, 1),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              decoration: BoxDecoration(
                                  color: AppColors.white2,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: AppColors.green, width: 1.5),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: AppColors.lightGrey,
                                        blurRadius: 1,
                                        spreadRadius: 1)
                                  ]),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AdminCubit.get(context)
                                        .subscribeCourseList[index]
                                        .nameStudent!,
                                    style: AppTextStyles.name,
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        AdminCubit.get(context)
                                            .subscribeCourseList[index]
                                            .certificate! ? launchUrl(Uri.parse(AdminCubit
                                            .get(context)
                                            .certificateList[index]
                                            .certificate!)): null ;

                                      },
                                      icon: AdminCubit.get(context)
                                              .subscribeCourseList[index]
                                              .certificate!
                                          ? const ImageIcon(
                                              AssetImage(certificate))
                                          : const ImageIcon(AssetImage(
                                              'assets/images/cloud-computing.png')))
                                ],
                              ),
                            ),
                          );
                        }));
              },
              fallback: (context) {
                return const Scaffold(
                  body: LinearProgressIndicator(),
                );
              }),
        );
      },
    );
  }
}
