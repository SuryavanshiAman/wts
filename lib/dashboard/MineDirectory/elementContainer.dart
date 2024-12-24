import 'package:wts/auth/backgroundDesign.dart';
import 'package:wts/dashboard/HomeDirectory/myTeam.dart';
import 'package:wts/dashboard/MineDirectory/Bindbankaccount.dart';
import 'package:wts/dashboard/MineDirectory/about_us.dart';
import 'package:wts/dashboard/MineDirectory/change_password.dart';
import 'package:wts/dashboard/MineDirectory/fundingdetails.dart';
import 'package:wts/dashboard/MineDirectory/myProject.dart';
import 'package:wts/dashboard/MineDirectory/privacy_policy.dart';
import 'package:wts/dashboard/MineDirectory/terms.dart';
import 'package:wts/dashboard/ProductDirectory/refer_earn.dart';
import 'package:flutter/material.dart';
import 'package:wts/constant/assetsConstant.dart';
import 'package:wts/constant/constantColor.dart';
import 'package:wts/constant/textStyleConstant.dart';
import 'package:wts/dashboard/HomeDirectory/bonus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wts/support_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';


class Elements_cont extends StatefulWidget {
  const Elements_cont({Key? key}) : super(key: key);

  @override
  State<Elements_cont> createState() => _Elements_contState();
}

class _Elements_contState extends State<Elements_cont> {
  // _launchURL() async {
  //   var url = "https://api.whatsapp.com/send/?phone="+Whatasapp+"&text=Hello+100Xbull&type=phone_number&app_absent";
  //       // "whatsapp://send?phone="+whatsapp+"&text=hello";
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }
  @override
  void initState() {
    SupportApi.fetchdata();
    // REFER_EARN();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(elevation: 3,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            )),
        child: Container(

          decoration: BoxDecoration(
            border: Border.all(color: lightBlue),
            borderRadius: const BorderRadius.all(Radius.circular(20),)
            ,color: white,),
          child: GridView(

            shrinkWrap: true,
             physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              // crossAxisSpacing: 1.0,
                // mainAxisSpacing: 1.0,
            ),
             // itemCount: 10,
            scrollDirection: Axis.vertical,
            children: [
              InkWell(
                onTap: (){
                  print("😂😂😂😂😂");
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const MyProjectPage()));
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(elevation:6,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80),
                          //set border radius more than 50% of height and width to make circle
                        )
                        ,
                        child: const CircleAvatar(
                          radius:22,
                          backgroundColor: Colors.white,
                          child:
                          CircleAvatar(radius: 16,
                            backgroundImage: AssetImage(project),backgroundColor: Colors.white, ),
                        ),
                      ),
                    ),
                    const Center(
                      child: Text('My project',style: gridText,),
                    ),
                    // title: name[index]
                  ],
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const Bonus_Page()));
                  // _launchEmail();
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(elevation:6,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80),

                        )
                        ,
                        child: const CircleAvatar(
                          radius:22,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(radius: 16,

                            backgroundImage: AssetImage(bonus),backgroundColor: Colors.white, ),
                        ),
                      ),

                    ),
                    const Center(
                      child: Text('Bonus',style: gridText,),
                    ),
                    // title: name[index]
                  ],
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const Account_details(
                  )));
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(elevation:6,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80),
                          //set border radius more than 50% of height and width to make circle
                        )
                        ,
                        child: const CircleAvatar(
                          radius:22,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(radius: 16,

                            backgroundImage: AssetImage(bankAc),backgroundColor: Colors.white, ),
                        ),
                      ),

                    ),
                    const Center(
                      child: Text('Bind bank account',style: gridText,),
                    ),
                    // title: name[index]
                  ],
                ),
              ),
              InkWell(
                onTap: (){
                  _launchURL();

                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(elevation:6,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80),
                          //set border radius more than 50% of height and width to make circle
                        )
                        ,
                        child: const CircleAvatar(
                          radius:22,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(radius: 16,
                            backgroundImage: AssetImage(support),backgroundColor: Colors.white, ),
                        ),
                      ),
                    ),
                    const Center(
                      child: Text('Support',style: gridText,),
                    ),
                    // title: name[index]
                  ],
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const Changepassword()));
                  // Teligram();
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(elevation:6,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80),
                          //set border radius more than 50% of height and width to make circle
                        )
                        ,
                        child: const CircleAvatar(
                          radius:22,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(radius: 16,

                            backgroundImage: AssetImage(changePassword),backgroundColor: Colors.white, ),
                        ),
                      ),
                    ),
                    const Center(
                      child: Text('Change Password',style: gridText,),
                    ),
                    // title: name[index]
                  ],
                ),
              ),
              InkWell(
                onTap: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>const FundingDetails()));
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(elevation:6,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80),
                          //set border radius more than 50% of height and width to make circle
                        )
                        ,
                        child: const CircleAvatar(
                          radius:22,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(radius: 16,

                            backgroundImage: AssetImage(funding),backgroundColor: Colors.white, ),
                        ),
                      ),
                    ),
                    const Center(
                      child: Text('Funding details',style: gridText,),
                    ),
                    // title: name[index]
                  ],
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const ReferEarn()));
                  // _launchEmail();
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(elevation:6,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80),
                          //set border radius more than 50% of height and width to make circle
                        )
                        ,
                        child: const CircleAvatar(
                          radius:22,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(radius: 16,

                            backgroundImage: AssetImage(invitation),backgroundColor: Colors.white, ),
                        ),
                      ),
                    ),
                    const Center(
                      child: Text('Invitation',style: gridText,),
                    ),
                    // title: name[index]
                  ],
                ),
              ),
              InkWell(
                onTap: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>const MyTeam()));
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(elevation:6,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80),
                          //set border radius more than 50% of height and width to make circle
                        )
                        ,
                        child: const CircleAvatar(
                          radius:22,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(radius: 16,

                            backgroundImage: AssetImage(teams),backgroundColor: Colors.white, ),
                        ),
                      ),
                    ),
                    const Center(
                      child: Text('My teams',style: gridText,),
                    ),
                    // title: name[index]
                  ],
                ),
              ),
              InkWell(
                onTap: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>const PrivacyPolicy()));
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(elevation:6,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80),
                          //set border radius more than 50% of height and width to make circle
                        )
                        ,
                        child: const CircleAvatar(
                          radius:22,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(radius: 16,

                            backgroundImage: AssetImage(policy),backgroundColor: Colors.white, ),
                        ),
                      ),
                    ),
                    const Center(
                      child: Text('Privacy Policy',style: gridText,),
                    ),
                    // title: name[index]
                  ],
                ),
              ),
              InkWell(
                onTap: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>const Terms()));
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(elevation:6,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80),
                          //set border radius more than 50% of height and width to make circle
                        )
                        ,
                        child: const CircleAvatar(
                          radius:22,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(radius: 16,

                            backgroundImage: AssetImage(condition),backgroundColor: Colors.white, ),
                        ),
                      ),
                    ),
                    const Center(
                      child: Text('Terms & Condition',style: gridText,),
                    ),
                    // title: name[index]
                  ],
                ),
              ),
              InkWell(
                onTap: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>const AboutUs()));
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(elevation:6,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80),
                          //set border radius more than 50% of height and width to make circle
                        )
                        ,
                        child: const CircleAvatar(
                          radius:22,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(radius: 16,

                            backgroundImage: AssetImage(aboutus),backgroundColor: Colors.white, ),
                        ),
                      ),
                    ),
                    const Center(
                      child: Text('AboutUs',style: gridText,),
                    ),
                    // title: name[index]
                  ],
                ),
              ),
              InkWell(
                onTap: (){
                  showDialog(

                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        elevation: 0,
                        backgroundColor: Colors.white,

                        content:  SizedBox(
                          height: 300.r,

                          child: Column(
                            children: [

                              Container(
                                height: 200.r,
                                width: 200.r,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: AssetImage(
                                          Setting

                                        )
                                    )
                                ),

                              ),

                              Text('Are you Sure?',style: TextStyle(fontSize: 40.sp,fontWeight: FontWeight.w900),),
                              const Spacer(),


                            ],
                          ),
                        ),
                        actions: [
                          ElevatedButton(onPressed: (){
                            Navigator.pop(context);
                          },
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0.r),

                                  ), backgroundColor: Colors.redAccent,
                                  elevation: 10,
                                  textStyle: const TextStyle(fontWeight: FontWeight.bold)),
                              child: const Text('Cancle')),
                          ElevatedButton(onPressed: () async {
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.remove('userId');
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (BuildContext ctx) =>const BackgroundDesign()));
                          },
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius:  BorderRadius.circular(10.0.r),
                                  ), backgroundColor: Colors.green,
                                  elevation: 10,
                                  textStyle: const TextStyle(fontWeight: FontWeight.bold)),
                              child: const Text('Logout')),
                        ],



                      );
                    },
                  );
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(elevation:6,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80),
                          //set border radius more than 50% of height and width to make circle
                        )
                        ,
                        child: const CircleAvatar(
                          radius:22,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(radius: 16,

                            backgroundImage: AssetImage(Setting),backgroundColor: Colors.white, ),
                        ),
                      ),
                    ),
                    const Center(
                      child: Text('Log Out',style: gridText,),
                    ),
                    // title: name[index]
                  ],
                ),
              ),

            ],
          ),

        ),
      ),
    );
  }
  _launchURL() async {
    var url = "${"https://api.whatsapp.com/send/?phone="+Whatasapp}&text=Hello+100XBull&type=phone_number&app_absent";
    // "whatsapp://send?phone="+whatsapp+"&text=hello";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
