
import 'package:wts/buttonconstant/buttonConstant';
import 'package:wts/constant/constantColor.dart';
import 'package:wts/dashboard/MineDirectory/redeemed_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wts/main.dart';

import 'fixed_page.dart';

class MyProjectPage extends StatefulWidget {
  const MyProjectPage({Key? key}) : super(key: key);

  @override
  State<MyProjectPage> createState() => _MyProjectPageState();
}

class _MyProjectPageState extends State<MyProjectPage>with TickerProviderStateMixin {
  bool loading=true;

  @override
  Widget build(BuildContext context) {

    TabController tabController = TabController(length: 2, vsync: this);
    return Scaffold(

      appBar: AppBar(
          backgroundColor: Colors.transparent,
        flexibleSpace: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0)),
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
        title: Text('MY PROJECT',
          style: TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 20.sp,
          color: black,
        ), ),

      ),
      body: RedeemedPage(),
      // TabBarView(controller: tabController, children: const [
      //   RedeemedPage(),
      //   FixedPage(),
      //
      // ]),

    );
  }



}
