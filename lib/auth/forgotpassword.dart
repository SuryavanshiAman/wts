
import 'package:wts/constant/constantColor.dart';
import 'package:flutter/material.dart';


class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SafeArea(child: Scaffold(
      body: Card(
        child: Container(alignment: Alignment.center,
          height: height*2,
          width: width*1,

          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(

                  controller: nameController,
                  decoration: const InputDecoration(prefixIcon: Icon(Icons.phone_iphone),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            width: 1, color: Colors.black),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                        ),
                      ),

                      hintText: "please enter your mobile number...."),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(prefixIcon: Icon(Icons.password),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            width: 1, color: Colors.black),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                        ),
                      ),
                      hintText: "please enter your password....",)

                ),
              ),
              SizedBox(height: height*0.07,),
              SizedBox(
                width: width*0.7,
                height: height*0.06,
                child: ElevatedButton(onPressed: (){},  style: ElevatedButton.styleFrom(
                  backgroundColor:Colors.orangeAccent,
                ),
                    child: const Text("Save",style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                        color: Colors.white),)),
              ),
              SizedBox(height: height*0.05,),
              TextButton(onPressed: (){}, child:
              const Text("Back to Login",style: TextStyle(color: bgColor),))

            ],
          ),

        ),
      ),
    )
    );
  }
}
