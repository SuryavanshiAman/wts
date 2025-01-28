import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wts/constant/constantColor.dart';
import 'package:wts/main.dart';
import 'package:wts/model/get_salary_model.dart';
import 'package:http/http.dart' as http;

import '../../constant/apiConstant.dart';

class TotalSalaryPage extends StatefulWidget {
  @override
  State<TotalSalaryPage> createState() => _TotalSalaryPageState();
}

class _TotalSalaryPageState extends State<TotalSalaryPage> {
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
    return salary.isNotEmpty?  ListView.builder(
      shrinkWrap: true,
        itemCount: salary.length,
        itemBuilder: (context, index) {
          final item = salary[index];
          return
            Container(
            padding: EdgeInsets.all(5),
              // margin: EdgeInsets.only(top: height*0.25),
            decoration: BoxDecoration(
              // color: Colors.red
              // border: Border(bottom: BorderSide(color: gray))
            ),
            child:
            ListTile(
              title: Text(
                "Salary",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text("Date: ${item.datetime}",),
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
  var totaSalary;

  // Future<void> validUserData() async {
  //   DateTime now = DateTime.now();
  //   String formattedDate = DateFormat('yyyy-MM-dd').format(now);
  //   final response = await http.get(Uri.parse("https://trade.sbmpro.live/Api/get_salary_history?userid=2248&date=2024-12-31"));
  //   final data = json.decode(response.body);
  //   if (data['status'] == "200") {
  //     print("😊😊😊😊:$data");
  //     final List<dynamic> responseData = json.decode(response.body)['data'];
  //     setState(() {
  //       salary = responseData.map((item) => GetSalaryModel.fromJson(item)).toList();
  //     });
  //   } else if (response.statusCode == 400) {
  //     setState(() {
  //       salary = [];
  //     });
  //     throw Exception('Failed to load data');
  //   }
  // }
  Future<void> validUserData() async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);

    final response = await http.get(Uri.parse(
        "${ApiConst.getSalary}${userData['id']}&date="));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      // Check if the status is 200 and parse the data
      if (data['status'] == "200") {
        final List<dynamic> responseData = data['data'];
        setState(() {
          totaSalary=data['total_salary'];
          salary = responseData.map((item) => SalaryData.fromJson(item)).toList();
          print("salary:😊😊😊$salary");
        });
      } else {
        // Handle if status is not 200, e.g., no data or error message
        setState(() {
          salary = [];
        });
        print('Error: ${data['msg']}');
      }
    } else {
      // If status code is not 200, handle the error
      setState(() {
        salary = [];
      });
      print('Failed to load data');
    }
  }
}

