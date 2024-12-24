// ignore_for_file: non_constant_identifier_names, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:wts/buttonconstant/buttonConstant';
import 'package:wts/constant/apiConstant.dart';
import 'package:wts/constant/assetsConstant.dart';
import 'package:wts/constant/constantColor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
import 'package:share_plus/share_plus.dart';


class ReferEarn extends StatefulWidget {
  const ReferEarn({Key? key, }) : super(key: key);
  @override
  State<ReferEarn> createState() => _ReferEarnState();
}
class _ReferEarnState extends State<ReferEarn> {
  bool KIsweb=true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
         
          appBar: AppBar(
            backgroundColor:Colors.transparent,
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
              title: const Text('REFER & EARN',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                  color: black,
                ), )
          ),
          body: map==null?const Center(child: CircularProgressIndicator()):
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 300,
                width: 350,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(30),
                        bottomLeft: Radius.circular(30)),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(referEarn),
                    )
                  // ,color: primaryColor
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'SHARE AND EARN MORE!',
                style: TextStyle(
                    color: black,
                    fontSize: 25,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 15,
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(25, 0, 15, 0),
                child: Text("Invite your friend to use our app and you'll get 5% of the first deposit first time .This will be added to your bonus balance so,you use it to purchase any product.",
                    style: TextStyle(color: black, fontSize: 12)),
              ),
              const SizedBox(
                height: 20,
              ),
              DottedBorder(
                color: lightRed,
                strokeWidth: 2,
                radius: const Radius.circular(12),
                dashPattern: const [
                  5,
                  5,
                ],
                child: Container(
                  alignment: Alignment.center,
                  height: 40,

                  color: gray,
                  child: Text(
                    map['refer_code'],

                    style: const TextStyle(

                      color: black,
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  height: 35,
                  width: 170,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: lightBlue),
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                  ),
                  child:
                  InkWell(
                    onTap: ()async {
                      share();
                    },
                    child: const Row  (
                      children: [
                        CircleAvatar(
                            radius: 20,
                            backgroundColor: gray,
                            child: Icon(
                              Icons.share,
                              color: white,
                            )),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Share the code",
                            style: TextStyle(
                              color: black,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ))
                      ],
                    ),
                  )
                ),
              ),
            ],
          ),
        ));
  }

  @override
  void initState() {
    REFER_EARN();
    super.initState();
  }
  var map;

  REFER_EARN() async {
    final prefs = await SharedPreferences.getInstance();
    final userid = prefs.getString("userId");
    final response =  await http.post(
      Uri.parse(ApiConst.referEarn),
      headers:<String ,String>{
        "Content-Type":"application/json; charset=UTF-8",
      },
      body: jsonEncode(<String ,String>{
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

  // String referralCode = 'initialData';
  Future<void> share() async {

    await Share.share(
        'Join Now & Get Exiting Prizes. here is my Referral Code'
            ' https://root.worldtradeshiping.co.in/?id=${map['refer_code']}',
        subject: 'Referral Code : ' + map['refer_code']);

  }

  void copyToClipboard(String code, BuildContext context) {
    Clipboard.setData(
      ClipboardData(
        text: code,

      ),
    ).then(
          (value) => ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text('Copied to clipboard'),
        ),
      ),
    );
  }
}
