import 'package:flutter/material.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/navigator.dart';
import '../../../shared/styles/colors.dart';
import '../../../shared/styles/styles.dart';

class UploadCertificate extends StatefulWidget {
  const UploadCertificate({super.key});

  @override
  State<UploadCertificate> createState() => _UploadCertificateState();
}

class _UploadCertificateState extends State<UploadCertificate> {
  TextEditingController nameController = TextEditingController();
   bool ? status = false ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => navigatePop(context),
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
      body: BackgroundBox(
        widget: ListView.builder(
          itemCount: 3,
            itemBuilder: (context , index){
          return  ItemBox(onPressed: (){
            setState(() {
              status = true;
            });
          }, text: 'name of student',
            icon: 'assets/images/cloud-computing.png',
            uploaded: status,
          );
        })
      ),
    );
  }
}
