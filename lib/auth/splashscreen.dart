import 'dart:async';

import 'package:wts/auth/backgroundDesign.dart';
import 'package:wts/constant/assetsConstant.dart';
import 'package:wts/constant/constantColor.dart';
import 'package:wts/dashboard/HomeDirectory/home.dart';
import 'package:wts/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    harsh();
  }

  harsh()async{
    final prefs = await SharedPreferences.getInstance();
    final userid=prefs.getString("userId")??'0';
    Timer(const Duration(seconds: 3),
          ()=> userid !='0'?Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Home()))
          :Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const BackgroundDesign(),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
     
      body: Container(
        // decoration: const BoxDecoration(
            // gradient: LinearGradient(
            //     colors: [lightBlue, bgColor],
            //     begin: Alignment.bottomCenter,
            //     end: Alignment.topCenter)),
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: height*0.15,),
            Center(
              child: Container(
                height: height*0.4,
                width: width*0.88,

                decoration: const BoxDecoration(image: DecorationImage(
                    image: AssetImage(logo),fit: BoxFit.fill),
                // color: Colors.red
                ),
              ),
            ),
            SizedBox(height: height*0.15,),
            const CircularProgressIndicator(
              color: black,
              strokeWidth: 6,

            )
          ],
        ),
      ),
    );
  }
}
