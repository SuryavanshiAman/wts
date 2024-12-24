import 'dart:convert';
import 'package:wts/buttonconstant/buttonConstant';
import 'package:wts/constant/apiConstant.dart';
import 'package:wts/constant/assetsConstant.dart';
import 'package:wts/constant/constantColor.dart';
import 'package:wts/product/ProductController/rechargerecordconteroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class Recharge_record extends StatefulWidget {
  const Recharge_record({Key? key}) : super(key: key);

  @override
  State<Recharge_record> createState() => _Recharge_recordState();
}

class _Recharge_recordState extends State<Recharge_record> {
  @override
  void initState() {
WidgetsBinding.instance.addPostFrameCallback((_){
  viewProfile();
});

    qwe();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
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
          title: Text('DEPOSIT HISTORY',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 20.sp,
              color: black,
            ), )
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<Recharge_Controlletr>>(
            future: qwe(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: height*0.25,
                        width: width*0.5,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(recharge),
                            )
                        ),
                      ),
                      Text(
                        "No Deposit History",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25.sp,
                          color: black,
                        ),
                      ),

                    ],
                  ),
                );
              }
              else {
                return ListView.builder(

                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return  Card(elevation: 3,
                          child: ListTile(
                            title: Text('ORDER NO.: '+'${snapshot.data![index].orderNumber}',
                                style: TextStyle(fontSize: 14.sp,
                                    fontWeight: FontWeight.w900)),
                            subtitle: Text('${snapshot.data![index].createdAt}'),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    snapshot.data![index].type=='1'?  '₹ '+'${snapshot.data![index].amount}':'\$ '+'${snapshot.data![index].amount}',
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w900)
                                ),
                                snapshot.data![index].status=='0'?
                                Container(
                                  height: 20.h,
                                  width: 70.w,
                                  decoration: BoxDecoration(
                                      color: lightBlue,
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  child:Center(child: Text('PENDING',
                                    style: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.w900,color: white),)),
                                )
                                    :snapshot.data![index].status=='1'
                                    ?Container(
                                  height: 20.h,
                                  width: 70.w,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  child:Center(child: Text('SUCCESS',
                                    style: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.w900,color: white),)),
                                ):Container(
                                  height: 20.h,
                                  width: 70.w,
                                  decoration: BoxDecoration(
                                      color: Colors.redAccent,
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  child:Center(child: Text('FAILED',
                                    style: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.w900,color: white),)),
                                )
                              ],
                            ),
                          )
                      );
                    });
              }
            }),
      ),
    );
  }

  var map;
  viewProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final userid = prefs.getString("userId");
    final response = await http.get(
        Uri.parse(ApiConst.profileView + '$userid'),

    );
    var data = jsonDecode(response.body);
    if (data['status'] == '200') {
      print("Aman:$data");
      setState(() {
        map = data['data'];
      });
    }
  }
  Future<List<Recharge_Controlletr>> qwe()  async {
    print('kkkkkkkkkkkkkkkkkkkkkkkk');
    final prefs = await SharedPreferences.getInstance();
    final userid = prefs.getString("userId");
    print(userid);
    final response = await http.post(
      Uri.parse(ApiConst.walletHistory),
      // headers:<String ,String>{
      //   "Content-Type":"application/json; charset=UTF-8",
      // },
      body: jsonEncode(<String ,String>{
        "userid": map['userids'],
      }),
    );
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body)['data'] as List<dynamic>;
      print(jsonData);
      print('kkkkkkkkkkkkkkkkkkkkkkkk');
      return jsonData.map((item) => Recharge_Controlletr.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}
