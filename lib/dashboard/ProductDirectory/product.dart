import 'package:wts/dashboard/ProductDirectory/currency.dart';
import 'package:flutter/material.dart';
import 'package:wts/constant/assetsConstant.dart';
import 'package:wts/constant/constantColor.dart';
import 'package:wts/constant/constantButton.dart';
import 'package:wts/constant/textStyleConstant.dart';
import 'package:wts/dashboard/ProductDirectory/equity.dart';
import 'package:wts/dashboard/ProductDirectory/commodity.dart';
import 'package:wts/dashboard/ProductDirectory/product_fixed.dart';

class Product_page extends StatefulWidget {
  const Product_page({Key? key}) : super(key: key);

  @override
  State<Product_page> createState() => _Product_pageState();
}

class _Product_pageState extends State<Product_page>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    TabController _tabContrller = TabController(length: 4, vsync: this);
    return SafeArea(
        child: Scaffold(
      //
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        toolbarHeight: height*0.1,
        flexibleSpace: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(45),
                    bottomRight: Radius.circular(45)),
                gradient: LinearGradient(
                    colors: [lightBlue, white,],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter))),
        // flexibleSpace: Container(
        //     decoration: const BoxDecoration(
        //         borderRadius: BorderRadius.only(
        //             bottomLeft: Radius.circular(5),
        //             bottomRight: Radius.circular(5)),
        //         gradient: LinearGradient(
        //             colors: [lightBlue, bgColor],
        //             begin: Alignment.bottomCenter,
        //             end: Alignment.topCenter))),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Container(
          height: height * 0.03,
          decoration:
              const BoxDecoration(image: DecorationImage(image: AssetImage(Adani))),
        ),
        bottom: TabBar(
          labelStyle: TextStyle(
            // fontSize: 12,
            fontWeight: FontWeight.w600
          ),
            controller: _tabContrller,
            unselectedLabelColor: black,
            labelColor: lightBlue,
            // indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Colors.transparent,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: white,
            ),
            tabs: [
              Container(
                width: width * 0.99,
                child: const Tab(
                 // text: ("AMBANI"),
                  text: ("Equity"),
                ),
              ),
              Container(
                width: width * 0.99,
                child: const Tab(
                  text: ("Commodity"),
                //  text: ("AMBANI-Ⅱ"),
                ),
              ),
              Container(
                // width: width * 12,
                child: const Tab(
                  text: ("Currency"),
                //  text: ("AMBANI-Ⅱ"),
                ),
              ),
              Container(
                // width: width * 12,
                child: const Tab(
                  text: ("FIXED+"),
                //  text: ("AMBANI-Ⅱ"),
                ),
              ),
            ]),
      ),
      body: TabBarView(
        controller: _tabContrller,
        children: [
          const Equity(),
          Commodity(),
          const Currency(),
          TabFour(),
        ],
      ),
    ));
  }
}
