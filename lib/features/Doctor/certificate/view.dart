import 'package:fasilah/shared/components/constants.dart';
import 'package:flutter/material.dart';
import '../../../shared/components/components.dart';
import '../../../shared/network/local/constant.dart';
import '../../../shared/styles/colors.dart';
import '../../../shared/styles/styles.dart';

class MyCertificate extends StatefulWidget {
  const MyCertificate({super.key});

  @override
  State<MyCertificate> createState() => _MyCertificateState();
}

class _MyCertificateState extends State<MyCertificate> {
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.lightGreen,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            'Certificate',
            style: AppTextStyles.boldTitles.apply(color: AppColors.white),
          ),
        ),
      ),
      body: BackgroundBox(
          widget: Column(
            children:[
              type == 'student' ?   Container(
                height: height(context, 11),
                width: width(context, 1),
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                    color: AppColors.lightGreen,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: AppColors.lightGreen, width: 1.5),
                    boxShadow: const [
                      BoxShadow(
                          color: AppColors.lightGrey, blurRadius: 1, spreadRadius: 1)
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Points',
                      style: AppTextStyles.button.copyWith(fontWeight: FontWeight.bold),
                    ),
                    CircleAvatar(
                      backgroundColor: AppColors.green,
                      radius: 30,
                      child: Center(child: Text('20',style: AppTextStyles.button.copyWith(fontWeight: FontWeight.bold , fontSize: 20),)),
                    )

                  ],
                ),
              ) : const SizedBox(),
              Expanded(
                child: SizedBox(
                 
                  child: ListView.builder(
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return ItemBox(
                          onPressed: () {},
                          text: 'name of course',
                          icon: 'assets/images/certificate_3000745.png',
                          uploaded: false,
                        );
                      }),
                ),
              )
            ] ,
          )),
    );
  }
}
