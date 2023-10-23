<<<<<<< HEAD
import 'package:bloc/bloc.dart';
=======

>>>>>>> 5c1725bbff958ea0e2045205c008d351b61b45e7
import 'package:fasilah_m1/features/splash/view.dart';
import 'package:fasilah_m1/shared/network/local/bloc_observer.dart';
import 'package:fasilah_m1/shared/network/local/constant.dart';
import 'package:fasilah_m1/shared/network/local/shared_preferences.dart';
import 'package:fasilah_m1/shared/styles/theme.dart';
<<<<<<< HEAD
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
=======
//import 'package:firebase_core/firebase_core.dart';
>>>>>>> 5c1725bbff958ea0e2045205c008d351b61b45e7
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
<<<<<<< HEAD
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  runApp(const MyApp());
}
=======
  //await Firebase.initializeApp();
  runApp(const MyApp());
}

>>>>>>> 5c1725bbff958ea0e2045205c008d351b61b45e7

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  getToken() async {
    token = await FirebaseMessaging.instance.getToken();
    if (kDebugMode) {
      print('=================MyToken===================');
      print(token);
    }
  }

  @override
  void initState() {
    getToken();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        body: SplashScreen(),
      ),
    );
  }
}
