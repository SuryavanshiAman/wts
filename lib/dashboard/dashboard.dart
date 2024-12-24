
// import 'package:chess_app/screen/Dashboard/More.dart';
// import 'package:chess_app/screen/Dashboard/youtube.dart';
// import 'package:chess_app/screen/home/home1.dart';


import 'package:wts/constant/constantColor.dart';
import 'package:wts/dashboard/HomeDirectory/home.dart';
import 'package:wts/dashboard/MineDirectory/accountContainer.dart';
import 'package:wts/dashboard/MineDirectory/mine.dart';
import 'package:wts/dashboard/NewsDirectory/news.dart';
import 'package:wts/dashboard/NewsDirectory/newslistview.dart';
import 'package:wts/dashboard/ProductDirectory/product.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../home/home.dart';


class bottom extends StatefulWidget {
  // final int? index;
  const bottom({Key ?key,}) ;

  @override
  State<bottom> createState() => _bottomState();
}

class _bottomState extends State<bottom> {
  final pages = [
     const Home(),
    const Product_page(),
    const News(),
    const DetailsPage(),
    // First_home_page(),
    // Youtube(),
    // Details(),
  ];

  int pageIndex = 0;
  @override
  void initState() {
    super.initState();
    // pageIndex=widget.index ==null?pageIndex:widget.index!;
    // print(widget.index.toString());
    // print(pageIndex);
    // print("pageIndex");
  }
  Future<bool> _onWillPop() async {
    if (pageIndex > 0) {
      // If not on the first screen, go back one step
      setState(() {
        pageIndex=0;
      });
      return false; // Do not pop the route
    } else {
      // If on the first screen, show a confirmation dialog
      return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape:RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          shadowColor: Colors.black,
          title: Text('Are you sure?', style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.bold,
            color: black,
          ),),
          content: Text('Do you want to exit from App', style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.bold,
            color: black,
          ),),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            TextButton(
              onPressed: () {
                SystemNavigator.pop();
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('No'),
            ),
          ],
        )
      ) ?? false; // Return false if the dialog is dismissed
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: pages[pageIndex],
        bottomNavigationBar:   buildMyNavBar(context),
      ),
    );
  }

  Container buildMyNavBar(BuildContext context) {
    return Container(
      height: 65,
      decoration:  const BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
        gradient: LinearGradient(
            colors: [lightBlue,lightBlue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
        )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  setState(() {
                    pageIndex = 0;
                  });
                },
                icon: pageIndex == 0
                    ? const Icon(
                  Icons.home_filled,
                  color: white,
                  size: 28,
                )
                    : const Icon(
                  Icons.home_outlined,
                  color: black,
                  size: 28,

                ),
              ),
              pageIndex == 0?
              const Text('Home' ,style: TextStyle(fontSize: 14,
                  color: Colors.white,fontWeight: FontWeight.bold
              ),):
              const Text('Home' ,style: TextStyle(fontSize: 14,
                  color: black,fontWeight: FontWeight.bold
              ),),
            ],
          ),
          Column(
            children: [
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  setState(() {
                    pageIndex = 1;
                  });
                },

                icon: pageIndex == 1
                    ? const Icon(
                  Icons.widgets,
                  color: white,
                  size: 28,
                )
                    : const Icon(
                  Icons.widgets_outlined,
                  color: black,
                  size: 28,
                ),
              ),
              pageIndex == 1?
              const Text('Product' ,style: TextStyle(fontSize: 14,
                  color: white,fontWeight: FontWeight.bold
              ),):
              const Text('Product' ,style: TextStyle(fontSize: 14,
                  color: black,fontWeight: FontWeight.bold
              ),),
            ],
          ),
          Column(
            children: [
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  setState(() {
                    pageIndex = 2;
                  });
                },

                icon: pageIndex == 2
                    ? const Icon(
                  Icons.newspaper,
                  color: white,
                  size: 28,
                )
                    : const Icon(
                  Icons.newspaper_outlined,
                  color:black,
                  size: 28,
                ),
              ),
              pageIndex == 2?
              const Text('News' ,style: TextStyle(fontSize: 14,
                  color: white,fontWeight: FontWeight.bold
              ),):
              const Text('News' ,style: TextStyle(fontSize: 14,
                  color: black,fontWeight: FontWeight.bold
              ),),
            ],
          ),

          // Column(
          //   children: [
          //     IconButton(
          //       enableFeedback: false,
          //       onPressed: () {
          //         setState(() {
          //           pageIndex = 3;
          //         });
          //       },
          //       icon: pageIndex == 3
          //           ? const Icon(
          //         Icons.text_snippet,
          //         color: lightred,
          //         size: 20,
          //
          //       )
          //           : const Icon(
          //         Icons.text_snippet_outlined,
          //         color: black,
          //         size: 20,
          //       ),
          //     ),
          //     pageIndex == 3?
          //     Text('Status' ,style: TextStyle(fontSize: 10,
          //         color: lightred,fontWeight: FontWeight.bold
          //     ),):
          //     Text('Status' ,style: TextStyle(fontSize: 10,
          //         color: black,fontWeight: FontWeight.bold
          //     ),),
          //   ],
          // ),
          Column(
            children: [
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  setState(() {
                    pageIndex = 3;
                  });
                },
                icon: pageIndex == 3
                    ? const Icon(
                  Icons.person,
                  color: white,
                  size: 27,

                )
                    : const Icon(
                  Icons.person_outline,
                  color: black,
                  size: 27,
                ),
              ),
              pageIndex == 3?
              const Text('Mine' ,style: TextStyle(fontSize: 14,
                  color: white,fontWeight: FontWeight.bold
              ),):
              const Text('Mine' ,style: TextStyle(fontSize: 14,
                  color: black,fontWeight: FontWeight.bold
              ),),
            ],
          ),
        ],
      ),
    );
  }
}
