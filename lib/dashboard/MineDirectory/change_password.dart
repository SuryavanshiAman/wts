import 'dart:convert';

import 'package:wts/Widgets/rectanglebutton.dart';
import 'package:wts/buttonconstant/buttonConstant';
import 'package:wts/buttonconstant/circularbutton2.dart';
import 'package:wts/constant/apiConstant.dart';
import 'package:wts/constant/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;

import '../../constant/constantColor.dart';


class Changepassword extends StatefulWidget {
  const Changepassword({Key? key}) : super(key: key);

  @override
  State<Changepassword> createState() => _ChangepasswordState();
}

class _ChangepasswordState extends State<Changepassword> {

  bool oldpass = false;
  bool newpass = false;
  bool confirmpass = false;
  bool _loading = false;
  TextEditingController oldpassword = TextEditingController();
  TextEditingController newpassword = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();

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
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                gradient: LinearGradient(
                    colors: [lightBlue,white],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter
                )
            )
        ),
        automaticallyImplyLeading: false,
        leading: const CustomBackButton(),
        centerTitle: true,
        title: Text('CHANGE PASSWORD',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 20.sp,
            color: black,
          ), ),
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
          children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.r)
              ),
              elevation: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0,top: 18),
                    child: Text('Old Password',style: TextStyle(fontSize:13.sp,fontWeight: FontWeight.w900),),
                  ),
                  Padding(
                    padding:  const EdgeInsets.all(8.0),
                    child: TextField(
                        controller: oldpassword,
                        obscureText: !oldpass,
                        decoration: InputDecoration(

                          prefixIcon: const Icon(Icons.password),
                          suffixIcon: IconButton(
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              oldpass
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              // Update the state i.e. toogle the state of passwordVisible variable
                              setState(() {
                                oldpass = !oldpass;
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
                    padding: const EdgeInsets.only(left: 18.0,top: 18),
                    child: Text('New Password',style: TextStyle(fontSize:13.sp,fontWeight: FontWeight.w900),),
                  ),
                  Padding(
                    padding:  const EdgeInsets.all(8.0),
                    child: TextField(
                        controller: newpassword,
                        obscureText: !newpass,
                        decoration: InputDecoration(

                          prefixIcon: const Icon(Icons.password),
                          suffixIcon: IconButton(
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              newpass
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                newpass = !newpass;
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
                    padding: const EdgeInsets.only(left: 18.0,top: 18),
                    child: Text('Confirm Password',style: TextStyle(fontSize:13.sp,fontWeight: FontWeight.w900),),
                  ),
                  Padding(
                    padding:  const EdgeInsets.all(8.0),
                    child: TextField(
                        controller: confirmpassword,
                        obscureText: !confirmpass,
                        decoration: InputDecoration(

                          prefixIcon: const Icon(Icons.password),
                          suffixIcon: IconButton(
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              confirmpass
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              // Update the state i.e. toogle the state of passwordVisible variable
                              setState(() {
                                confirmpass = !confirmpass;
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
                  SizedBox(height: 50.h,),
                  _loading == false
                      ? CustomButton(
                    text: 'UPDATE',
                    textColor: Colors.white,
                    onTap: () async {
                      Changepass(oldpassword.text,newpassword.text,confirmpassword.text);
                    },
                  )
                      :
                  const Center(child: CircularButton2())
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Changepass(String oldpassword,String newpassword, String confirmpassword)async {
    final prefs = await SharedPreferences.getInstance();
    final userid = prefs.getString("userId");
    setState(() {
      _loading=true;
    });

    final response =  await http.post(Uri.parse(ApiConst.changePassword),
      headers:<String ,String>{
        "Content-Type":"application/json; charset=UTF-8",
      },
      body: jsonEncode(<String ,String>{

        "userid":'$userid',
        "oldpassword":oldpassword,
        "newpassword":newpassword,
        "confirmpassword":confirmpassword,
      }),
    );
    var data = jsonDecode(response.body);
    print(data);
    print('qqqqqqqqqqqqqqqqqq');
    if(data["status"]=='200'){

      setState(() {
        _loading=false;
      });
      Navigator.pop(context);
      Utils.flushBarSuccessMessage(data["msg"],context,white);
    }
    else{
      setState(() {
        _loading= false;
      });
      Utils.flushBarErrorMessage( data["msg"],context,white);
    }

  }

}
