import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wts/constant/apiConstant.dart';
import 'package:wts/constant/constantColor.dart';
import 'package:wts/main.dart';
import 'package:wts/model/get_salary_model.dart';
import 'package:http/http.dart' as http;

class TodaySalaryPage extends StatefulWidget {
  @override
  State<TodaySalaryPage> createState() => _TodaySalaryPageState();
}

class _TodaySalaryPageState extends State<TodaySalaryPage> {
  final List<Map<String, dynamic>> data = [
    {
      'dateTime': DateTime.now(),
      'salary': 50000,
      'amount': 2000,
    },
    {
      'dateTime': DateTime.now().subtract(Duration(days: 1)),
      'salary': 45000,
      'amount': 1500,
    },
    {
      'dateTime': DateTime.now().subtract(Duration(days: 2)),
      'salary': 40000,
      'amount': 1000,
    },
  ];

  String formatDateTime(DateTime dateTime) {
    return "${dateTime.day}/${dateTime.month}/${dateTime.year}";
  }
  @override
  void initState() {
    super.initState();
    viewProfile();
  }
  var userData;
  viewProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final userid = prefs.getString("userId");
    final response = await http.get(
      Uri.parse("${ApiConst.profileView}$userid"),
    );
    final data = jsonDecode(response.body);
    if (data['status'] == "200") {
      print(data);
      setState(() {
        userData = data['data'];

      });
      validUserData();
    }
  }
  @override
  Widget build(BuildContext context) {
    return salary.isNotEmpty? ListView.builder(
      shrinkWrap: true,
      itemCount: salary.length,
      itemBuilder: (context, index) {
        final item = salary[index];
        return Container(
          margin: EdgeInsets.only(top: height*0.25),
          decoration: BoxDecoration(
              // border: Border(bottom: BorderSide(color: gray))
          ),
          child:  ListTile(
            title: Text(
              "Salary",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            // subtitle: Text("Date: ${item.datetime}",),
            trailing: Text(
              "+₹${item.amount}",
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    ):Center(child: Padding(
      padding:  EdgeInsets.only(top: height*0.25),
      child: Text("No Data Available",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w600),),
    ));
  }

  List<SalaryData> salary = [];

  var todaySalary;

  Future<void> validUserData() async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);

    final response = await http.get(Uri.parse(
        "${ApiConst.getSalary}${userData['id']}&date=$formattedDate"));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == "200") {
        final List<dynamic> responseData = data['data'];
        setState(() {
          todaySalary=data["today_salary"];
          salary = responseData.map((item) => SalaryData.fromJson(item)).toList();
          print("salary:😊😊😊$salary");
        });
      } else {
        setState(() {
          salary = [];
        });
        print('Error: ${data['msg']}');
      }
    } else {
      setState(() {
        salary = [];
      });
      print('Failed to load data');
    }
  }
}

