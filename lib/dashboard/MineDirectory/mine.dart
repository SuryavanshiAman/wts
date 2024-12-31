// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:wts/Widgets/rectanglebutton.dart';
import 'package:wts/buttonconstant/buttonConstant';
import 'package:wts/constant/apiConstant.dart';
import 'package:wts/constant/assetsConstant.dart';
import 'package:wts/constant/constantColor.dart';
import 'package:wts/constant/textStyleConstant.dart';
import 'package:wts/dashboard/MineDirectory/accountContainer.dart';
import 'package:wts/main.dart';
import 'package:wts/recharge/rechargeAmount.dart';
import 'package:flutter/material.dart';
import 'package:wts/dashboard/MineDirectory/elementContainer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  void initState() {
    viewProfile();
    earning();
    Monthly_Salary();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SafeArea(child: Scaffold(
      //
      appBar: AppBar(
        elevation: 0,
          leading: const CustomBackButton(),
        backgroundColor: Colors.white,
        // toolbarHeight: height*0.1,
        flexibleSpace: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0)),
                gradient: LinearGradient(
                    colors: [lightBlue, white,],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter))),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('My Profile',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 20.sp,
            color: black,
          ), )
      ),
      body:
      map==null
          ||
          earn== null?
      const Center(child: CircularProgressIndicator()):
      ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        children: [
          Container(
            width: width,
            decoration:  BoxDecoration(
              color:Colors.white,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60),bottomRight: Radius.circular(60) ),

            ),
            child: Column(
              children: [
                ListTile(
                  leading: const Card(elevation: 3,
                    shape: RoundedRectangleBorder( borderRadius: BorderRadius.all(Radius.circular(30),)),
                    child: CircleAvatar(radius: 30,backgroundColor: white,
                      child: Icon(Icons.person),
                    ),
                  ),
                  title:Text(
                    map['mobile'] ?? '',style: f630,) ,
                  subtitle:Text(map['userids']==null?"ID: ":
                  "ID: "+map['userids'],style: normalText,) ,
                ),
                const Divider(),
                ListTile(
                  onTap: (){
                    Navigator.push(context,
                        MaterialPageRoute(
                            builder: (context)=>const RechargeAmount()));
                  },
                  leading: Image.asset(wallet),
                  title:     Text(
                    double.parse(map['wallet']).toStringAsFixed(2)
                        == null?"₹0.0":
                    double.parse(map['wallet']).toStringAsFixed(2),style: ConstText,),
                  subtitle:    const Text("Wallet"),
                  trailing:  CustomButton(
                      onTap: (){
                        Navigator.push(context,
                            MaterialPageRoute(
                                builder: (context)=>const RechargeAmount()));
                      },
                      width: width*0.3,
                      text: "Recharge"
                  )
                  ,
                ),
                ListTile(
                  leading: Image.asset(bonus),
                  title:     Text(
                    double.parse(earn['bonus']).toStringAsFixed(2)
                        ==null?"₹0.0":
                    double.parse(earn['bonus']).toStringAsFixed(2),style: ConstText,),
                  subtitle:    const Text("Bonus"),),
                SizedBox(height: height*0.03,),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("My Earning Details:", style: TextStyle(color: black,fontWeight: FontWeight.w600,fontSize: 18)),
          ),
          Account_Cont(earns: earn),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Text("My Monthly Salary:", style: TextStyle(color: black,fontWeight: FontWeight.w600,fontSize: 18)),
          // ),

          // salary==null?
          // Center(child: CircularProgressIndicator()):
          // Center(
          //   child: Padding(
          //     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          //     child: HtmlWidget(
          //         salary['monthly_salary']
          //     ),
          //   ),
          // )

          // const Elements_cont(),
        ],
      ),

    ));
  }


 var map;
  viewProfile() async {
    print("abhishek");
    final prefs = await SharedPreferences.getInstance();
    final userid = prefs.getString("userId");
    final response = await http.get(
      Uri.parse("${ApiConst.profileView}$userid"),

    );
    final data = jsonDecode(response.body);
    print(data);
    print("ChalaData");
    if (data['status'] == "200") {
      setState(() {
        map = data['data'];
      });
    }
  }
  var earn;
  earning() async {

    final prefs = await SharedPreferences.getInstance();
    final userid = prefs.getString("userId");
    final response = await http.get(
      Uri.parse('${ApiConst.earnings}$userid'),

    );
    final data = jsonDecode(response.body);
    print(data);
    print("dataearning");
    if (data['status'] == "200") {
      setState(() {
        earn = data['data'];
      });
    }
  }
  var  salary;
  Monthly_Salary() async {

    final response = await http.get(
      Uri.parse(ApiConst.monthlySalary),

    );
    var data = jsonDecode(response.body);
    print(data);
    print("mmmmmmmmmmmm");
    if (data['status'] == '200') {
      setState(() {
        salary = data['data'];
      });
    }
  }
}
