
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:wts/buttonconstant/buttonConstant';
import 'package:wts/constant/apiConstant.dart';
import 'package:wts/constant/assetsConstant.dart';
import 'package:wts/constant/constantColor.dart';
import 'dart:convert';

import 'package:http/http.dart'as http;


class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {

  // ApiController apiController = ApiController();
  @override
  void initState() {
    super.initState();
    About();
    // fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
        child:Scaffold(
          appBar:AppBar(
              leading: const CustomBackButton(),
            backgroundColor:Colors.transparent,
            flexibleSpace: Container(
                decoration:  const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0)),
                    gradient: LinearGradient(
                        colors: [lightBlue, white],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter))),
            automaticallyImplyLeading: false,
            centerTitle: true,
            title:Text('AboutUS',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 20.sp,
                color: black,
              ), )

          ),
          body:SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: HtmlWidget(aboutus.toString())),
        )
    );
  }
  var aboutus;
  Future About() async{
    print("dghjg");
    final url= Uri.parse(ApiConst.aboutUs);
    final response = await http.get(
      url,
    );
    if (response.statusCode ==200){
      print("policy");
      final responseData = json.decode(response.body)['data'];

      setState(() {
        aboutus =responseData["about"];
      });

    }
    else{
      throw Exception("Failed to fetch notification");
    }
  }
}
