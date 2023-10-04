import 'package:fasilah_m1/shared/components/components.dart';
import 'package:flutter/material.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/components/navigator.dart';
import '../../../shared/styles/colors.dart';

class DoctorProfile extends StatefulWidget {
  const DoctorProfile({super.key});

  @override
  State<DoctorProfile> createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
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
        title: const Text('Profile'),
      ),
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Container(
          width: width(context, 1),
          height: height(context, 1.5),
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: AppColors.white3,
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              TextFieldTemplate(
                hintText: 'doctor name',
                labelText: 'Name',
                icon: Icons.person,
                validator: () {},
                readOnly: true,
              ),
              TextFieldTemplate(
                hintText: 'email@example.com',
                labelText: 'Email',
                icon: Icons.mail,
                validator: () {},
                readOnly: true,
              ),
              const SizedBox(
                height: 20,
              ),
              ButtonTemplate(
                color: AppColors.brown,
                text1: 'edit',
                onPressed: () {},
                minwidth: width(context, 2.5),
              )
            ],
          ),
        ),
      ),
    );
  }
}
