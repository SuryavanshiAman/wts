


import 'dart:convert';

import 'package:http/http.dart'as http;
import 'package:wts/constant/apiConstant.dart';
var Whatasapp;
var telegram;
// var termcondition;
// var aboutus;
// var legality;
// var privacypolicy;
// var howtoplay;
// var withdrawalpolicy;
// var refundpolicy;
class SupportApi{
  static void fetchdata() async{
print("chala");
    final url= Uri.parse(ApiConst.whatsapp);
    final response = await http.get(
      url,
    );
    if (response.statusCode ==200){
      final responseData = json.decode(response.body)['data'];
print(responseData);
      Whatasapp =responseData['number'];
      telegram =responseData['telegram'];

      print(responseData);
      print("😢😢😢😢😢😢");

    }
    else{
      throw Exception("Failed to fetch notification");
    }
  }

  // Future allPolicy() async{
  //
  //   final url= Uri.parse(ApiConst.allPolicy);
  //   final response = await http.get(
  //     url,
  //   );
  //   if (response.statusCode ==200){
  //     print("policy");
  //     final responseData = json.decode(response.body)['data'];
  //     privacypolicy =responseData["privacy_policy"];
  //     termcondition =responseData["termcondition"];
  //     howtoplay =responseData["howtoplay"];
  //     aboutus =responseData["aboutus"];
  //     legality =responseData["legality"];
  //     withdrawalpolicy =responseData["withdrawalpolicy"];
  //     refundpolicy =responseData["refundpolicy"];
  //
  //   }
  //   else{
  //     throw Exception("Failed to fetch notification");
  //   }
  // }
}