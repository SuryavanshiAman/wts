import 'package:flutter/material.dart';
import 'package:wts/constant/constantColor.dart';
import 'package:wts/main.dart';

class TodaySalaryPage extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return  ListView.builder(
      shrinkWrap: true,
      itemCount: 1,
      itemBuilder: (context, index) {
        final item = data[index];
        return Container(
          margin: EdgeInsets.only(top: height*0.25),
          decoration: BoxDecoration(
              // border: Border(bottom: BorderSide(color: gray))
          ),
          child: Center(
            child: Text(
              "No Data Avilable",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: black,
              ),
            ),
          )
          // ListTile(
          //   title: Text(
          //     "Salary",
          //     style: TextStyle(fontWeight: FontWeight.bold),
          //   ),
          //   // subtitle: Text("Date: ${formatDateTime(item['dateTime'])}",),
          //   trailing: Text(
          //     "+₹${item['amount']}",
          //     style: TextStyle(
          //       color: Colors.green,
          //       fontWeight: FontWeight.bold,
          //     ),
          //   ),
          // ),
        );
      },
    );
  }
}

