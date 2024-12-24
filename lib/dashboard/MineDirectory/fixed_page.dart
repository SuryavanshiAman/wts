import 'dart:convert';
import 'package:wts/constant/apiConstant.dart';
import 'package:wts/constant/assetsConstant.dart';
import 'package:wts/constant/constantColor.dart';
import 'package:wts/constant/disableButton.dart';
import 'package:wts/constant/flushbar.dart';
import 'package:wts/constant/textStyleConstant.dart';
import 'package:wts/dashboard/MineDirectory/myprojectview.dart';
import 'package:wts/product/ProductController/MYPROJECTCONTROLLER.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wts/product/ProductController/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class FixedPage extends StatefulWidget {
  const FixedPage({Key? key}) : super(key: key);

  @override
  State<FixedPage> createState() => _FixedPageState();
}

class _FixedPageState extends State<FixedPage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return   Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder<List<ProductModel>>(
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
                      width: width*0.7,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(noData),
                          )
                      ),
                    ),
                    Text(
                      "No data available",
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
                      child: InkWell(
                        onTap: (){
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>myprojectview(view:snapshot.data![index])));
                        },
                        child: Container(


                          decoration: const BoxDecoration( borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: white),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: height*0.20,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(snapshot.data![index].image)
                                      )
                                  ),

                                ),

                                Text(snapshot.data![index].name,style: f630,
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
                                // SizedBox(height: height*0.01,),
                                // RichText(
                                //   text: TextSpan(
                                //     text: 'Daily income: ',
                                //     style: normalText,
                                //     children:  <TextSpan>[
                                //       TextSpan(text: '${snapshot.data![index].productComm}', style: days),
                                //
                                //     ],
                                //   ),
                                // ),
                                SizedBox(height: height*0.01,),
                                RichText(
                                  text: TextSpan(
                                    text: 'Total income: ',
                                    style: normalText,
                                    children:  <TextSpan>[
                                      TextSpan(text: '${snapshot.data![index].totalIncome}', style: days),

                                    ],
                                  ),
                                ),
                                SizedBox(height: height*0.01,),
                                RichText(
                                  text: TextSpan(
                                    text: 'Purchase Date: ',
                                    style: normalText,
                                    children:  <TextSpan>[
                                      TextSpan(text: snapshot.data![index].purchaseDate, style: days),

                                    ],
                                  ),
                                ),
                                SizedBox(height: height*0.01,),
                                RichText(
                                  text:  TextSpan(
                                    text: 'Days Left: ',
                                    style: normalText,
                                    children:  <TextSpan>[
                                      TextSpan(text: snapshot.data![index].productValidity, style: days),

                                    ],
                                  ),
                                ),
                                const Spacer(),
                                // snapshot.data![index].status=="1"?
                                // constantbutton(onTap: () {
                                //
                                //   Redeem(pid:"${snapshot.data![index].productId}",
                                //       DailyIncom:"${snapshot.data![index].productComm}");
                                // }, text: 'REDEEM',):
                                disablebutton(onTap: () {  }, text: 'Redeemed',)

                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            }
          }),
    );
  }
  bool loading=true;
  Future<List<ProductModel>> qwe()  async {
    final prefs = await SharedPreferences.getInstance();
    final userid = prefs.getString("userId");
    print(userid);
    final response = await http
        .get(Uri.parse('${ApiConst.myFixedProject}$userid'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body)['data'] as List<dynamic>;
      print(jsonData.length);
      print('kkkkkkkkkkkkkkkkkkkkkkkk');
      return jsonData.map((item) => ProductModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }


  Redeem(  {required String pid, required String DailyIncom, })async {
    print("chala");
    print(pid);
    print(DailyIncom);
    print("DailyIncom");
    final prefs = await SharedPreferences.getInstance();
    final userid = prefs.getString("userId");
    setState(() {
      loading=true;
    });
    final response =  await http.post(Uri.parse(ApiConst.redeemProduct),
      // headers:<String ,String>{
      //   "Content-Type":"application/json; charset=UTF-8",
      // },
      body: jsonEncode(<String ,String>{
        "userid": "$userid",
        "productid": pid,
        "dailycomm":DailyIncom,
      }),
    );
    var data = jsonDecode(response.body);
    print(data);
    print('qqqqqqqqqqqqqqqqqq');
    if(data["status"]=='200'){

      setState(() {
        loading=false;
      });
      Utils.SuccessPopup(context);

    }
    else{
      setState(() {
        loading= false;
      });
      Utils.flushBarErrorMessage( data["msg"],context,white);
    }

  }
}
