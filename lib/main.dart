import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:fasilah_m1/features/Doctor/cubit/user_cubit.dart';
import 'package:fasilah_m1/features/splash/view.dart';
import 'package:fasilah_m1/shared/network/local/bloc_observer.dart';
import 'package:fasilah_m1/shared/network/local/constant.dart';
import 'package:fasilah_m1/shared/network/local/shared_preferences.dart';
import 'package:fasilah_m1/shared/styles/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/admin/cubit/admin_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  AwesomeNotifications().initialize('resource://drawable/notification', [
    NotificationChannel(
      channelKey: 'alert key',
      channelName: 'alert',
      channelDescription: 'notification for alert',
      playSound: true,
      channelShowBadge: true,
    )
  ]);
  await CacheHelper.init();
  uId = CacheHelper.getData(key: 'uId');
  runApp(const MyApp());
}

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
    return MultiBlocProvider(
      providers: [
        BlocProvider<AdminCubit>(
            lazy: false,
            create: (BuildContext context) => AdminCubit()

        ),
        // BlocProvider<ResetPasswordCubit>(
        //      create: (BuildContext context) => ResetPasswordCubit()),
        BlocProvider<UserCubit>(
            lazy: false, create: (BuildContext context) => UserCubit()),
      ],
      child: MaterialApp(
        theme: lightTheme,
        debugShowCheckedModeBanner: false,
        home:  const Scaffold(
          body: SplashScreen(),
        ),
      ),
    );
  }
}
