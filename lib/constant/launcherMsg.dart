

import 'package:wts/support_api.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Launcher{
  static void openwhatsapp(context) async{
    print(Whatasapp);
    print("whatasapp");
    final String  whatsapp =Whatasapp.toString();
    var whatsappURl_android = "whatsapp://send?phone="+whatsapp+"&text=hello";
    var whatappURL_ios ="https://wa.me/$whatsapp?text=${Uri.parse("hello")}";

    if( await canLaunch(whatsappURl_android)){
      await launch(whatsappURl_android);
    }else{
      ScaffoldMessenger.of(context ).showSnackBar(
          SnackBar(content: new Text("whatsapp not installed")));

    }


  }
  static void  openteligram() async {
    print(telegram);
    print(telegram);
    print("telegram");
    final String groupLink = telegram.toString(); // Replace with your Telegram group link

    if (await canLaunch(groupLink)) {
      await launch(groupLink);
    } else {
      throw "Could not launch $groupLink";
    }
  }


  static void  linkurl() async {
    const url = 'https://www.geeksforgeeks.org/';
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true, enableJavaScript: true);
    } else {
      throw 'Could not launch $url';
    }
  }
}


