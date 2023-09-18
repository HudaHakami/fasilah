//import 'package:fasilah_m1/features/registration/login/view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/styles/colors.dart';
import '../../../shared/styles/images.dart';
import '../sign_up/view.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              alignment: Alignment.topCenter,
              height: MediaQuery.of(context).size.height,
              width: width(context, 1),
              decoration:const BoxDecoration(
                color: AppColors.lightGreen,
              ),
              child: Image(
                image: const AssetImage(logo),height: height(context, 3.5),
              ),
            ),
            Container(
              width: width(context, 1),
              height: MediaQuery.of(context).size.height / 1.3,
              decoration:const BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15))),
              child: Column(children: [
                SizedBox(
                  height: 65,
                  child: (TabBar(
                    labelColor: AppColors.brown,
                    unselectedLabelColor: AppColors.greyDark,
                    indicatorColor: AppColors.brown,
                    isScrollable: true,
                    labelStyle: GoogleFonts.tajawal(
                      textStyle: const TextStyle(
                          fontSize: 25,
                          height: 1.5,
                          fontWeight: FontWeight.w800),
                    ),
                    tabs: const <Widget>[
                      Tab(
                        text: "Login",
                      ),
                      Tab(
                        text: 'Sign up',

                      ),
                    ],
                  )),
                ),
                const  Expanded(
                  child: SizedBox(
                    child: TabBarView(
                      children: [
                        //LoginScreen(),
                        SignUpScreen(),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
            // Expanded(

          ],
        ),
      ),
    );
  }
}
