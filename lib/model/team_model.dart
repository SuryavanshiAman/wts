//
// class TeamModel {
//   final String status;
//   final List<LevelData> data;
//
//   TeamModel({required this.status, required this.data});
//
//   factory TeamModel.fromJson(Map<String, dynamic> json) {
//     return TeamModel(
//       status: json['status'] ?? '', // Handle null for status
//       data: (json['data'])
//           .map((levelJson) => LevelData.fromJson(levelJson))
//           .toList(),
//     );
//   }
// }
//
// class LevelData {
//   final int level;
//   final int count;
//   final int totalPurchase;
//   final List<User> users;
//
//   LevelData({
//     required this.level,
//     required this.count,
//     required this.totalPurchase,
//     required this.users,
//   });
//
//   factory LevelData.fromJson(Map<String, dynamic> json) {
//     return LevelData(
//       level: json['level'] ?? 0, // Provide default value if null
//       count: json['count'] ?? 0,
//       totalPurchase: json['total_purchase'] ?? 0,
//       users: (json['users'] as List)
//           .map((userJson) => User.fromJson(userJson))
//           .toList(),
//     );
//   }
// }
//
// class User {
//   final String id;
//   final String userId;
//   final String datetime;
//   final int level;
//   final int totalPurchase;
//
//   User({
//     required this.id,
//     required this.userId,
//     required this.datetime,
//     required this.level,
//     required this.totalPurchase,
//   });
//
//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       id: json['id'] ?? '', // Handle null for id
//       userId: json['userids'] ?? '', // Handle null for userids
//       datetime: json['datetime'] ?? '', // Handle null for datetime
//       level: json['level'] ?? 0, // Handle null for level
//       totalPurchase: json['total_purchase'] != null
//           ? int.parse(json['total_purchase'].toString())
//           : 0, // Safely parse total_purchase
//     );
//   }
// }


class Data {
  int? level;
  int? count;
  int? totalPurchase;
  List<Users>? users;

  Data({this.level, this.count, this.totalPurchase, this.users});

  Data.fromJson(Map<String, dynamic> json) {
    level = json['level'];
    count = json['count'];
    totalPurchase = json['total_purchase'];
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(Users.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['level'] = level;
    data['count'] = count;
    data['total_purchase'] = totalPurchase;
    if (users != null) {
      data['users'] = users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Users {
  dynamic id;
  dynamic userids;
  dynamic datetime;
  dynamic mobile;
  dynamic level;
  dynamic totalPurchase;

  Users(
      {this.id,
        this.userids,
        this.datetime,
        this.mobile,
        this.level,
        this.totalPurchase});

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userids = json['userids'];
    datetime = json['datetime'];
    mobile = json['mobile'];
    level = json['level'];
    totalPurchase = json['total_purchase'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userids'] = userids;
    data['datetime'] = datetime;
    data['mobile'] = mobile;
    data['level'] = level;
    data['total_purchase'] = totalPurchase;
    return data;
  }
}
