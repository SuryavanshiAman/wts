import 'dart:convert';

import 'package:wts/Widgets/circularProgressButton.dart';
import 'package:wts/Widgets/rectanglebutton.dart';
import 'package:wts/buttonconstant/buttonConstant';
import 'package:wts/constant/apiConstant.dart';
import 'package:wts/constant/assetsConstant.dart';
import 'package:wts/constant/constantColor.dart';
import 'package:wts/constant/flushbar.dart';
import 'package:wts/constant/textStyleConstant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:wts/generated/assets.dart';
import 'package:wts/main.dart';

class Account_details extends StatefulWidget {
  const Account_details({Key? key}) : super(key: key);

  @override
  State<Account_details> createState() => _Account_detailsState();
}

bool _loading = false;

class _Account_detailsState extends State<Account_details> {
  TextEditingController account_no = TextEditingController();
  TextEditingController IFSC = TextEditingController();
  TextEditingController Branch = TextEditingController();
  TextEditingController Bank_Name = TextEditingController();
  TextEditingController UPI = TextEditingController();
  TextEditingController Ac_holder = TextEditingController();
  TextEditingController walletAdd = TextEditingController();
  String type = "1";
  @override
  void initState() {
    accountview();
    Acdetail();
    super.initState();
  }

  Acdetail() {
    account_no.text = Account == null ? '' : Account['account_no'].toString();
    IFSC.text = Account == null ? '' : Account['ifsc'].toString();
    Branch.text = Account == null ? '' : Account['branch'].toString();
    Bank_Name.text = Account == null ? '' : Account['bank_name'].toString();
    UPI.text = Account == null ? '' : Account['upi'].toString();
    Ac_holder.text = Account == null ? '' : Account['name'].toString();
    walletAdd.text = Account == null ? '' : Account['usdt_address'].toString();
  }

  var Account;
  accountview() async {
    final prefs = await SharedPreferences.getInstance();
    final userid = prefs.getString("userId");
    print(userid);
    final response = await http.post(
      Uri.parse(ApiConst.accountView),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "userid": '$userid',
      }),
    );
    var data = jsonDecode(response.body);
    if (data['status'] == '200') {
      setState(()  async{
        Account = data['data'];
        print(Account);
        print("😋😋😋😋");
        Acdetail();
        final prefs2 = await SharedPreferences.getInstance();
        final key1 = 'acId';
        final acId = Account['id'];
        prefs2.setString(key1, acId);
      });
    }
  }

  bool _isValidIFSC = false;

  void validateIFSC(String ifsc) {
    // Regular expression for IFSC code validation
    RegExp ifscRegex = RegExp(r'^[A-Z]{4}0[A-Z0-9]{6}$');

    setState(() {
      _isValidIFSC = ifscRegex.hasMatch(ifsc.toUpperCase());
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
     
      appBar: AppBar(
       elevation: 0,
        backgroundColor: white,
        flexibleSpace: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(00),
                    bottomRight: Radius.circular(00)),
                gradient: LinearGradient(
                    colors: [lightBlue, white],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter))),
        automaticallyImplyLeading: false,
        leading: const CustomBackButton(),
        centerTitle: true,
        title:  Text('BANK DETAILS',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 20.sp,
            color: black,
          ), ),
      ),
      body: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.all(20.r),
        children: [
          // SizedBox(
          //   height: 50.h,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Card(
                elevation: 3,
                shape: const RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.all(Radius.circular(18))),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      type = "1";
                    });
                  },
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    height: height * 0.1,
                    width: width * 0.3,
                    decoration: BoxDecoration(
                      // color: white,
                        gradient: type=="1"? const LinearGradient(
                            colors: [lightBlue, bgColor,],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight):const LinearGradient(
                            colors: [white, white,],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                        image: const DecorationImage(image: AssetImage(Assets.imagesUpi)),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: bgColor)),
                    // child: const Text(
                    //   "INR",
                    //   style: TextStyle(
                    //       color: textGray,
                    //       fontWeight: FontWeight.w600,
                    //       fontSize: 18),
                    // ),
                  ),
                ),
              ),
              // SizedBox(
              //   width: width * 0.1,
              // ),
              Card(
                elevation: 3,
                shape: const RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.all(Radius.circular(18))),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      type = "2";
                    });
                  },
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    height: height * 0.1,
                    width: width * 0.3,
                    decoration: BoxDecoration(
                      // color: white,
                        gradient: type=="2"? const LinearGradient(
                            colors: [lightBlue, bgColor,],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight):const LinearGradient(
                            colors: [white, white,],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: bgColor),
                        image: const DecorationImage(image: AssetImage(Assets.imagesUsdt,))
                    ),

                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: (){
                  setState(() {
                    type="1";
                  });
                },
                child: const Text(
                  "INR",
                  style: TextStyle(
                      color: bgColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                ),
              ),
              InkWell(
                onTap: (){
                  setState(() {
                    type="2";
                  });
                },
                child: const Text(
                  "USDT",
                  style: TextStyle(
                      color: bgColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                ),
              ),
            ],
          ),
          SizedBox(height: 15,),
          Card(
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: lightBlue),
                borderRadius: BorderRadius.circular(15.r)),
            elevation: 5,
            child:type=="1"? ListView(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 15.r, vertical: 15.r),
              children: [
                TextField(
                  controller: Ac_holder,
                  // focusNode: focusyear,
                  keyboardType: TextInputType.name,
                  textAlignVertical: TextAlignVertical.bottom,
                  style: const TextStyle(color: black),
                  cursorColor: const Color(0xFF075E54),
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      counter: Offstage(),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.black),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                        ),
                      ),
                      hintText: "Enter A/c holder name",
                    hintStyle: TextStyle(
                      color: black,
                      fontSize: 15,
                    ),),
                ),
                SizedBox(
                  height: 20.h,
                ),
                TextField(
                  controller: account_no,
                  // focusNode: focusyear,
                  keyboardType: TextInputType.number,
                  textAlignVertical: TextAlignVertical.bottom,
                  style: const TextStyle(color: black),
                  cursorColor: const Color(0xFF075E54),
                  decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.black),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.account_balance,
                      color: black,
                    ),
                    hintText: "Account NO",
                    hintStyle: TextStyle(
                      color: black,
                      fontSize: 15,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                TextField(
                  controller: Bank_Name,
                  // focusNode: focusyear,
                  keyboardType: TextInputType.name,
                  textAlignVertical: TextAlignVertical.bottom,
                  style: const TextStyle(color: black),
                  cursorColor: const Color(0xFF075E54),
                  decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.black),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.account_balance_outlined,
                      color: black,
                    ),
                    hintText: "Bank Name",
                    hintStyle: TextStyle(
                      color: black,
                      fontSize: 15,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                TextField(
                  controller: Branch,
                  // focusNode: focusyear,
                  keyboardType: TextInputType.name,
                  textAlignVertical: TextAlignVertical.bottom,
                  style: const TextStyle(color: black),
                  cursorColor: const Color(0xFF075E54),
                  decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.black),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.account_balance_sharp,
                      color: Colors.black,
                    ),
                    hintText: "Branch Name",
                    hintStyle: TextStyle(
                      color: black,
                      fontSize: 15,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                TextField(
                  controller: IFSC,
                  // focusNode: focusyear,
                  onChanged: (value) {
                    validateIFSC(value.toUpperCase());
                  },
                  maxLength: 11,
                  keyboardType: TextInputType.name,
                  textAlignVertical: TextAlignVertical.bottom,
                  style: const TextStyle(color: black),
                  cursorColor: const Color(0xFF075E54),
                  decoration: const InputDecoration(
                    counter: Offstage(),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.black),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.pin,
                      color: black,
                    ),
                    hintText: "IFSC Code",
                    hintStyle: TextStyle(
                      color: black,
                      fontSize: 15,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: [
                //     Container(
                //       height: 2,
                //       width: 130.w,
                //       color: black,
                //     ),
                //     Text(
                //       'OR',
                //       style:
                //       TextStyle(
                //           fontWeight: FontWeight.w900,
                //           fontSize: 14.sp,
                //           color: black
                //       ),
                //     ),
                //     Container(
                //       height: 2,
                //       width: 130.w,
                //       color: black,
                //     ),
                //   ],
                // ),
                // SizedBox(
                //   height: 20.h,
                // ),
                // TextField(
                //   controller: UPI,
                //   // focusNode: focusyear,
                //   keyboardType: TextInputType.name,
                //   textAlignVertical: TextAlignVertical.bottom,
                //   style: const TextStyle(color: black),
                //   cursorColor: const Color(0xFF075E54),
                //   decoration: InputDecoration(
                //     focusedBorder: UnderlineInputBorder(
                //       borderSide: BorderSide(
                //           width: 1, color: Colors.black),
                //     ),
                //     enabledBorder: UnderlineInputBorder(
                //       borderSide: BorderSide(
                //         width: 1,
                //       ),),
                //     prefixIcon: Icon(
                //       Icons.pin_end,
                //       color: black,
                //     ),
                //     hintText: "UPI ID",
                //     hintStyle: TextStyle(
                //       color: black,
                //       fontSize: 15,
                //     ),
                //   ),
                // ),
                SizedBox(
                  height: 20.h,
                ),
                _loading == false
                    ? CustomButton(
                        text: 'UPDATE',
                        textColor: Colors.white,
                        onTap: () async {
                          // bool ifscValid = validateIFSC(IFSC.text);

                          if (_isValidIFSC) {
                            // If IFSC is valid, proceed with adding the account
                            Addaccount(account_no.text, IFSC.text, Branch.text,
                                Bank_Name.text, Ac_holder.text);
                          } else {
                            Utils.flushBarErrorMessage(
                                "Please enter valid ifsc", context, white);
                          }
                          print(IFSC.text);
                          // Addaccount(account_no.text, IFSC.text, Branch.text,
                          //     Bank_Name.text, Ac_holder.text);
                        },
                      )
                    : const CircularButton()
              ],
            ):
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.r, vertical: 15.r),
              child: Column(
                children: [
                  TextField(
                    controller: walletAdd,
                    textAlignVertical: TextAlignVertical.bottom,
                    style: const TextStyle(color: black),
                    cursorColor: const Color(0xFF075E54),
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.wallet),
                      counter: Offstage(),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.black),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                        ),
                      ),
                      hintText: "Enter TRC20 wallet address",
                      hintStyle: TextStyle(
                        color: black,
                        fontSize: 15,
                      ),),
                  ),
                  SizedBox(height: 10,),
                  _loading == false
                      ? CustomButton(
                    text: 'UPDATE',
                    textColor: Colors.white,
                    onTap: () async {
                      if (walletAdd.text.isNotEmpty) {
                        walletAddress(walletAdd.text);
                      } else {
                        Utils.flushBarErrorMessage(
                            "Please enter wallet address", context, white);
                      }
                    },
                  )
                      : const CircularButton()
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }

  Addaccount(String account_no, String IFSC, String Branch, String Bank_Name,
      String Ac_holder) async {
    final prefs = await SharedPreferences.getInstance();
    final userid = prefs.getString("userId");
    setState(() {
      _loading = true;
    });

    final response = await http.post(
      Uri.parse(ApiConst.addAccount),
      // headers: <String, String>{
      //   'Content-Type': 'application/json; charset=UTF-8',
      // },
      body: jsonEncode(<String, String>{
        "name": Ac_holder,
        "accountno": account_no,
        "ifsc": IFSC,
        "bankname": Bank_Name,
        "branch": Branch,
        "userid": '${userid}',
        "type":type,
      }),
    );

    var data = jsonDecode(response.body);

    if (data["status"] == "200") {
      final prefs2 = await SharedPreferences.getInstance();
      final key1 = 'acId';
      final acId = data['id'].toString();
      prefs2.setString(key1, acId);
      setState(() {
        _loading = false;
      });
      Navigator.pop(context);
      Utils.flushBarSuccessMessage(data['msg'], context, black);
    } else {
      setState(() {
        _loading = false;
      });
      Utils.flushBarErrorMessage(data['msg'], context, black);
      print("Error");
    }
  }
  walletAddress(String walletAdd ) async {
    final prefs = await SharedPreferences.getInstance();
    final userid = prefs.getString("userId");
    setState(() {
      _loading = true;
    });

    final response = await http.post(
      Uri.parse(ApiConst.usdt),
      body: jsonEncode(<String, String>{
        "usdt_address": walletAdd,
        "userid": '${userid}',
        "type":type,
      }),
    );

    var data = jsonDecode(response.body);

    if (data["status"] == "200") {
      // final prefs2 = await SharedPreferences.getInstance();
      // final key1 = 'acId';
      // final acId = data['id'].toString();
      // prefs2.setString(key1, acId);
      setState(() {
        _loading = false;
      });
      Navigator.pop(context);
      Utils.flushBarSuccessMessage(data['msg'], context, black);
    } else {
      setState(() {
        _loading = false;
      });
      Utils.flushBarErrorMessage(data['msg'], context, black);
      print("Error");
    }
  }
}
