import 'package:flutter/material.dart';
import 'package:wts/constant/constantColor.dart';
import 'package:wts/dashboard/HomeDirectory/unexpectedproduct.dart';

class My_Project extends StatefulWidget {
  const My_Project({Key? key}) : super(key: key);

  @override
  State<My_Project> createState() => _My_ProjectState();
}

class _My_ProjectState extends State<My_Project>with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    TabController _tabContrller = TabController(length: 2, vsync: this);
    return SafeArea(child: Scaffold(
     
      appBar: AppBar(
          flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [lightBlue,white],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter
                  )
              )
          ),
          centerTitle: true,
          title:Text("Project")
      ),
      body: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: [
          Container(
            // height: height*0.06,
            // width: width*0.9,
            // color: Colors.black,
            child: TabBar(
              controller: _tabContrller,
              unselectedLabelColor: black,
              labelColor: lightBlue,
              // indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: Colors.transparent,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: white,),

              tabs: [
                Container(
                  child: Tab(
                    text: ("unexpired product"),
                  ),
                ),
                // Tab(
                //   text: ("ONCOMING"),
                // ),
                Container(
                  child: Tab(
                    text: ("expired prooduct"),
                  ),
                ),
              ],
            ),
          ),
          Text("Total:₹46500.00"),
          Container(
            height: height,
            child: TabBarView(controller: _tabContrller, children: [
               Unexpired_product(),

            ]),
          )
        ],
      ),
    ));
  }
}
