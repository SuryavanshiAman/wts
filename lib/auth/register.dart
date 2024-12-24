// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:wts/Widgets/circularProgressButton.dart';
import 'package:wts/Widgets/loginButton.dart';
import 'package:wts/auth/backgroundDesign.dart';
import 'package:wts/constant/apiConstant.dart';
import 'package:wts/constant/flushbar.dart';
import 'package:wts/dashboard/HomeDirectory/home.dart';
import 'package:wts/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:wts/constant/constantColor.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
bool _passwordVisible = false;
class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController nameController = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController referral = TextEditingController();
  bool loading=false;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
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
              child: TextField(
                keyboardType: TextInputType.number,
                maxLength: 10,
                controller: nameController,
                decoration: const InputDecoration(
                    counter: Offstage(),
                    prefixIcon: Icon(Icons.phone_iphone),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.black),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                      ),
                    ),
                    hintText: "Enter your mobile number"),
              ),
            ),
            Padding(
              padding:  const EdgeInsets.all(8.0),
              child: TextField(
                  controller: password,
                  obscureText: !_passwordVisible,
                  decoration: InputDecoration(

                    prefixIcon: const Icon(Icons.password),
                    suffixIcon: IconButton(
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
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.black),
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                      ),
                    ),
                    hintText: "Enter your password",
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                  controller: referral,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.pin),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.black),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                      ),
                    ),
                    hintText: "Enter referral code ",
                  )),
            ),
            SizedBox(
              height: height * 0.07,
            ),
            loading==false?
            Login_button(onTap: () {
              print("hhhh");
              register(nameController.text,password.text,referral.text); }, text: 'Sin Up',):
            const CircularButton(),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left:
                      MediaQuery.of(context).viewInsets.left + 50.0),
                  child: const Text("Already have an account? ",
                      style: TextStyle(
                          color: lightBlue,
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                ),
                InkWell(
                    onTap: () {
                      // setState(() {
                      //   print("tata");
                      //   isSecondPage=false;
                      // });
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) =>
                      //         const Register()));
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
  register(String nameController,String password,String referral )async {
    print("Aman$nameController");
    print("Aman$password");
    print("Aman$referral");
    setState(() {
      loading=true;
    });
    final response =  await http.post(Uri.parse(ApiConst.registerUrl),
      headers:<String ,String>{
        "Content-Type":"application/json; charset=UTF-8",
      },
      body: jsonEncode(<String ,String>{
        "mobile": nameController,
        "password": password,
        "refcode": referral,

      }),
    );
    var data = jsonDecode(response.body);
    if(data["status"]=="200"){
      final prefs = await SharedPreferences.getInstance();
      const key = 'userId';
      final userId = data['id'].toString();
      prefs.setString(key, userId);
      setState(() {
        loading=false;
      });
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Home()));
    }
    else{
      setState(() {
        loading= false;
      });
      Utils.flushBarErrorMessage( data["msg"],context,white);
    }

  }
}
