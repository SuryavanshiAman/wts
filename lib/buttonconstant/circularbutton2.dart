import 'package:wts/constant/constantColor.dart';
import 'package:flutter/material.dart';



class CircularButton2 extends StatefulWidget {
  const CircularButton2({
    Key? key,

    this.btnColor = lightBlue,
    this.textColor = white,
    this.border,
  }) : super(key: key);



  final Color? btnColor;
  final Color? textColor;
  final BoxBorder? border;

  @override
  State<CircularButton2> createState() => _CircularButton2State();
}

class _CircularButton2State extends State<CircularButton2> {

  @override
  Widget build(BuildContext context) {

    return InkWell(

      child: Ink(
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                100
            ),
          ),
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: widget.btnColor,
              borderRadius: BorderRadius.circular(
                100,
              ),
              border: widget.border,
            ),
            child: const Center(
                child: CircularProgressIndicator(color: white,)
            ),
          ),
        ),
      ),
    );
  }



}