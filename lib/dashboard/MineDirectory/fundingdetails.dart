import 'dart:convert';
import 'package:wts/buttonconstant/buttonConstant';
import 'package:wts/constant/apiConstant.dart';
import 'package:wts/constant/assetsConstant.dart';
import 'package:wts/constant/constantColor.dart';
import 'package:wts/product/fundingdetailscontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class FundingDetails extends StatefulWidget {
  const FundingDetails({Key? key}) : super(key: key);

  @override
  State<FundingDetails> createState() => _FundingDetailsState();
}

class _FundingDetailsState extends State<FundingDetails> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
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
          title: Text('SELF REPORT',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 20.sp,
              color: black,
            ), )
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<Funding_Details_Controller>>(
            future: qwe(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 200,
                        width: 700,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(recharge),
                            )
                        ),
                      ),
                      Text(
                        "No Self Report History",
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

                            title:
                            snapshot.data![index].type=='1'
                                ? Text("RECHARGE",
                            style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700)
                          ):snapshot.data![index].type=='2'
                                ?Text("BONUS",
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w700)):
                                snapshot.data![index].type=='3'?
                                Text("COMMISSION",
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w700)):
                                snapshot.data![index].type=='4'?
                                Text("PRODUCT",
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w700)):   Text("WITHDRAWAL",
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w700)),
                            subtitle: Text('${snapshot.data![index].createdAt}'),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    '₹ '+'${snapshot.data![index].amount}',
                                    style: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w900)
                                ),
                                Text(
                                    double.parse("${snapshot.data![index].userwallet}").toStringAsFixed(2)
                                    == "null"?"₹0.0":
                                double.parse("${snapshot.data![index].userwallet}").toStringAsFixed(2),
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w700)
                                ),

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

  Future<List<Funding_Details_Controller>> qwe()  async {
    final prefs = await SharedPreferences.getInstance();
    final userid = prefs.getString("userId");
    final response = await http.get(
      Uri.parse("${ApiConst.fundDetails}$userid"),

    );
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body)['data'] as List<dynamic>;
      return jsonData.map((item) => Funding_Details_Controller.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}



