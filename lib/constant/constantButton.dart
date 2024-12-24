import 'package:wts/constant/constantColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class constantbutton extends StatefulWidget {
  const constantbutton({
    Key? key,
    required this.onTap,
    required this.text,
    this.btnColor = lightBlue,
    this.textColor = white,
    this.border,
    this.width,
    this.height,
    this.gradient

  }) : super(key: key);

  final Function() onTap;
  final String text;
  final Color? btnColor;
  final Color? textColor;
  final BoxBorder? border;
  final double? width;
  final double? height;
  final Gradient? gradient;


  @override
  State<constantbutton> createState() => _constantbuttonState();
}

class _constantbuttonState extends State<constantbutton> {

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
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                5
            ),
          ),
          child: Container(
            width:widget.width??width*0.5,
            height:widget.height??height*0.05,
            decoration: BoxDecoration(
              // color: widget.btnColor,
              gradient: const LinearGradient(
                  colors: [lightBlue, bgColor,],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
              // gradient:widget.gradient ,
              borderRadius: BorderRadius.circular(
                5,
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