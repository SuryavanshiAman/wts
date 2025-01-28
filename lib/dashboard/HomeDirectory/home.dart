// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'package:wts/auth/backgroundDesign.dart';
import 'package:wts/constant/apiConstant.dart';
import 'package:wts/constant/assetsConstant.dart';
import 'package:wts/constant/constantColor.dart';
import 'package:wts/dashboard/HomeDirectory/drawer_page.dart';
import 'package:wts/dashboard/HomeDirectory/slider.dart';
import 'package:wts/dashboard/ProductDirectory/commodity.dart';
import 'package:wts/dashboard/ProductDirectory/equity.dart';
import 'package:wts/generated/assets.dart';
import 'package:wts/main.dart';
import 'package:wts/support_api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    SupportApi.fetchdata();
    referEarn();
    viewProfile();
    notification();
    super.initState();
  }

  bool KIsweb = true;
  int selectedIndex=0;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
      key: scaffoldKey,
      drawer:const DrawerPage(),
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              viewProfile();
              if (scaffoldKey.currentState!.isDrawerOpen) {
                scaffoldKey.currentState!.closeDrawer();
              } else {
                scaffoldKey.currentState!.openDrawer();
              }
            },
            child: const Icon(Icons.menu,color: white,)),
        elevation: 0,
        backgroundColor: Colors.white,
        toolbarHeight: height*0.1,
        flexibleSpace: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(45),
                    bottomRight: Radius.circular(45)),
                gradient: LinearGradient(
                    colors: [lightBlue,white, ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter))),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Padding(
          padding:  EdgeInsets.only(right: width*0.12),
          child: Container(
            height: height * 0.03,
            decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage(Adani))),
          ),
        ),
        actions: [
          kIsWeb == true
              ? IconButton(
                  onPressed: () {
                    _launchURL2();
                  },
                  icon: const Icon(Icons.download_for_offline, color: black),
                )
              : Container()
        ],
      ),
      body: ListView(
        shrinkWrap: true,
         physics: const ScrollPhysics(),
        children: [
          SizedBox(
            height: height * 0.05,
          ),
          const SliderPage(),
          SizedBox(
            height: height * 0.03,
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Products:", style: TextStyle(color: black,fontWeight: FontWeight.w600,fontSize: 20)),
          ),
          SizedBox(
            height: height*0.07,
            child: Row(
              children: [
                GestureDetector(
                  onTap:(){
                    setState(() {
                      selectedIndex=0;
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: height*0.07,
                    width: width*0.5,
                  decoration: BoxDecoration(
                    color: selectedIndex==0?lightBlue:bgColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    )
                  ),
                  child: const Text("Stack1",style:TextStyle(
                    fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: white
                  ),),
                  ),
                ),
                GestureDetector(
                    onTap:(){
                      setState(() {
                        selectedIndex=1;
                      });},
                  child: Container(
                    alignment: Alignment.center,
                      height: height*0.07,
                      width: width*0.5,
                  decoration: BoxDecoration(
                    color: selectedIndex==1?lightBlue:bgColor,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      )
                  ),
                  child: const Text("Stack2",style:TextStyle(
                    fontSize: 18,
                      fontWeight: FontWeight.w600,
                    color: white
                  )))),
              ],
            ),
          ),
          selectedIndex==0? const Equity():const Commodity(),

        ],
      ),
    ));
  }

  _launchURL2() async {
    var url = "https://root.worldtradeshiping.co.in/WTS.apk";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }


  var map;

  referEarn() async {
    final prefs = await SharedPreferences.getInstance();
    final userid = prefs.getString("userId");
    final response = await http.post(
      Uri.parse(ApiConst.referEarn),
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
      },
      body: jsonEncode(<String, String>{
        "userid": '$userid',
      }),
    );
    var data = jsonDecode(response.body);
    if (data['status'] == '200') {
      setState(() {
        map = data;
      });
    }
  }


  var userData;
  var notificationText;
  viewProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final userid = prefs.getString("userId");
    final response = await http.get(
      Uri.parse("${ApiConst.profileView}$userid"),
    );
    final data = jsonDecode(response.body);
    if (data['status'] == "200") {
      print(data);
      setState(() {
        userData = data['data'];

      });
      salaryDistribute();
    }
  }
  Future<void> salaryDistribute() async {
    try {
      final response = await http.get(
        Uri.parse("${ApiConst.salaryDistribute}${userData['id']}"),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("SalaryDistribute: $data");
      } else {
        print("Error: Received status code ${response.statusCode}");
        print("Response body: ${response.body}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }
  Future<void> notification() async {
    try {
      final response = await http.get(
        Uri.parse(ApiConst.notification),
      );
      if (response.statusCode == 200) {

        final data = jsonDecode(response.body);
        print("Aman:$data");
        if(data['success']==true){
          setState(() {
            notificationText=data['data']['description'];
          });
          print("Aman:$notificationText");
          showDialog(
              barrierColor: Colors.transparent,
              context: context,
              builder: (context) => AlertDialog(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                        Radius.circular(20))),
                backgroundColor: lightBlue,
                content: Container(
                  height: height *0.4,
                  width: width*0.7,
                  decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.circular(30)),
                  child:  Column(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Notification!',
                        style: TextStyle(
                            fontSize: 18,
                            color: white,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        notificationText,
                        style: TextStyle(
                            fontSize: 16,
                            color: white,
                            fontWeight: FontWeight.w600),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color:bgColor ,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(20))
                          ),
                          child: Text(
                            'OK',
                            style: TextStyle(
                                fontSize: 18,
                                color: white,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ));
        }
        print("SalaryDistribute: $data");
      } else {
        print("Error: Received status code ${response.statusCode}");
        print("Response body: ${response.body}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}
