// import 'dart:convert';
//
// import 'package:flutter/foundation.dart';
// import 'package:wts/constant/constantColor.dart';
// import 'package:wts/constant/textStyleConstant.dart';
// import 'package:wts/main.dart';
// import 'package:wts/model.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart'as http;
//
// import '../../constant/apiConstant.dart';
//
//
//
// class Valid_Member extends StatefulWidget {
//   @override
//   _Valid_MemberState createState() => _Valid_MemberState();
// }
//
// class _Valid_MemberState extends State<Valid_Member> with TickerProviderStateMixin {
//   int _selectedCategoryIndex = 0;
//   Color _containerColor = Colors.white;
//
//   void _changeCategory(int index) {
//     setState(() {
//       _selectedCategoryIndex = index;
//       _containerColor = lightBlue; // Change container color when category is tapped
//     });
//   }
// @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     validUserData();
//   }
//   @override
//   Widget build(BuildContext context) {
//     TabController tabController = TabController(length: teamList.length, vsync: this);
//     return Container(
//       child: Column(
//         children: [
//           TabBar(
//             tabAlignment:TabAlignment.start ,
//             controller: tabController,
//             isScrollable: true,
//             indicatorColor: bgColor,
//             labelColor: bgColor,
//             unselectedLabelColor: lightBlue,
//             tabs: teamList.map((levelData) {
//               return Tab(text: 'Level ${levelData.level??0}');
//             }).toList(),
//             onTap: (v){
//               _changeCategory(v);
//             },
//           ),SizedBox(
//             height: height*0.02,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               Container(
//                   alignment: Alignment.center,
//                   width: 80,
//                   // color: Colors.red,
//                   child: Text(
//                     "mobile.no".toUpperCase(),
//                     style: gridText,
//                   )),
//               Container(
//                   alignment: Alignment.center,
//                   width: 130,
//                   // color: Colors.red,
//                   child: Text(
//                     "Total Purchase".toUpperCase(),
//                     style: gridText,
//                   )),
//               Container(
//                   alignment: Alignment.center,
//                   width: 140,
//                   // color: Colors.red,
//                   child: Text(
//                     "registration time".toUpperCase(),
//                     style: gridText,
//                   )),
//             ],
//           ),
//           SizedBox(
//             height: height*0.02,
//           ),
//           Expanded(
//             child: TabBarView(
//               controller:tabController ,
//               children: teamList.map((levelData) {
//                 return  teamList[_selectedCategoryIndex].users!.isNotEmpty? ListView.builder(
//                   physics: const BouncingScrollPhysics(),
//                   shrinkWrap: true,
//                   itemCount: teamList[_selectedCategoryIndex].users?.length??0, // Number of categories
//                   itemBuilder: (context, index) {
//                     final userData=teamList[_selectedCategoryIndex].users?[index];
//                     return Column(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Row(
//                             mainAxisAlignment:
//                             MainAxisAlignment.spaceBetween,
//                             children: [
//                               SizedBox(
//                                   width: 85,
//                                   // color: Colors.red,
//                                   child: Text(
//                                     '${userData?.mobile}',
//                                     style: lv1,
//                                   )),
//                               Container(
//                                   alignment: Alignment.center,
//                                   width: 70,
//                                   // color: Colors.red,
//                                   child: Text(
//                                     '${userData?.totalPurchase}'
//                                         .toUpperCase(),
//                                     style: lv1,
//                                   )),
//                               Container(
//                                   alignment: Alignment.center,
//                                   width: 140,
//                                   // color: Colors.red,
//                                   child: Text(
//                                     '${userData?.datetime}',
//                                     style: lv1,
//                                   )),
//                             ],
//                           ),
//                         ),
//                         const Divider(
//                           thickness: 1.5,
//                         )
//                       ],
//                     );
//                   },
//                 ):Center(child: Text("No data Found",style:lv1 ,));
//               }).toList(),
//             ),
//           ),
//         ],
//       ),
//     );
//
//   }
//   List<Data> teamList = [];
//   Future<void> validUserData() async {
//     print("🤣🤣🤣");
//     final prefs = await SharedPreferences.getInstance();
//     final userid = prefs.getString("userId");
//     print(userid);
//     final response =
//     await http.get(Uri.parse('${ApiConst.teamLevel}$userid&type=2'));
//     final data = json.decode(response.body);
//     print('${ApiConst.teamLevel}$userid&type=2');
//     // print("Leveldata$data");
//
//     if (data['status'] == "success") {
//       print("😊😊😊");
//       final List<dynamic> responseData = json.decode(response.body)['data'];
//       setState(() {
//         teamList = responseData.map((item) => Data.fromJson(item)).toList();
//       });
//
//       if (kDebugMode) {
//         print("Fetched data for caseStatus: $responseData");
//       }
//     } else if (response.statusCode == 400) {
//       if (kDebugMode) {
//         print('Data not found');
//       }
//     } else {
//       setState(() {
//         teamList = [];
//       });
//       throw Exception('Failed to load data');
//     }
//   }
// }
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:wts/constant/constantColor.dart';
import 'package:wts/constant/textStyleConstant.dart';
import 'package:wts/dashboard/HomeDirectory/bonusrecord.dart';
import 'package:wts/main.dart';
import 'package:wts/model.dart';
import 'package:wts/product/ProductController/teamcommission_controller.dart';
import 'package:wts/product/homedcontroller/commissioncontrolletr.dart';
import 'package:wts/product/homedcontroller/validmyteamcontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../constant/apiConstant.dart';

class Valid_Member extends StatefulWidget {
  @override
  _Valid_MemberState createState() => _Valid_MemberState();
}

class _Valid_MemberState extends State<Valid_Member> with TickerProviderStateMixin {
  int _selectedCategoryIndex = 0;  // To store the currently selected index
  late TabController tabController;
  Color _containerColor = Colors.white;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: teamList.length, vsync: this);
    validUserData();

  }

  // Sync category index with tabController's index
  void _changeCategory(int index) {
    setState(() {
      _selectedCategoryIndex = index;
      _containerColor = lightBlue;
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TabBar(
            tabAlignment: TabAlignment.start,
            controller: tabController,
            isScrollable: true,
            indicatorColor: bgColor,
            labelColor: bgColor,
            unselectedLabelColor: lightBlue,
            tabs: teamList.map((levelData) {
              return Tab(text: 'Level ${levelData.level ?? 0}');
            }).toList(),
            onTap: (v) {
              _changeCategory(v);  // Update the selected index when a tab is tapped
            },
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                  alignment: Alignment.center,
                  width: 80,
                  child: Text(
                    "mobile.no".toUpperCase(),
                    style: gridText,
                  )),
              Container(
                  alignment: Alignment.center,
                  width: 130,
                  child: Text(
                    "Total Purchase".toUpperCase(),
                    style: gridText,
                  )),
              Container(
                  alignment: Alignment.center,
                  width: 140,
                  child: Text(
                    "registration time".toUpperCase(),
                    style: gridText,
                  )),
            ],
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: teamList.map((levelData) {
                return  teamList[_selectedCategoryIndex].users!.isNotEmpty? ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: teamList[_selectedCategoryIndex].users?.length ?? 0,
                  itemBuilder: (context, index) {
                    final userData = teamList[_selectedCategoryIndex].users?[index];
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                  width: 85,
                                  child: Text(
                                    '${userData?.mobile}',
                                    style: lv1,
                                  )),
                              Container(
                                  alignment: Alignment.center,
                                  width: 70,
                                  child: Text(
                                    '${userData?.totalPurchase}'.toUpperCase(),
                                    style: lv1,
                                  )),
                              Container(
                                  alignment: Alignment.center,
                                  width: 140,
                                  child: Text(
                                    '${userData?.datetime}',
                                    style: lv1,
                                  )),
                            ],
                          ),
                        ),
                        const Divider(
                          thickness: 1.5,
                        )
                      ],
                    );
                  },
                ):const Center(child: Text("No Data Found",style: gridText,));
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  List<Data> teamList = [];

  Future<void> validUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userid = prefs.getString("userId");

    final response = await http.get(Uri.parse('${ApiConst.teamLevel}$userid&type=2'));
    final data = json.decode(response.body);

    if (data['status'] == "success") {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      setState(() {
        teamList = responseData.map((item) => Data.fromJson(item)).toList();
        // Initialize TabController once data is fetched
        tabController = TabController(length: teamList.length, vsync: this);
      });

      // Listen to tab index changes and update _selectedCategoryIndex when scrolling
      tabController.addListener(() {
        if (!tabController.indexIsChanging) {
          setState(() {
            _selectedCategoryIndex = tabController.index;
          });
        }
      });
    } else if (response.statusCode == 400) {
      setState(() {
        teamList = [];
      });
      throw Exception('Failed to load data');
    }
  }
}
