import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wts/auth/backgroundDesign.dart';
import 'package:wts/constant/apiConstant.dart';
import 'package:wts/constant/assetsConstant.dart';
import 'package:wts/constant/constantColor.dart';
import 'package:wts/constant/launcherMsg.dart';
import 'package:wts/constant/textStyleConstant.dart';
import 'package:wts/dashboard/HomeDirectory/home.dart';
import 'package:wts/dashboard/HomeDirectory/invitation.dart';
import 'package:wts/dashboard/HomeDirectory/myTeam.dart';
import 'package:wts/dashboard/HomeDirectory/salary_screen.dart';
import 'package:wts/dashboard/HomeDirectory/withdraw.dart';
import 'package:wts/dashboard/MineDirectory/Bindbankaccount.dart';
import 'package:wts/dashboard/MineDirectory/about_us.dart';
import 'package:wts/dashboard/MineDirectory/fundingdetails.dart';
import 'package:wts/dashboard/MineDirectory/mine.dart';
import 'package:wts/dashboard/MineDirectory/myProject.dart';
import 'package:wts/dashboard/MineDirectory/privacy_policy.dart';
import 'package:wts/dashboard/MineDirectory/terms.dart';
import 'package:wts/dashboard/ProductDirectory/refer_earn.dart';
import 'package:wts/generated/assets.dart';
import 'package:wts/main.dart';
import 'package:wts/recharge/rechargeAmount.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'bonus.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({super.key});

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewProfile();
    earning();
  }
  @override
  Widget build(BuildContext context) {
    return  Drawer(
      child: userData != null
          ? ListView(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(0),
            decoration: const BoxDecoration(color: lightBlue),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {

                      },
                      child: const CircleAvatar(
                          radius: 25,
                          backgroundColor: white,
                          backgroundImage:
                          AssetImage("assets/images/about_us.png")),
                    ),

                    // const SizedBox(width: 5,),

                    Column(
                      children: [
                        SizedBox(
                          width: width * 0.4,
                          child: Text(
                            userData['mobile'] ?? '',
                            maxLines: 2,
                            style: TextStyle(fontSize: 20,color: white,fontWeight: FontWeight.w900),

                          ),
                        ),
                        SizedBox(
                          width: width * 0.4,
                          child: Text(
                              userData['userids'] == null
                                  ? "ID: "
                                  : "ID: " + userData['userids'],
                              maxLines: 2,
                              style: TextStyle(fontSize: 20,color: white,fontWeight: FontWeight.w900)),
                        ),

                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.01,
                ),
              ],
            ),
          ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Padding(
                padding: EdgeInsets.only(left: width * 0.07, right: 12),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                            const RechargeAmount()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      // color: green.withOpacity(0.05),
                        border: Border.all(color: lightBlue, width: 2),
                        borderRadius: const BorderRadius.all(
                            Radius.circular(10))),
                    alignment: Alignment.center,
                    height: height * 0.06,
                    width: width * 0.6,
                    child: const Padding(
                      padding: EdgeInsets.only(top: 15.0),
                      child: Text(
                        "ADD CASH",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: lightBlue,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              Positioned(
                bottom: 30,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: width * 0.03, right: width * 0.02),
                  child: Container(
                      decoration: BoxDecoration(
                          color: white,
                          border:
                          Border.all(color: lightBlue, width: 2),
                          borderRadius: const BorderRadius.all(
                              Radius.circular(8))),
                      height: height * 0.075,
                      width: width * 0.68,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: ListTile(
                          leading: Image.asset(
                            "assets/images/wallet.png",
                            scale: 3.4,
                          ),
                          title: const Text("Balance"),
                          trailing: Container(
                            width: width*0.2,
                            child: Text(
                              double.parse(userData['wallet'])
                                  .toStringAsFixed(2) == null
                                  ? "₹0.0": "₹${double.parse(userData['wallet']).toStringAsFixed(2)}",
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      )),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const DetailsPage()));
                  },
                  leading: Image.asset(
                    Assets.imagesProfile,
                    height: 25,
                  ),
                  title: Text(
                    'Profile',
                    style: TextStyle(fontSize: height / 45),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const MyProjectPage()));
                  },
                  leading: Image.asset(
                    Assets.imagesProject,
                    height: 25,
                  ),
                  title: Text(
                    'My project',
                    style: TextStyle(fontSize: height / 45),
                  ),
                ),

                ListTile(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const Account_details()));
                  },
                  leading: Image.asset(
                    Assets.imagesBank,
                    height: 25,
                  ),
                  title: Text(
                    'Bank Details',
                    style: TextStyle(fontSize: height / 45),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const WithdrawPage()));
                  },
                  leading: Image.asset(withdraw,
                    height: 25,
                  ),
                  title: Text(
                    'Withdraw',
                    style: TextStyle(fontSize: height / 45),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const SalaryScreen()));
                  },
                  leading: Image.asset(salary,
                    height: 25,
                  ),
                  title: Text(
                    'Salary',
                    style: TextStyle(fontSize: height / 45),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const Bonus_Page()));                  },
                  leading: Image.asset(bonus,
                    height: 25,
                  ),
                  title: Text(
                    'Bonus',
                    style: TextStyle(fontSize: height / 45),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const FundingDetails()));
                  },
                  leading: Image.asset(
                    Assets.imagesDocument,
                    height: 25,
                  ),
                  title: Text(
                    'Self Report',
                    style: TextStyle(fontSize: height / 45),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const MyTeam()));
                  },
                  leading: Image.asset(
                    Assets.imagesTeam,
                    height: 25,
                  ),
                  title: Text(
                    'Team',
                    style: TextStyle(fontSize: height / 45),
                  ),
                ),
                ListTile(
                  leading: Image.asset(
                    "assets/images/telegram.png",
                    height: 25,
                  ),
                  title: Text(
                    'Telegram',
                    style: TextStyle(fontSize: height / 45),
                  ),
                  onTap: () {
                    Launcher.openteligram();
                  },
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                             const ReferEarn()));
                  },
                  leading: Image.asset(
                    Assets.imagesInvite,
                    height: 25,
                  ),
                  title: Text(
                    'Refer & Earn',
                    style: TextStyle(fontSize: height / 45),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const AboutUs()));
                  },
                  leading: Image.asset(
                    Assets.imagesAboutUs,
                    height: 25,
                  ),
                  title: Text(
                    'AboutUS',
                    style: TextStyle(fontSize: height / 45),
                  ),
                ),
                ListTile(
                  leading: Image.asset(
                    Assets.imagesPolicy,
                    height: 25,
                  ),
                  title: Text(
                    'Privacy Policy',
                    style: TextStyle(fontSize: height / 45),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                            const PrivacyPolicy()));
                  },
                ),
                ListTile(
                  leading: Image.asset(
                    Assets.imagesTerms,
                    height: 25,
                  ),
                  title: Text(
                    'Terms and Conditions',
                    style: TextStyle(fontSize: height / 45),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Terms()));
                  },
                ),

                ListTile(
                  leading: Image.asset(
                    Assets.imagesLogout,
                    height: 22,
                  ),
                  title: Text(
                    'Logout',
                    style: TextStyle(fontSize: height / 45),
                  ),
                  onTap: () {
                    showDialog(
                        barrierColor: Colors.transparent,
                        context: context,
                        builder: (context) => AlertDialog(
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(20))),
                          // backgroundColor: primary,
                          content: Container(
                            height: height / 3.5,
                            width: width / 1.5,
                            decoration: BoxDecoration(
                              // color: Colors.yellow,
                                borderRadius:
                                BorderRadius.circular(30)),
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: 100,
                                  width: 100,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: AssetImage(
                                            Assets.imagesLogout,
                                          ))),
                                ),
                                const Text(
                                  'Do You want to logout?',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              color: Colors.green,
                                            borderRadius: BorderRadius.circular(10)
                                          ),

                                          child: const Text('Cancel',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight:
                                                  FontWeight
                                                      .w700)),
                                        )),
                                    InkWell(
                                        onTap: () async {
                                          SharedPreferences prefs = await SharedPreferences.getInstance();
                                          prefs.remove('userId');
                                          Navigator.pushReplacement(context,
                                              MaterialPageRoute(builder: (BuildContext ctx) =>const BackgroundDesign()));
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius: BorderRadius.circular(10)
                                          ),
                                          padding: const EdgeInsets.all(8),
                                          child: const Text('Logout',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight:
                                                  FontWeight
                                                      .w700)),
                                        )),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ));
                  },
                ),
              ],
            ),
          ),
        ],
      )
          : const Center(child: CircularProgressIndicator()),
    );
  }
  var userData;
  viewProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final userid = prefs.getString("userId");
    final response = await http.get(
      Uri.parse("${ApiConst.profileView}$userid"),
    );
    final data = jsonDecode(response.body);
    if (data['status'] == "200") {
      setState(() {
        userData = data['data'];
      });
    }
  }
  var earn;
  earning() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString("userId");
      if (userId != null) {
        final response = await http.get(Uri.parse('${ApiConst.earnings}$userId'));
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          if (data['status'] == "200") {
            setState(() {
              earn = data['data'];
            });
          } else {
          }
        } else {
        }
      } else {
        print("Error: User ID is null");
      }
    } catch (e) {
      print("Error parsing JSON: $e");
    }
}}
