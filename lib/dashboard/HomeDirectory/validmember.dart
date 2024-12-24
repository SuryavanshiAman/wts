import 'dart:convert';

import 'package:wts/buttonconstant/buttonConstant';
import 'package:wts/constant/constantColor.dart';
import 'package:wts/constant/textStyleConstant.dart';
import 'package:wts/dashboard/HomeDirectory/bonusrecord.dart';
import 'package:wts/product/ProductController/teamcommission_controller.dart';
import 'package:wts/product/homedcontroller/commissioncontrolletr.dart';
import 'package:wts/product/homedcontroller/validmyteamcontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;

import '../../constant/apiConstant.dart';



class Valid_Member extends StatefulWidget {
  @override
  _Valid_MemberState createState() => _Valid_MemberState();
}

class _Valid_MemberState extends State<Valid_Member> {
  int _selectedCategoryIndex = 0;
  Color _containerColor = Colors.white;

  void _changeCategory(int index) {
    setState(() {
      _selectedCategoryIndex = index;
      _containerColor = lightBlue; // Change container color when category is tapped
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
        shrinkWrap: true,

        children: [
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Container(
              width: 300,
              height: 40,

              decoration: BoxDecoration(
                border: Border.all(width: 1,color: lightBlue),
                color: _containerColor,
              ),
              child: FutureBuilder<List<teamcommisioncontroller>>(
                  future: qwe(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    // else if (snapshot.hasError) {
                    //   return Center(
                    //     child: Text('Error: ${snapshot.error}'),
                    //   );
                    // }
                    else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                        child: Text(
                          "No Data Avilable",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp,
                            color: black,
                          ),
                        ),
                      );
                    }
                    else  {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length, // Number of categories
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              _changeCategory(index);
                            },
                            child: Container(
                              width: 100,
                              color: _selectedCategoryIndex == index ? lightBlue : Colors.white,

                              child: Center(child: Text('${snapshot.data![index].lavelStage}'+'-'''
                                  '${snapshot.data![index].commission}'+'%'+"("'${snapshot.data![index].count??0}'
                                  +")",
                                style: lv1,)),
                            ),
                          );
                        },
                      );}
                  }
              ),
            ),
          ),
          SizedBox(height: 10,),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      width:80,
                      child: Center(child: Text("account".toUpperCase(),style: lv1,))),
                  Container(
                      alignment:Alignment.center,
                      width:80,
                      // color: Colors.red,
                      child: Text("level".toUpperCase(),style: lv1,)),
                  Container(
                      alignment:Alignment.center,
                      width:140,
                      // color: Colors.red,
                      child: Text("registration time".toUpperCase(),style: lv1,)),


                ],
              ),
              SizedBox(height: 10,),
              FutureBuilder<List<Valid_My_TeamController>>(
                  future: _comision(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    // else if (snapshot.hasError) {
                    //   return Center(
                    //     child: Text('Error: ${snapshot.error}'),
                    //   );
                    // }
                    else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                        child: Text(
                          "No Data Avilable",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp,
                            color: black,
                          ),
                        ),
                      );
                    }
                    else  {
                      return ListView.builder(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length, // Number of categories
                        itemBuilder: (context, index) {
                          return   Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [

                                    Container(
                                        alignment:Alignment.center,
                                        width:80,
                                        // color: Colors.red,
                                        child: Text('${snapshot.data![index].mobile}',style: lv1,)),
                                    Container(
                                        alignment:Alignment.center,
                                        width:80,
                                        // color: Colors.red,
                                        child: Text('${snapshot.data![index].lavelStage}'.toUpperCase(),style: lv1,)),
                                    Container(
                                        alignment:Alignment.center,
                                        width:140,
                                        // color: Colors.red,
                                        child: Text('${snapshot.data![index].createdAt}',style: lv1,)),
                                  ],
                                ),
                              ),
                              Divider(thickness: 1.5,)
                            ],
                          );
                        },
                      );}
                  }
              ),
            ],
          )

        ],
      );

  }
  Future<List<teamcommisioncontroller>> qwe()  async {
    _selectedCategoryIndex;
    final prefs = await SharedPreferences.getInstance();
    final userid = prefs.getString("userId");
    print(userid);
    final response = await http.get(
        Uri.parse('${ApiConst.teamCommission}$userid'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body)['data'] as List<dynamic>;
      print(response);
      print('kkkkkkkkkkkkkkkkkkkkkkkk');
      return jsonData.map((item) => teamcommisioncontroller.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
  Future<List<Valid_My_TeamController>> _comision()  async {

    var ind=_selectedCategoryIndex.toString();
    final prefs = await SharedPreferences.getInstance();
    final userid = prefs.getString("userId");
    print(userid);
    print( _selectedCategoryIndex);
    print("🍕🍕🍕🍕🍕🍕🍕🍕🍕🍕🍕");
    final response = await http.get(
        Uri.parse('${ApiConst.myTeamActive}$userid&index=$ind'));
    final data =json.decode(response.body);
    print(data);
    if (data['status'] == "200") {
      final jsonData = json.decode(response.body)['data'] as List<dynamic>;
      print(jsonData);

      return jsonData.map((item) => Valid_My_TeamController.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}
