import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wts/buttonconstant/buttonConstant';
import 'package:wts/constant/apiConstant.dart';
import 'package:wts/constant/constantColor.dart';
import 'package:wts/constant/constantButton.dart';
import 'package:wts/constant/textStyleConstant.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Invitation_Page extends StatefulWidget {
  const Invitation_Page({Key? key}) : super(key: key);

  @override
  State<Invitation_Page> createState() => _Invitation_PageState();
}

class _Invitation_PageState extends State<Invitation_Page> {
  @override
  void initState() {
    super.initState();
    REFER_EARN();
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SafeArea(child: Scaffold(
     
      appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: const CustomBackButton(),
          flexibleSpace: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [lightBlue,white],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter
                  )
              )
          ),
          centerTitle: true,
          title:const Text("Refer Details")
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: map==null?Center(child: CircularProgressIndicator()):Column(
          children: [
            Card(elevation: 3,
              child: Container(
                height: height*0.35,
                width:width*0.99,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: white),
                child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text("Invitation code",style: f630,),
                     Text(map['refer_code'].toString(),style: ConstText,),
                    const Text("invite link",style: text,),
                    Container(alignment: Alignment.center,
                      height: height*0.07,
                      width: width*0.7,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color:gray,

                          ),
                          borderRadius: const BorderRadius.all(Radius.circular(2)),
                          color: white),
                      child:  Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("https://admin.sbmpro.live?id=${map['refer_code']}",style: normalText,),
                      ),
                    ),
                    constantbutton(onTap: () {
                      share();
                    }, text: 'Copy invitation link',),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
  var map;
  REFER_EARN() async {
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
  Future<void> share() async {
    await Share.share(
        'Join Now & Get Exiting Prizes. here is my Referral Code'
            ' https://admin.sbmpro.live?id=${map['refer_code']}',
        subject: 'Referral Code : ' + map['refer_code']);
  }
}
