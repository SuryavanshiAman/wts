import 'package:wts/constant/assetsConstant.dart';
import 'package:wts/constant/launcherMsg.dart';
import 'package:wts/dashboard/HomeDirectory/home.dart';
import 'package:wts/dashboard/dashboard.dart';
import 'package:wts/support_api.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:wts/constant/constantColor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';



bool KIsweb=true;
_launchURL() async {
  var url = "https://api.whatsapp.com/send/?phone="+Whatasapp+"&text=Hello+Foundercode&type=phone_number&app_absent"
      "whatsapp://send?phone="+whatsapp+"&text=hello";
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
class Utils {
  static void flushBarErrorMessage(String message, BuildContext context,Color messageColor) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        message: message,
        messageColor: messageColor,
        forwardAnimationCurve: Curves.decelerate,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        padding: const EdgeInsets.all(15),
        duration: const Duration(seconds: 3),
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: lightRed,
        borderRadius: BorderRadius.circular(20),
        positionOffset: 20,
        icon: const Icon(
          Icons.error_outline,
          size: 30,
          color: Colors.white,
        ),
      )..show(context),
    );
  }

  static void flushBarSuccessMessage(String message, BuildContext context,Color messageColor) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        message: message,
        messageColor: messageColor,
        forwardAnimationCurve: Curves.decelerate,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        padding: const EdgeInsets.all(15),
        duration: const Duration(seconds: 3),
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: Colors.green,
        borderRadius: BorderRadius.circular(20),
        positionOffset: 20,
        icon: const Icon(
          Icons.check_circle_outline_outlined,
          size: 30,
          color: Colors.white,
        ),
      )..show(context),
    );
  }


  static void SuccessPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          content: SizedBox(
            height: 250,
            child: Column(
              children: [
                Container(
                  height: 80,
                  width: 80,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage(
                            successPop,
                          ))),
                ),
                const Text(
                  'Your Payment Will be updated \n within 2 minutes',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                      color: black),
                ),
                const Spacer(),
                const Text(
                  'If any Payment related support  :',
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: black),
                ),
                TextButton(
                  onPressed: () {
                    if(KIsweb==true){
                      _launchURL();
                    }else{ Launcher.openwhatsapp(context);}
                    // Launcher.openwhatsapp(context);
                    // openteligram();
                  },
                  child: const Text(
                    'Whatsapp Link',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: black),
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context)=> const Home()));
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                        ), backgroundColor: lightBlue,
                        elevation: 10,
                        textStyle: const TextStyle(fontWeight: FontWeight.bold,color: Colors.white)),
                    child: const Text('Go Back')),
              ],
            ),
          ),
        );
      },
    );
  }
  static void RechargePopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          content: SizedBox(
            height: 230.r,
            child: Column(
              children: [
                Container(
                  height: 80.r,
                  width: 80.r,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage(
                            successPop,
                          ))),
                ),
                Center(
                  child: Text(
                    'Your recharge has been \n   done successfully',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        color: black),
                  ),
                ),
                const Spacer(),
                Text(
                  'If any Payment related support  :',
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: black),
                ),
                TextButton(
                  onPressed: () {
                   Launcher.openwhatsapp(context);
                  },
                  child: Text(
                    'Whatsapp Link',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: black),
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context)=> const Home()));
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                        ), backgroundColor: lightBlue,
                        elevation: 10,
                        textStyle: const TextStyle(fontWeight: FontWeight.bold)),
                    child: const Text('Go Back')),
              ],
            ),
          ),
        );
      },
    );
  }
  static void ReedemPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          content: SizedBox(
            height: 200.r,
            child: Column(
              children: [
                Container(
                  height: 80.r,
                  width: 80.r,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage(
                            successPop,
                          ))),
                ),

                const Spacer(),

                TextButton(
                  onPressed: () {
                    // openteligram();
                  },
                  child: Text(
                    'Telegram Link',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 8,
                        fontWeight: FontWeight.w500,
                        color: black),
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                        ), backgroundColor: lightBlue,
                        elevation: 10,
                        textStyle: const TextStyle(fontWeight: FontWeight.bold)),
                    child: const Text('Go Back')),
              ],
            ),
          ),
        );
      },
    );
  }

}