import 'dart:io';

import 'package:wts/auth/splashscreen.dart';
import 'package:wts/test.dart';
import 'package:flutter/material.dart';
import 'package:wts/auth/backgroundDesign.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HttpOverrides.global = MyHttpOverrides();
  }
  @override
  Widget build(BuildContext context) {
     width = MediaQuery.of(context).size.width;
     height = MediaQuery.of(context).size.height;
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context , child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'WTS',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
// theme: lightTheme,
// darkTheme: darkTheme,
          home: child,
        );
      },

      child: SplashScreen(),
    );
  }
}
double height=0.0;
double width=0.0;
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=>true;
  }
}

