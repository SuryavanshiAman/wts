import 'dart:convert';

import 'package:wts/Widgets/rectanglebutton.dart';
import 'package:wts/buttonconstant/buttonConstant';
import 'package:wts/constant/apiConstant.dart';
import 'package:wts/constant/constantColor.dart';
import 'package:wts/constant/flushbar.dart';
import 'package:wts/constant/textStyleConstant.dart';
import 'package:wts/dashboard/HomeDirectory/bonusrecord.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
import 'package:wts/generated/assets.dart';

class Bonus_Page extends StatefulWidget {
  const Bonus_Page({Key? key}) : super(key: key);


  @override
  State<Bonus_Page> createState() => _Bonus_PageState();
}

class _Bonus_PageState extends State<Bonus_Page> {
  bool _loading=true;
  TextEditingController bonusController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return SafeArea(child:
    Scaffold(
     
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          flexibleSpace: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  gradient: LinearGradient(
                      colors: [lightBlue,white],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter
                  )
              )
          ),
          automaticallyImplyLeading: false,
          leading: const CustomBackButton(),
          centerTitle: true,
          title: Text('BONUS',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 20.sp,
              color: black,
            ), ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Bonus_Record()));
              },
              child: Text('Bonus History',
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w900,
                      color: black)))
        ],
      ),
      body: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: lightBlue.withOpacity(0.08),
            image: const DecorationImage(image:AssetImage(Assets.imagesBonusBg),
        fit: BoxFit.cover
        )),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: height*0.13,),
            Text("Bonus Code",style:bonusSty ,),
            SizedBox(height: height*0.03,),
            TextField(
              controller: bonusController,
              decoration: const InputDecoration(
                border:   OutlineInputBorder(),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      width: 1, color: Colors.black),
                ),
                focusedBorder:
                UnderlineInputBorder(
                  borderSide: BorderSide(
                      width: 1, color: Colors.black),
                ),
                hintText: "Please enter red envelop code",
              ),
            ),
            SizedBox(height: height*0.03,),
            CustomButton(onTap: () {
              Bonus(bonusController.text);
            }, text: 'Receive',)
          ],
      ),
        )
      ),
    ));
  }
Bonus(String bonusController,)async {
    final prefs = await SharedPreferences.getInstance();
    final userid = prefs.getString("userId");
    setState(() {
      _loading=true;
    });

    final response =  await http.post(Uri.parse(ApiConst.redeemBonus),

      body: jsonEncode(<String ,String>{

        "userid":'$userid',
       "bonuscode":bonusController,
      }),
    );
    var data = jsonDecode(response.body);
    print(data);
    print('qqqqqqqqqqqqqqqqqq');
    if(data["status"]=='200'){

      setState(() {
        _loading=false;
      });
      Navigator.pop(context);
      Utils.flushBarSuccessMessage(data["msg"],context,white);
    }
    else{
      setState(() {
        _loading= false;
      });
      Utils.flushBarErrorMessage( data["msg"],context,white);
    }

  }
}
