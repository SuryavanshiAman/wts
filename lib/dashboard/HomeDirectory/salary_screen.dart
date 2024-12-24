import 'package:flutter/material.dart';
import 'package:wts/buttonconstant/buttonConstant';
import 'package:wts/constant/constantColor.dart';
import 'package:wts/dashboard/HomeDirectory/today_salary.dart';
import 'package:wts/dashboard/HomeDirectory/total_salary.dart';
import 'package:wts/main.dart';

class SalaryScreen extends StatefulWidget {
  const SalaryScreen({super.key});

  @override
  State<SalaryScreen> createState() => _SalaryScreenState();
}

class _SalaryScreenState extends State<SalaryScreen> {
  int selectedIndex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar:    AppBar(
            elevation: 0,
            leading: const CustomBackButton(),
            backgroundColor: Colors.white,
            // toolbarHeight: height*0.1,
            flexibleSpace: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0)),
                    gradient: LinearGradient(
                        colors: [lightBlue, white,],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter))),
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Text('Salary',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 20,
                color: black,
              ), )
        ),
      body: ListView(
        children: [
          SizedBox(
            height: height*0.07,
            child: Row(
              children: [
                GestureDetector(
                  onTap:(){
                    setState(() {
                      selectedIndex=0;
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: height*0.07,
                    width: width*0.5,
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color:selectedIndex==0? Colors.black:lightBlue,width: 3)),
                        color: selectedIndex==0?bgColor:lightBlue,
                        borderRadius: const BorderRadius.only(
                          // topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        )

                    ),
                    child: Column(
                      children: [
                        const Text("Total Salary",style:TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          color: white
                        ),),
                        Text("₹0.0",style:TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: white
                        ),),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                    onTap:(){
                      setState(() {
                        selectedIndex=1;
                      });},
                    child: Container(
                        alignment: Alignment.center,
                        height: height*0.07,
                        width: width*0.5,
                        decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color:selectedIndex==1? Colors.black:lightBlue,width: 3)),
                            color: selectedIndex==1?bgColor:lightBlue,
                            borderRadius: const BorderRadius.only(
                              // topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            )
                        ),
                        child: Column(
                          children: [
                            const Text("Today Salary",style:TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: white
                            )),
                            Text("₹0.0",style:TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: white
                            ),),
                          ],
                        ))),
              ],
            ),
          ),

          selectedIndex==0?  TotalSalaryPage(): TodaySalaryPage(),
        ],
      ),
    );
  }
}
