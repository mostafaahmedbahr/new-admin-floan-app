import 'package:firebase_core/firebase_core.dart';
import 'package:floan_app_for_admin/pages/home/home_screen.dart';
import 'package:floan_app_for_admin/pages/login/login_screen.dart';

import 'package:flutter/material.dart';

import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';

import 'Sh/shared_pref.dart';
import 'core/colors.dart';
import 'core/constants.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  await SharedPreferencesHelper.init();

  uId = SharedPreferencesHelper.getData(key: "uId") ?? "";
  shopName = SharedPreferencesHelper.getData(key: "shopName") ?? "";
  lat = SharedPreferencesHelper.getData(key: "lat") ?? 0.0;
  long = SharedPreferencesHelper.getData(key: "long") ?? 0.0;
  print(uId);
  print(shopName);
  print(lat);
  print(long);
  print("0"*30);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // Future<Position> getCurrentLocation ()async
  // {
  //   bool serviceEnabled = Geolocator.isLocationServiceEnabled() as bool;
  //   if(!serviceEnabled){
  //     return Future.error("Location Service Are Disabled ..");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
         
          scaffoldBackgroundColor: AppColors.mainColorBlack, //<-- SEE HERE
         ),
      debugShowCheckedModeBanner: false,
      home:  newUidNew=="" ?  LoginScreen() : const HomeScreen(),
      builder: (context, child) => ResponsiveWrapper.builder(
        BouncingScrollWrapper.builder(context, child!),
        maxWidth: 1200,
        minWidth: 450,
        defaultScale: true,
        breakpoints: [
          const ResponsiveBreakpoint.resize(450, name: MOBILE),
          const ResponsiveBreakpoint.autoScale(800, name: TABLET),
          const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
          const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
          const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
        ],
      ),
    );
  }
}