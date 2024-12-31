import 'dart:convert';

import 'package:wts/buttonconstant/buttonConstant';
import 'package:wts/constant/constantColor.dart';
import 'package:wts/constant/textStyleConstant.dart';
import 'package:wts/dashboard/HomeDirectory/bonusrecord.dart';
import 'package:wts/product/ProductController/teamcommission_controller.dart';
import 'package:wts/product/homedcontroller/commissioncontrolletr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;

import '../../constant/apiConstant.dart';



class View_all_team_commission extends StatefulWidget {
  @override
  _View_all_team_commissionState createState() => _View_all_team_commissionState();
}

class _View_all_team_commissionState extends State<View_all_team_commission> {
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
    return Scaffold(
      //
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
            decoration: BoxDecoration(
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
        leading: CustomBackButton(),
        centerTitle: true,
        title: Text('COMMISSION RECORD',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 20,
            color: black,
          ), ),

      ),
      body: ListView(
        shrinkWrap: true,

        children: [
          SizedBox(height: 50,),
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
                            fontSize: 15,
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
                              '${snapshot.data![index].commission}'+'%',
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
          Container(
            width: double.infinity,
            color:bgColor,
            child:Column(
              children: [ Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("get date".toUpperCase(),style: lv1,),
                  Text("userid".toUpperCase(),style: lv1,),
                  // Text("level".toUpperCase(),style: lv1,),
                  Text("level%".toUpperCase(),style: lv1,),
                  Text("commission".toUpperCase(),style: lv1,),
                ],
              ),
                SizedBox(height: 10,),

                FutureBuilder<List<Commission_controller>>(
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
                              fontSize: 15,
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
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 88,
                                          // color: Colors.red,
                                          child: Text('${snapshot.data![index].reedemDate}',style: lv1,)),
                                      Container(
                                          width: 60,
                                          // color: Colors.red,
                                          child: Text('${snapshot.data![index].userids}',style: lv1,)),
                                      // Text('${snapshot.data![index].level}'.toUpperCase(),style: lv1,),
                                      Container(
                                          width: 70,
                                          // color: Colors.red,
                                          child: Text('${snapshot.data![index].levelCommtype}'+"%",style: lv1,)),
                                      Container(
                                          width: 70,
                                          // color: Colors.red,
                                          child: Text('${snapshot.data![index].commAmount}',style: lv1,)),
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
            ),
          ),

        ],
      ),
    );
  }
  Future<List<teamcommisioncontroller>> qwe()  async {
    _comision();
    _selectedCategoryIndex;
    final prefs = await SharedPreferences.getInstance();
    final userid = prefs.getString("userId");
    print(userid);
    print( _selectedCategoryIndex);
    print("🍕🍕🍕🍕🍕🍕🍕🍕🍕🍕🍕");
    final response = await http.get(
        Uri.parse(ApiConst.teamCommission+'$userid'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body)['data'] as List<dynamic>;
      print(response);
      print('kkkkkkkkkkkkkkkkkkkkkkkk');
      return jsonData.map((item) => teamcommisioncontroller.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }




  Future<List<Commission_controller>> _comision()  async {

    var ind=_selectedCategoryIndex.toString();
    final prefs = await SharedPreferences.getInstance();
    final userid = prefs.getString("userId");
    print(userid);
    print( _selectedCategoryIndex);
    print("🍕🍕🍕🍕🍕🍕🍕🍕🍕🍕🍕");
    final response = await http.get(
        Uri.parse(ApiConst.getCommRecords+'$userid&index=$ind'));
    final data =json.decode(response.body);
    print(data);
    if (data['status'] == "200") {
      final jsonData = json.decode(response.body)['data'] as List<dynamic>;
      print(jsonData);

      return jsonData.map((item) => Commission_controller.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }




}
