import 'dart:convert';
import 'package:wts/constant/apiConstant.dart';
import 'package:wts/constant/assetsConstant.dart';
import 'package:wts/constant/constantColor.dart';
import 'package:wts/constant/constantButton.dart';
import 'package:wts/constant/disableButton.dart';
import 'package:wts/constant/textStyleConstant.dart';
import 'package:wts/product/ProductController/ProductAdaniController.dart';
import 'package:flutter/material.dart';
import 'package:wts/dashboard/ProductDirectory/productView.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class Currency extends StatefulWidget {
  const Currency({Key? key}) : super(key: key);

  @override
  State<Currency> createState() => _CurrencyState();
}

class _CurrencyState extends State<Currency> {

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;




    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder<List<ProductAdaniController>>(
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
                      height: 200,
                      width: width*0.7,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(noData),
                          )
                      ),
                    ),
                    Text(
                      "No Currency",
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
              return GridView.builder(
                  gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 450,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return  Card(elevation: 3,
                      child: Container(
                        height: height*0.3,
                        width:width*0.8,
                        decoration: const BoxDecoration( borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: white),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: height*0.22,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage('${snapshot.data![index].image}')
                                    )
                                ),

                              ),

                              Text('${snapshot.data![index].name}',style: f630,
                                maxLines: 2,
                              ),

                              RichText(
                                text: TextSpan(
                                  text: 'Product price: ',
                                  style: normalText,
                                  children:  <TextSpan>[
                                    TextSpan(text: '${snapshot.data![index].price}', style: days),
                                  ],
                                ),
                              ),
                              SizedBox(height: height*0.01,),
                              RichText(
                                text: TextSpan(
                                  text: 'Daily income: ',
                                  style: normalText,
                                  children:  <TextSpan>[
                                    TextSpan(text: '${snapshot.data![index].productComm}', style: days),

                                  ],
                                ),
                              ),
                              SizedBox(height: height*0.01,),
                              RichText(
                                text: TextSpan(
                                  text: 'Total income: ',
                                  style: normalText,
                                  children:  <TextSpan>[
                                    TextSpan(text: '${snapshot.data![index].total_income}', style: days),

                                  ],
                                ),
                              ),
                              SizedBox(height: height*0.01,),
                              RichText(
                                text: TextSpan(
                                  text: 'Complete Cycle: ',
                                  style: normalText,
                                  children:  <TextSpan>[
                                    TextSpan(text: '${snapshot.data![index].productValidity}', style: days),

                                  ],
                                ),
                              ),
                              const Spacer(),
                              snapshot.data![index].Purchasestatus==null?
                              constantbutton(onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>Product_view(view:snapshot.data![index])));
                              }, text: 'Join Project',)
                                  :disablebutton(onTap: () {  }, text: 'Joined',)
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            }
          }),


    );



  }

  Future<List<ProductAdaniController>> qwe()  async {

    final prefs = await SharedPreferences.getInstance();
    final userid = prefs.getString("userId");
    final response = await http
        .get(Uri.parse('${ApiConst.ambaniProductThree}$userid'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body)['data'] as List<dynamic>;
      return jsonData.map((item) => ProductAdaniController.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}
