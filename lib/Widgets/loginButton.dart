import 'package:wts/constant/constantColor.dart';
import 'package:flutter/material.dart';



class Login_button extends StatefulWidget {
  const Login_button({
    Key? key,
    required this.onTap,
    required this.text,
    this.btnColor = lightBlue,
    this.textColor = white,
    this.border,
  }) : super(key: key);

  final Function() onTap;
  final String text;
  final Color? btnColor;
  final Color? textColor;
  final BoxBorder? border;

  @override
  State<Login_button> createState() => _Login_buttonState();
}

class _Login_buttonState extends State<Login_button> {

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: () {
        widget.onTap();
      },
      child: Ink(
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
            25
            ),
          ),
          child: Container(
            width: width*0.7,
            height: height*0.06,
            decoration: BoxDecoration(
              color: widget.btnColor,
              gradient: const LinearGradient(
                  colors: [lightBlue, bgColor,],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(
                10,
              ),
              border: widget.border,
            ),
            child: Center(
              child: Text(
                widget.text,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: widget.textColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  letterSpacing: 1.25,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }



}