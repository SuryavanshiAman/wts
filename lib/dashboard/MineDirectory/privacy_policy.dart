
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:wts/buttonconstant/buttonConstant';
import 'package:wts/constant/apiConstant.dart';
import 'package:wts/constant/assetsConstant.dart';
import 'package:wts/constant/constantColor.dart';
import 'dart:convert';

import 'package:http/http.dart'as http;


class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {

  // ApiController apiController = ApiController();
  @override
  void initState() {
    super.initState();
    Policy();
    // fetchData();
  }

  // Future<void> fetchData() async {
  //   try {
  //     final commonData = await apiController.fetchCommonData(ApiUrl.refundPolicy);
  //     if (commonData != null) {
  //       Provider.of<CommonViewProvider>(context, listen: false)
  //           .setCommonData(commonData);
  //     }
  //   } catch (error) {
  //     // Handle error here
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    // final commonData = Provider.of<CommonViewProvider>(context).commonData;
    return SafeArea(
        child:Scaffold(
          appBar:AppBar(
            backgroundColor:Colors.transparent,
            flexibleSpace: Container(
                decoration:  BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0)),
                    gradient: LinearGradient(
                        colors: [lightBlue, white],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter))),
            automaticallyImplyLeading: false,
            centerTitle: true,
            leading: CustomBackButton(),
            title: Text('Privacy Policy',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 20,
                color: black,
              ), ),

          ),
          body:SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: HtmlWidget(privacypolicy.toString())),
        )
    );
  }
  var privacypolicy;
  Future Policy() async{

    final url= Uri.parse(ApiConst.privacyPolicy);
    final response = await http.get(
      url,
    );
    if (response.statusCode ==200){
      print("policy");
      final responseData = json.decode(response.body)['data'];
setState(() {
  privacypolicy =responseData["privacy_policy"];
});



    }
    else{
      throw Exception("Failed to fetch notification");
    }
  }
}
