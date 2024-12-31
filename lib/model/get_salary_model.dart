// class GetSalaryModel {
//   String? status;
//   String? msg;
//   String? totalSalary;
//   String? todaySalary;
//   List<Data>? data;
//
//   GetSalaryModel(
//       {this.status, this.msg, this.totalSalary, this.todaySalary, this.data});
//
//   GetSalaryModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     msg = json['msg'];
//     totalSalary = json['total_salary'];
//     todaySalary = json['today_salary'];
//     // if (json['data'] != null) {
//     //   data = <Data>[];
//     //   json['data'].forEach((v) {
//     //     data!.add(Data.fromJson(v));
//     //   });
//     // }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['status'] = status;
//     data['msg'] = msg;
//     data['total_salary'] = totalSalary;
//     data['today_salary'] = todaySalary;
//     data['data']=data;
//     // if (this.data != null) {
//     //   data['data'] = this.data!.map((v) => v.toJson()).toList();
//     // }
//     return data;
//   }
// }
//
// class Data {
//   String? id;
//   String? userid;
//   String? level;
//   String? amount;
//   String? status;
//   String? datetime;
//
//   Data(
//       {this.id,
//         this.userid,
//         this.level,
//         this.amount,
//         this.status,
//         this.datetime});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userid = json['userid'];
//     level = json['level'];
//     amount = json['amount'];
//     status = json['status'];
//     datetime = json['datetime'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['userid'] = userid;
//     data['level'] = level;
//     data['amount'] = amount;
//     data['status'] = status;
//     data['datetime'] = datetime;
//     return data;
//   }
// }
import 'dart:convert';

// class GetSalaryModel {
//   String? status;
//   String? msg;
//   String? totalSalary;
//   String? todaySalary;
//   List<SalaryData>? data;
//
//   GetSalaryModel({
//     this.status,
//     this.msg,
//     this.totalSalary,
//     this.todaySalary,
//     this.data,
//   });
//
//   // Factory method to create a SalaryModel from JSON
//   factory GetSalaryModel.fromJson(Map<String, dynamic> json) {
//     return GetSalaryModel(
//       status: json['status'],
//       msg: json['msg'],
//       totalSalary: json['total_salary'],
//       todaySalary: json['today_salary'],
//       data: json['data'] != null
//           ? List<SalaryData>.from(
//         json['data'].map((x) => SalaryData.fromJson(x)),
//       )
//           : null,
//     );
//   }
//
//   // Method to convert SalaryModel to JSON
//   Map<String, dynamic> toJson() {
//     return {
//       'status': status,
//       'msg': msg,
//       'total_salary': totalSalary,
//       'today_salary': todaySalary,
//       'data': data != null ? List<dynamic>.from(data!.map((x) => x.toJson())) : null,
//     };
//   }
// }

class SalaryData {
  String? id;
  String? userId;
  String? level;
  String? amount;
  String? status;
  String? datetime;

  SalaryData({
    this.id,
    this.userId,
    this.level,
    this.amount,
    this.status,
    this.datetime,
  });

  // Factory method to create a SalaryData from JSON
  factory SalaryData.fromJson(Map<String, dynamic> json) {
    return SalaryData(
      id: json['id'],
      userId: json['userid'],
      level: json['level'],
      amount: json['amount'],
      status: json['status'],
      datetime: json['datetime'],
    );
  }

  // Method to convert SalaryData to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userid': userId,
      'level': level,
      'amount': amount,
      'status': status,
      'datetime': datetime,
    };
  }
}
