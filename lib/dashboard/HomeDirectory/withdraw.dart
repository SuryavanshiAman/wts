// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:wts/Widgets/circularProgressButton.dart';
import 'package:wts/Widgets/rectanglebutton.dart';
import 'package:wts/buttonconstant/buttonConstant';
import 'package:wts/constant/apiConstant.dart';
import 'package:wts/constant/flushbar.dart';
import 'package:wts/dashboard/HomeDirectory/withdrawlrecord.dart';
import 'package:flutter/material.dart';
import 'package:wts/constant/constantColor.dart';
import 'package:wts/constant/textStyleConstant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:wts/dashboard/MineDirectory/Bindbankaccount.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:wts/generated/assets.dart';
import 'package:wts/main.dart';

class WithdrawPage extends StatefulWidget {
  const WithdrawPage({Key? key}) : super(key: key);

  @override
  State<WithdrawPage> createState() => _WithdrawPageState();
}

class _WithdrawPageState extends State<WithdrawPage> {
  TextEditingController amount = TextEditingController();
  TextEditingController password = TextEditingController();
  int _selectedItemIndex = 10; // Initialize with a value that won't match any index
  bool _isButtonEnabled = false;
  String type = "1";
  List<int> usdAmount = [10, 500, 1000,1500, 2000, 5000, 50000];
  List<int> indianAmount = [300, 500, 1000, 2000, 5000, 10000, 49999];
  void _handleTextChange() {
    setState(() {
      _selectedItemIndex = 10; // Reset selected index
      _isButtonEnabled = amount.text.isNotEmpty;
    });
  }

  void _handleListItemSelected(int index) {
    setState(() {
      _selectedItemIndex = type == "2" ? usdAmount[index] : indianAmount[index];
      amount.text =type == "2"
          ? usdAmount[index].toString()
          : indianAmount[index].toString();  // Update TextFormField text
      _isButtonEnabled = true;
    });
  }
  TextEditingController Bank_Name = TextEditingController();
  TextEditingController UPI = TextEditingController();
  TextEditingController Ac_holder = TextEditingController();
  @override
  void initState() {
    accountview();
    Acdetail();
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
      setState(() {
        userData = data['data'];
      });
    }
  }
  bool _passwordVisible = false;
  var Account;
  var walletview;
  accountview() async {
    print("😂😂😂");
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
    print("🙈🙈🙈");
    print(data);
    if (data['status'] == '200') {
      setState(()  {
        Account = data['data'];
        walletview = data['wallet'];
        Acdetail();
      });
    }
  }
  Acdetail() {

    Bank_Name.text = Account == null ? '' : Account['bankname'].toString();
    UPI.text = Account == null ? '' : Account['upiid'].toString();
    Ac_holder.text = Account == null ? '' : Account['name'].toString();
  }
  @override
  void dispose() {
    amount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
     
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0)),
                gradient: LinearGradient(
                    colors: [lightBlue, white],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter))),
        automaticallyImplyLeading: false,
        leading: const CustomBackButton(),
        centerTitle: true,
        title: Text(
          'WITHDRAWL',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w900, color: black),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const withdrawlrecord()));
              },
              child: Text('History',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      color: black)))
        ],
      ),
      body: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          children: [
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
            Card(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6))),
              elevation: 5,
              child: ExpansionTile(
                title: Text(
                  'Your Account Details',
                  style: TextStyle(
                      color: black,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w900),
                ),
                children: [
                  Account == null
                      ? Column(
                    children: [
                      ListTile(
                          onTap: () async {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const Account_details()));
                          },
                          leading: Text(
                            'Add your Account Detail',
                            style: TextStyle(
                                color: black,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w900),
                          ),
                          trailing: const Icon(Icons.edit)),
                    ],
                  )
                      : Column(
                    children: [
                      ListTile(
                        leading: Text(
                          'Ac holder Name',
                          style: TextStyle(
                              color: black,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w900),
                        ),
                        trailing: Text(
                          Account['name'] == null
                              ? ''
                              : Account['name'].toString(),
                          style: TextStyle(
                              color: black,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                      ListTile(
                        leading: Text(
                          'Acount No',
                          style: TextStyle(
                              color: black,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w900),
                        ),
                        trailing: Text(
                          Account['account_no'] == null
                              ? ''
                              : Account['account_no'].toString(),
                          style: TextStyle(
                              color: black,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                      ListTile(
                        leading: Text(
                          'Bank Name',
                          style: TextStyle(
                              color: black,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w900),
                        ),
                        trailing: Text(
                          Account['bank_name'] == null
                              ? ''
                              : Account['bank_name'].toString(),
                          style: TextStyle(
                              color: black,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                      ListTile(
                        leading: Text(
                          'Branch Name',
                          style: TextStyle(
                              color: black,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w900),
                        ),
                        trailing: Text(
                          Account['branch'] == null
                              ? ''
                              : Account['branch'].toString(),
                          style: TextStyle(
                              color: black,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                      ListTile(
                        leading: Text(
                          'IFSC Code',
                          style: TextStyle(
                              color: black,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w900),
                        ),
                        trailing: Text(
                          Account['ifsc'] == null
                              ? ''
                              : Account['ifsc'].toString(),
                          style: TextStyle(
                              color: black,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                      const Divider(
                        thickness: 2,
                        color: black,
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  'BALANCE : ',
                  style: f630,
                ),
                Text(
                  userData == null ?"0.0":
                  double.parse(userData['wallet']).toStringAsFixed(2) ,
                  style: text,
                ),
                Container(
                  height: 15,
                  width: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: lightBlue,
                  ),
                  child: const Center(
                      child: Text(
                    'ALL',
                    style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold),
                  )),
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Card(
              elevation: 3,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(18))),
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                    color: white,
                    border: Border.all(color: lightBlue),
                    borderRadius: BorderRadius.circular(15)
                ),
                child: Column(
                  children: [
                    GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 130,
                            childAspectRatio: 3.5 / 1.5,
                            mainAxisSpacing: 5),
                        itemCount: type == "2"
                            ? usdAmount.length
                            : indianAmount.length,
                        itemBuilder: (BuildContext ctx, index) {
                          return GestureDetector(
                            onTap: () {
                              _handleListItemSelected(index);
                            },
                            child: Stack(
                              children: [
                                Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                      side: const BorderSide(color: lightBlue),
                                      borderRadius: BorderRadius.circular(12)
                                  ),
                                  color: _selectedItemIndex ==
                                      indianAmount[index] ||
                                      _selectedItemIndex ==
                                          usdAmount[index]
                                      ? lightBlue
                                      : white,
                                  child: Center(
                                    child: Text(
                                      type == "2"
                                          ? '\$ ${usdAmount[index]}'
                                          : '₹  ${indianAmount[index]}',
                                      style: TextStyle(
                                          color: black,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w900),
                                    ),
                                  ),
                                ),
                                Positioned(
                                    top: 5,
                                    right: 5,
                                    child: _selectedItemIndex ==
                                        indianAmount[index] ||
                                        _selectedItemIndex ==
                                            usdAmount[index]
                                        ? Container(
                                      height: 12.r,
                                      width: 12.r,
                                      child: const CircleAvatar(
                                        child: Icon(
                                          Icons.check_outlined,
                                          size: 10,
                                        ),
                                      ),
                                    )
                                        : Container()),
                              ],
                            ),
                          );
                        }),
                    const SizedBox(
                      height: 16,
                    ),
                    Card(
                      elevation: 5,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      child: TextField(
                        controller: amount,
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: black),
                        onChanged: (text) {
                          _handleTextChange();
                        },
                        decoration: InputDecoration(
                            prefixIcon: SizedBox(
                              width: 70,
                              child: Row(
                                children: [
                                  const SizedBox(width: 10),
                                  const Icon(
                                    Icons.currency_rupee,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(width: 10),
                                  Container(
                                      height: 30,
                                      color: Colors.grey,
                                      width: 2)
                                ],
                              ),
                            ),
                            hintText: "Enter Withdraw Amount",
                            helperStyle:
                            TextStyle(fontSize: 10, color: Colors.grey.shade200),
                            border:  OutlineInputBorder(
                              borderSide: const BorderSide(color: lightBlue),
                              borderRadius: BorderRadius.circular(25),
                            )),
                        cursorColor: Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Card(
                      elevation: 5,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      child: TextField(
                        controller: password,
                        textAlign: TextAlign.start,
                        obscureText: !_passwordVisible,
                        keyboardType: TextInputType.visiblePassword,
                        style: const TextStyle(color: black),
                        decoration: InputDecoration(
                            prefixIcon: SizedBox(
                              width: 70,
                              child: Row(
                                children: [
                                  const SizedBox(width: 10),
                                  const Icon(
                                    Icons.password,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(width: 10),
                                  Container(
                                      height: 30,
                                      color: Colors.grey,
                                      width: 2)
                                ],
                              ),

                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                // Based on passwordVisible state choose the icon
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                // Update the state i.e. toogle the state of passwordVisible variable
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                            ),
                            hintText: "Enter Password",
                            helperStyle:
                            TextStyle(fontSize: 10, color: Colors.grey.shade200),
                            border:  OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(25),
                            )),
                        cursorColor: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(
              height: 30,
            ),
            loading==false
                ? CustomButton(
                    onTap: () {
                     if(amount.text.isEmpty){
                        Utils.flushBarErrorMessage("Enter Amount", context, white);
                      }else if(password.text.isEmpty){
                        Utils.flushBarErrorMessage("Enter Password ", context, white);
                      }else if(Account==null){
                       Utils.flushBarErrorMessage("Please enter your account details ", context, white);
                     }else{
                        withdrawl(amount.text, password.text);
                        // Addaccount(Ac_holder.text, UPI.text, Bank_Name.text);
                      }

                    },
                    text: 'WITHDRAL REQUEST')
                : const CircularButton(),
            Padding(
              padding:  const EdgeInsets.all(8.0),

              child:Account==null?Container(): HtmlWidget(
                  Account['withdraw_terms'].toString()

              ),
            ),
          ]),
    ));
  }
  bool loading = false;

  withdrawl(String amount, String password) async {
    print("withdrawlhogya");
    final prefs = await SharedPreferences.getInstance();
    final userid = prefs.getString("userId");
    // final prefs2 = await SharedPreferences.getInstance();
    // final acId = prefs2.getString("acId");
    print(Account['id']);
    print('yyyyy');
    setState(() {
      loading = true;
    });
    final response = await http.post(
      Uri.parse(ApiConst.withdralRequest),
      // headers: <String, String>{
      //   "Content-Type": "application/json; charset=UTF-8",
      // },
      body: jsonEncode(<String, String>{
        "userid": '$userid',
        "amount": amount,
        "password": password,
        "account_id":Account['id'],
      }),
    );
    var data = jsonDecode(response.body);
    print(data);
    print('abhi');
    if (data["status"] == '200') {
      setState(() {
        loading = false;
      });
      Utils.SuccessPopup(context);

      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => bottom()));
    } else {
      setState(() {
        loading = false;
      });
      Utils.flushBarErrorMessage(data["msg"], context, white);
    }
  }


}
