import 'package:wts/buttonconstant/buttonConstant';
import 'package:wts/constant/constantColor.dart';
import 'package:wts/dashboard/HomeDirectory/invalidmember.dart';
import 'package:wts/dashboard/HomeDirectory/validmember.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyTeam extends StatefulWidget {
  const MyTeam({Key? key}) : super(key: key);

  @override
  State<MyTeam> createState() => _MyTeamState();
}

class _MyTeamState extends State<MyTeam> with TickerProviderStateMixin{


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    TabController tabController = TabController(length: 2, vsync: this);
    return SafeArea(child: Scaffold(
     
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(00),
                    bottomRight: Radius.circular(00)),
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
        title: Text('MY TEAM',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 20.sp,
            color: black,
          ), ),

      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(10),
                 color: lightGray2
               ),

                child: TabBar(
                  controller: tabController,
                  unselectedLabelColor:black,
                  labelColor: lightBlue,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorColor: lightBlue,

                  tabs:  [
                    Tab(
                      text: ("All Member"),
                    ),
                    // Tab(
                    //   text: ("ONCOMING"),
                    // ),
                    Tab(
                      text: ("Valid Member"),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: height*0.77,
            child:  TabBarView(controller: tabController, children: [
              Invalid_Member(),
              Valid_Member(),

            ]),
          )
        ],
      ),
    ));
  }
}
