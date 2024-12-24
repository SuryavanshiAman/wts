import 'dart:convert';

import 'package:wts/Widgets/circularProgressButton.dart';
import 'package:wts/constant/apiConstant.dart';
import 'package:wts/constant/flushbar.dart';
import 'package:wts/dashboard/HomeDirectory/home.dart';
import 'package:wts/dashboard/dashboard.dart';
import 'package:wts/product/ProductController/ProductAdaniController.dart';
import 'package:flutter/material.dart';
import 'package:wts/constant/assetsConstant.dart';
import 'package:wts/constant/constantColor.dart';
import 'package:wts/constant/constantButton.dart';
import 'package:wts/constant/textStyleConstant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:wts/recharge/rechargeAmount.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Product_view extends StatefulWidget {
  final ProductAdaniController view;
  const Product_view({required this.view});

  @override
  State<Product_view> createState() => _Product_viewState();
}

class _Product_viewState extends State<Product_view> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
      //
      appBar: AppBar(
          flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [lightBlue, white],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter))),
          centerTitle: true,
          title: Text('${widget.view.name}')),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            Card(
              elevation: 3,
              child: Container(
                height: height * 0.2,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage('${widget.view.image}')
                    ),

                    color: white),

              ),
            ),
            Card(
              elevation: 3,
              child: Container(
                height: height * 0.10,
                width: width * 0.99,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: white),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Price",
                              style: TextStyle(fontWeight: FontWeight.w900,fontSize: 15),),
                            Text('₹ '+'${widget.view.price}',
                                style: TextStyle(color: lightBlue,fontWeight: FontWeight.w700,fontSize: 13)),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "Daily income",
                              style: TextStyle(fontWeight: FontWeight.w900,fontSize: 15),
                            ),
                            Text('₹ '+'${widget.view.productComm}' ,
                                style: TextStyle(color: lightBlue,fontWeight: FontWeight.w700,fontSize: 13)),
                          ],
                        ),
                        Column(
                          children: [
                            Text("Total earning",
                              style: TextStyle(fontWeight: FontWeight.w900,fontSize: 15),
                            ),
                            Text(
                                '₹ '+ '${widget.view.total_income}',
                              style: TextStyle(color: lightBlue,fontWeight: FontWeight.w700,fontSize: 13),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Project description",
              style: f630,
            ),
            SizedBox(
              height: 20,
            ),
            Card(
              elevation: 3,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: white),
                child: Padding(
                  padding:  EdgeInsets.all(8.0),
                  child: HtmlWidget(
                    '${widget.view.description}',
                  ),
                ),
              ),
            )
          ],
        ),
      ),
          bottomNavigationBar:

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child:loading==false?
            constantbutton(
                onTap: () {
                  Productpurches();

                },
                text: 'GET',
              ):CircularButton(),
          ),

    ));
  }
  bool loading =false;
  Productpurches()async {
    print("Productpurches");
    print("${widget.view.productValidity}");
    final prefs = await SharedPreferences.getInstance();
    final userid = prefs.getString("userId");
    setState(() {
      loading=true;
    });
    final response =  await http.post(Uri.parse(ApiConst.productPurchase),

      // headers:<String ,String>{
      //   "Content-Type":"application/json; charset=UTF-8",
      // },
      body: jsonEncode(<String ,String>{
        'userid':	'$userid',
        'productid':	'${widget.view.id}',
        'purchaseamount':	'${widget.view.price}',
        'purchasexpdays':	'${widget.view.productValidity}',
      }),
    );

    var data = jsonDecode(response.body);
    print(data);
    print('qqqqqqqqqqqqqqqqqq');
    if(data["status"]=='200'){

      setState(() {
        loading=false;
      });

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
      Utils.flushBarSuccessMessage( data["msg"],context,white);
    }
    else{
      setState(() {
        loading= false;
      });
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>RechargeAmount()));
      Utils.flushBarErrorMessage( data["msg"],context,white);
    }

  }
}
