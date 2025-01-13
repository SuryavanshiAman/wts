// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:wts/auth/login.dart';
import 'package:wts/auth/register.dart';
import 'package:wts/constant/assetsConstant.dart';
import 'package:wts/constant/constantColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wts/constant/custom_text_field.dart';
import 'package:wts/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_switch/sliding_switch.dart';

import '../Widgets/circularProgressButton.dart';
import '../Widgets/loginButton.dart';
import '../constant/apiConstant.dart';
import '../constant/flushbar.dart';
import '../constant/launcherMsg.dart';
import '../constant/textStyleConstant.dart';
import '../dashboard/HomeDirectory/home.dart';



class BackgroundDesign extends StatefulWidget {
  const BackgroundDesign({super.key});

  @override
  State<BackgroundDesign> createState() => _BackgroundDesignState();
}

class _BackgroundDesignState extends State<BackgroundDesign> {
  // void _toggleSwitch(bool value) {
  //   setState(() {
  //     _isSecondPage = value;
  //   });
  // }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  bool isSecondPage = false;
  @override
  Widget build(BuildContext context) {
    print("---> $isSecondPage");
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              shadowColor: Colors.black,
              title: Text(
                'Are you sure?',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: black,
                ),
              ),
              content: Text(
                'Do you want to exit from App',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: black,
                ),
              ),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                TextButton(
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                  child: const Text('Yes'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text('No'),
                ),
              ],
            );
          },
        );
        return shouldPop!;
      },
      child: Scaffold(
        body: ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            children: [
              Card(
                elevation: 3,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(30),
                        bottomLeft: Radius.circular(30))),
                child: Container(
                  height: height * 0.4,
                  // width: width * 1,
                  decoration: const BoxDecoration(
                      image:
                          DecorationImage(image: AssetImage(logo), scale: 2.5),
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(30),
                          bottomLeft: Radius.circular(30)),
                      gradient: LinearGradient(
                          colors: [
                            lightBlue,
                            white,
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter)),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [

                    ],
                  ),
                ),
              ),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        height: 350,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.transparent),
                        child: isSecondPage ?  registerWidget() :  loginWidget()),
                  ),
                ],
              )
            ]),
      ),
    );
  }

  TextEditingController passController = TextEditingController();
  Widget loginWidget() {
    return Card(
      elevation: 0,
      child: Container(
        alignment: Alignment.center,
        height: height * 2,
        width: width * 1,
        color: white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextField(
                controller: nameController,
                keyboardType: TextInputType.number,
                // contentPadding: EdgeInsets.all(10),
                maxLines: 1,
                maxLength: 10,
                style: f630,
                label: "Enter  mobile number",
                prefix: Icon(Icons.phone_iphone),
                filled: true,
                fillColor: white,
                outLineBorderEnabled: true,
                borderSide: BorderSide(color: bgColor),
              )

            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextField(
                controller: passController,
                obscureText: !_passwordVisible,
                maxLines: 1,
                style: f630,
                label:  "Enter your password",
                prefix: const Icon(Icons.password),
                filled: true,
                fillColor: white,
                suffix: IconButton(
                  icon: Icon(
                    // Based on passwordVisible state choose the icon
                    _passwordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
                outLineBorderEnabled: true,
                borderSide: BorderSide(color: bgColor),
              )

            ),

            SizedBox(
              height: height * 0.03,
            ),
            loading == false
                ? Login_button(
                    onTap: () {
                      if (nameController.text.length != 10) {
                        Utils.flushBarErrorMessage(
                            "Enter proper mobile no. ", context, white);
                      } else {
                        login(nameController.text, passController.text);
                      }
                    },

                    text: 'Sign In',
                  )
                : const CircularButton(),
            SizedBox(
              height: height * 0.01,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).viewInsets.left + 50.0),
                  child: const Text("Don't have an account? ",
                      style: TextStyle(
                          color: lightBlue,
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                ),
                InkWell(
                    onTap: () {
                      setState(() {
                        print("tata");
                        isSecondPage = true;
                      });
                      print(isSecondPage);
                      print("isSecondPage");

                    },
                    child: const Text("Register here",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            decoration: TextDecoration.underline))),
              ],
            ),
            // SizedBox(height: height*0.01,),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                  onPressed: () {},
                  child: TextButton(
                      onPressed: () {
                        Launcher.openwhatsapp(context);
                      },
                      child: const Text(
                        "Forgot Password ?",
                        style: line,
                      ))),
            )
          ],
        ),
      ),
    );
  }
  TextEditingController nameController = TextEditingController();
  TextEditingController password = TextEditingController();
  login(String nameController, String passController) async {
    print("🤡🤡🤡");
    setState(() {
      loading = true;
    });
    print("hhhhh");
    final response = await http.post(
      Uri.parse(ApiConst.loginUrl),
      //   headers:<String ,String>{
      // "Content-Type":"application/json; charset=UTF-8",
      //   },
      body: jsonEncode(<String, String>{
        "mobile": nameController,
        "password": passController,
      }),
    );
    var data = jsonDecode(response.body);
    if (data["status"] == '200') {
      setState(() {
        loading = false;
      });
      print("aman");
      final prefs = await SharedPreferences.getInstance();
      const key = 'userId';
      final userId = data['id'];
      prefs.setString(key, userId);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Home()));
    } else {
      setState(() {
        loading = false;
      });
      Utils.flushBarErrorMessage(data["msg"], context, white);
    }
  }

  ///-------------------------


  TextEditingController referral = TextEditingController();
  bool loading = false;
  bool _passwordVisible = false;
  Widget registerWidget() {
    return Card(
      elevation: 0,
      child: Container(
        alignment: Alignment.center,
        height: height * 2,
        width: width * 1,
        color: white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextField(
                controller: nameController,
                keyboardType: TextInputType.number,
                maxLength: 10,
                maxLines: 1,
                style: f630,
                label: "Enter  mobile number",
                prefix: Icon(Icons.phone_iphone),
                filled: true,
                fillColor: white,
                outLineBorderEnabled: true,
                borderSide: BorderSide(color: bgColor),
              )

            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextField(
                controller: password,
                obscureText: !_passwordVisible,
                maxLines: 1,
                style: f630,
                label:  "Enter your password",
                prefix: const Icon(Icons.password),
                filled: true,
                fillColor: white,
                suffix: IconButton(
                  icon: Icon(
                    // Based on passwordVisible state choose the icon
                    _passwordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
                outLineBorderEnabled: true,
                borderSide: BorderSide(color: bgColor),
              )

            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextField(
                controller: referral,
                style: f630,
                maxLines: 1,
                label:  "Enter referral code ",
                prefix: Icon(Icons.pin),
                filled: true,
                fillColor: white,
                suffix: IconButton(
                  icon: Icon(
                    // Based on passwordVisible state choose the icon
                    _passwordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
                outLineBorderEnabled: true,
                borderSide: BorderSide(color: bgColor),
              )

            ),
            SizedBox(
              height: height * 0.03,
            ),
            loading == false
                ? Login_button(
                    onTap: () {
                      print("hhhh");
                      register(
                          nameController.text, password.text, referral.text);
                    },
                    text: 'Sign Up',
                  )
                : const CircularButton(),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).viewInsets.left + 50.0),
                  child: const Text("Already have an account? ",
                      style: TextStyle(
                          color: lightBlue,
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                ),
                InkWell(
                    onTap: () {
                      setState(() {
                        print("tata");
                        isSecondPage = false;
                      });
                    },
                    child: const Text("SignIn",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            decoration: TextDecoration.underline))),
              ],
            ),
          ],
        ),
      ),
    );
  }

  register(String nameController, String password, String referral) async {
    print("Aman$nameController");
    print("Aman$password");
    print("Aman$referral");
    setState(() {
      loading = true;
    });
    final response = await http.post(
      Uri.parse(ApiConst.registerUrl),
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
      },
      body: jsonEncode(<String, String>{
        "mobile": nameController,
        "password": password,
        "refcode": referral,
      }),
    );
    var data = jsonDecode(response.body);
    if (data["status"] == "200") {
      final prefs = await SharedPreferences.getInstance();
      const key = 'userId';
      final userId = data['id'].toString();
      prefs.setString(key, userId);
      setState(() {
        loading = false;
      });
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Home()));
    } else {
      setState(() {
        loading = false;
      });
      Utils.flushBarErrorMessage(data["msg"], context, white);
    }
  }
}
