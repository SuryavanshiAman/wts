
// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:wts/Widgets/circularProgressButton.dart';
import 'package:wts/Widgets/loginButton.dart';
import 'package:wts/auth/backgroundDesign.dart';
import 'package:wts/auth/register.dart';
import 'package:wts/constant/apiConstant.dart';
import 'package:wts/constant/constantColor.dart';
import 'package:wts/constant/flushbar.dart';
import 'package:wts/constant/launcherMsg.dart';
import 'package:wts/constant/textStyleConstant.dart';
import 'package:wts/dashboard/HomeDirectory/home.dart';
import 'package:wts/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';



class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}
bool _passwordVisible = false;
class _LoginState extends State<Login> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool loading =false;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Card(elevation: 0,
      child: Container(alignment: Alignment.center,
        height: height*2,
        width: width*1,
         color: white,

        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(

                controller: nameController,
                keyboardType: TextInputType.number,
                maxLength: 10,
                style: f630,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.phone_iphone),
                    counter: Offstage(),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          width: 1, color: Colors.black),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                      ),
                    ),
                    hintText: "Enter  mobile number"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                style: f630,
                  controller: passController,
                  obscureText: !_passwordVisible,
                  decoration: InputDecoration(prefixIcon: const Icon(Icons.password),
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
                      borderSide: BorderSide(
                          width: 1, color: Colors.black),
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                      ),
                    ),
                    hintText: "Enter your password",)

              ),
            ),
            SizedBox(height: height*0.07,),

            loading==false?
            Login_button(onTap: () {
              if(nameController.text.length!=10){
                Utils.flushBarErrorMessage("Enter proper mobile no. ", context, white);
              }else{
                login(nameController.text,passController.text);
              }
              }, text: 'Sign In',):
            const CircularButton(),
            SizedBox(height: height*0.01,),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left:
                      MediaQuery.of(context).viewInsets.left + 50.0),
                  child: Text("Don't have an account ",
                      style: TextStyle(
                          color: lightBlue,
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                ),
                InkWell(
                    onTap: () {
                      // setState(() {
                      //   print("tata");
                      //   isSecondPage=true;
                      // });
                      // print(isSecondPage);
                      print("isSecondPage");
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) =>
                      //         const Register()));
                    },
                    child: Text("Register here",
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
              child: TextButton(onPressed: (){
              }, child:
              TextButton( onPressed: () { Launcher.openwhatsapp(context); },
                  child: const Text("Forgot Password ?",style:line,))),
            )

          ],
        ),

      ),
    );
  }
  login(String nameController,String passController)async {
    setState(() {
       loading=true;
    });
    final response =  await http.post(Uri.parse(ApiConst.loginUrl),
      //   headers:<String ,String>{
      // "Content-Type":"application/json; charset=UTF-8",
      //   },
        body: jsonEncode(<String ,String>{
        "mobile": nameController,
        "password": passController,
    }),
    );
    var data = jsonDecode(response.body);
    if(data["status"]=='200'){

      setState(() {
        loading=false;
      });
      final prefs = await SharedPreferences.getInstance();
      const key = 'userId';
      final userId = data['id'];
      prefs.setString(key, userId);
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
