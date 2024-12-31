import 'dart:io';

import 'package:flutter/foundation.dart';
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
     // width = kIsWeb?400:MediaQuery.of(context).size.width;
     // height =MediaQuery.of(context).size.height;
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width > 500 ? 500 : MediaQuery.of(context).size.width;
    return Builder(
      builder: (context) {
        if (kIsWeb) {
          width = MediaQuery.of(context).size.width > 500
              ? 500
              : MediaQuery.of(context).size.width;
          return ScreenUtilInit(
            designSize: const Size(360, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context , child) {
              return MaterialApp(
                builder: (context, child) {
                  return Center(
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: width,
                      ),
                      child: child,
                    ),
                  );
                },
                title: "WTS",
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                ),
                debugShowCheckedModeBanner: false,
                home:child
              );
            },

            child: SplashScreen(),
          );

        } else {
          return ScreenUtilInit(
            designSize: const Size(360, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context , child) {
              return  MaterialApp(
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                ),
                title: "WTS",
                debugShowCheckedModeBanner: false,
                home: child,
              );
            },

            child: SplashScreen(),
          );

        }
      },
    );
    //   Center(
    //   child: Container(
    //     constraints: BoxConstraints(
    //         maxWidth: width
    //     ),
    //     child: Builder(
    //       builder: (context) {
    //         return MaterialApp(
    //             debugShowCheckedModeBanner: false,
    //             title: 'WTS',
    //             theme: ThemeData(
    //               primarySwatch: Colors.blue,
    //             ),
    //         // theme: lightTheme,
    //         // darkTheme: darkTheme,
    //             home: SplashScreen(),
    //         );
    //       }
    //     ),
    //   ),
    // );
    ///
//       ScreenUtilInit(
//       designSize: const Size(360, 690),
//       minTextAdapt: true,
//       splitScreenMode: true,
//       builder: (context , child) {
//         return MaterialApp(
//           debugShowCheckedModeBanner: false,
//           title: 'WTS',
//           theme: ThemeData(
//             primarySwatch: Colors.blue,
//           ),
// // theme: lightTheme,
// // darkTheme: darkTheme,
//           home: SplashScreen(),,
//         );
//       },
//
//       child: SplashScreen(),
//     );
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

