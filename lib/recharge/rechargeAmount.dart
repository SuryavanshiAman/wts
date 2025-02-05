import 'dart:convert';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:wts/Widgets/circularProgressButton.dart';
import 'package:wts/Widgets/loginButton.dart';
import 'package:wts/buttonconstant/buttonConstant';
import 'package:wts/constant/apiConstant.dart';
import 'package:wts/constant/clipboard.dart';
import 'package:wts/constant/constantColor.dart';
import 'package:wts/constant/flushbar.dart';
import 'package:wts/constant/textStyleConstant.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upi_india/upi_india.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wts/generated/assets.dart';

import '../dashboard/HomeDirectory/rechargerecord.dart';

class RechargeAmount extends StatefulWidget {
  const RechargeAmount({Key? key}) : super(key: key);

  @override
  State<RechargeAmount> createState() => _RechargeAmountState();
}

class _RechargeAmountState extends State<RechargeAmount> {
  UpiIndia _upiIndia = UpiIndia();
  List<UpiApp>? apps;

  TextStyle header =
      const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: black);

  TextStyle value =
      const TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: black);

  @override
  void initState() {
    _upiIndia.getAllUpiApps(mandatoryTransactionId: false).then((value) {
      setState(() {
        apps = value;
      });
    }).catchError((e) {
      apps = [];
    });
    getQr();
    viewprofile();
    super.initState();
  }

  String type = "1";
  Widget displayUpiApps() {
    return Login_button(
        onTap: () {
          if (amount.text.isEmpty) {
            Utils.flushBarErrorMessage("Enter amount", context, Colors.white);
          } else if (type=="2"&&image==null){
            Utils.flushBarErrorMessage(
                "Please Upload Image", context, Colors.white);
          }
          else if (type=="1") {
            if(int.parse(amount.text) >= int.parse("100")){
              addmony(context, amount.text, map['userids']);
            }else{
              Utils.flushBarErrorMessage(
                  "Minimum Recharge amount is 100", context, Colors.white);
            }

          }  else if (type=="2"){
            if(int.parse(amount.text) >= int.parse("10")){
              addmony(context, amount.text, map['userids']);
            }else{
              Utils.flushBarErrorMessage(
                  "Minimum Recharge amount is \$10", context, Colors.white);
            }

          }
          else {
            if(type=="1"){
            Utils.flushBarErrorMessage(
                "Minimum Recharge amount is 100", context, Colors.white);}
            else{
              Utils.flushBarErrorMessage(
                  "Minimum Recharge amount is \$10", context, Colors.white);
            }
          }
        },
        text: "Add Cash");
  }

  Widget displayTransactionData(title, body) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$title: ", style: header),
          Flexible(
              child: Text(
            body,
            style: value,
          )),
        ],
      ),
    );
  }

  var wallet;

  TextEditingController amount = TextEditingController();
  int _selectedItemIndex =
      10; // Initialize with a value that won't match any index
  bool _isButtonEnabled = false;
  List<int> indianAmount = [10000, 50000, 100000, 200000, 500000, 5000000];
  List<int> usdAmount = [10, 500, 1000, 2000, 5000, 50000];
  void _handleTextChange() {
    setState(() {
      _selectedItemIndex = 10; // Reset selected index
      _isButtonEnabled = amount.text.isNotEmpty;
    });
  }

  void _handleListItemSelected(int index) {
    setState(() {
      _selectedItemIndex = type == "2" ? usdAmount[index] : indianAmount[index];
      amount.text = type == "2"
          ? usdAmount[index].toString()
          : indianAmount[index].toString(); // Update TextFormField text
      _isButtonEnabled = true;
    });
  }

  File? image;
  final picker = ImagePicker();
  String? base64Image;
  Future<void> getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
      base64Image = base64Encode(image!.readAsBytesSync());
    }
  }

  @override
  void dispose() {
    amount.dispose();
    super.dispose();
  }

  bool _loading = false;
  var catogery;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0)),
                // gradient: primaryGradient,
                color: lightBlue)),
        automaticallyImplyLeading: false,
        leading: const CustomBackButton(),
        centerTitle: true,
        title: Text(
          'RECHARGE',
          style: TextStyle(
              fontSize: 20.sp, fontWeight: FontWeight.w900, color: black),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Recharge_record()));
              },
              child: Text('History',
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w900,
                      color: black)))
        ],
      ),
      body: map != null && qr != null
          ? ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              children: [
                  const SizedBox(
                    height: 10,
                  ),
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
                              getQr();
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
                  const SizedBox(
                    height: 20,
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'BALANCE: ',
                      style: const TextStyle(
                          color: textGray,
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                      children: <TextSpan>[
                        TextSpan(
                            text: double.parse(map['wallet'])
                                        .toStringAsFixed(2) ==
                                    "null"
                                ? "₹0.0"
                                : "₹${double.parse(map['wallet']).toStringAsFixed(2)}",
                            style: days),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
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
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        children: [
                          GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
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
                                            side: const BorderSide(
                                                color: lightBlue),
                                            borderRadius:
                                                BorderRadius.circular(12)),
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
                                                color: _selectedItemIndex ==
                                                            indianAmount[
                                                                index] ||
                                                        _selectedItemIndex ==
                                                            usdAmount[index]
                                                    ? white
                                                    : lightBlue,
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25))),
                            child: TextField(
                              controller: amount,
                              textAlign: TextAlign.start,
                              keyboardType: TextInputType.number,
                              style: const TextStyle(
                                  color: black, fontWeight: FontWeight.w600),
                              onChanged: (text) {
                                _handleTextChange();
                              },
                              decoration: InputDecoration(
                                  // filled: true,
                                  //   fillColor:lightGray,
                                  prefixIcon: SizedBox(
                                    width: 70,
                                    child: Row(
                                      children: [
                                        const SizedBox(width: 10),
                                         Icon(
                                          type!="2"?
                                          Icons.currency_rupee:Icons.currency_exchange,
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
                                  hintText: "Enter Amount",
                                  helperStyle: TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey.shade200),
                                  border: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: lightBlue),
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
                    height: 16,
                  ),
                  type == "2"
                      ? const Text(
                          "Wallet Address",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: textGray,
                          ),
                        )
                      : Container(),
                  const SizedBox(
                    height: 10,
                  ),
                  type == "2"
                      ? Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: white,
                              border: Border.all(color: lightBlue),
                              borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                  width: width * 0.7,
                                  child: Text(qr['wallet_addres'] ?? "",
                                      textAlign: TextAlign.start)),
                              InkWell(onTap: () {
                                copyToClipboard(qr['wallet_addres'],context );
                              }, child: const Icon(Icons.copy))
                            ],
                          ),
                        )
                      : Container(),
                  const SizedBox(
                    height: 16,
                  ),
                  type == "2"
                      ? Container(
                          child: Image.network(
                          qr['image'] ?? "",
                          fit: BoxFit.fill,
                        ))
                      : Container(),
                  type == "2" && image != null
                      ? SizedBox(
                          height: height * 0.18,
                          child: Image.file(image!),
                        )
                      : Container(),
                  type == "2"
                      ? Login_button(
                          onTap: () {
                            setState(() {
                              getImage(ImageSource.gallery);
                            });
                          },
                          text: "Upload Image")
                      : Container(),
                  const SizedBox(
                    height: 30,
                  ),
                  _loading == false
                      ? Container(child: displayUpiApps())
                      : const CircularButton(),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  const Center(
                      child: Text(
                    "Minimum Recharge Amount is ₹100",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ))
                ])
          : const Center(child: CircularProgressIndicator()),
    );
  }

  var map;
  var qr;
  viewprofile() async {
    final prefs = await SharedPreferences.getInstance();
    final userid = prefs.getString("userId");

    final response = await http.get(
      Uri.parse('${ApiConst.profileView}$userid'),
    );
    var data = jsonDecode(response.body);
    print(data);
    print("mmmmmmmmmmmm");
    if (data['status'] == '200') {
      setState(() {
        map = data['data'];
        _loading = false;
      });
    } else {
      setState(() {
        _loading = false;
      });
    }
  }

  getQr() async {
    final response = await http.get(
      Uri.parse(ApiConst.qrAddress),
    );
    var data = jsonDecode(response.body);
    print(data);
    print("mmmmmmmmmmmm");
    if (data['status'] == '200') {
      setState(() {
        qr = data['data'];
        _loading = false;
      });
    } else {
      setState(() {
        _loading = false;
      });
    }
  }

  addmony(context, String amount, String userids) async {
    print("chala");
    print(amount);
    print("chala");

    setState(() {
      _loading = true;
    });

    print("userid");
    print(userids);
    final response = await http.post(
      Uri.parse(ApiConst.addMoney),
      body: jsonEncode({"userid": userids, "amount": amount, "type": type,"image":base64Image??""}),
    );
    final data = jsonDecode(response.body);
    print(data);
    print("😀😀😀");

    if (data["status"] == '200') {
      setState(() {
        _loading = false;
      });
      Utils.flushBarSuccessMessage(data["msg"], context, Colors.white);
    } else {
      setState(() {
        _loading = false;
      });
      Utils.flushBarErrorMessage(data["msg"], context, Colors.white);
    }
  }

  _launchURL(String urlget) async {
    var url = urlget;
    print(url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
