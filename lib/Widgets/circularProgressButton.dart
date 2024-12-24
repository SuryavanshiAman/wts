import 'package:wts/constant/constantColor.dart';
import 'package:flutter/material.dart';



class CircularButton extends StatefulWidget {
  const CircularButton({
    Key? key,

    this.btnColor = lightBlue,
    this.textColor = white,
    this.border,
  }) : super(key: key);



  final Color? btnColor;
  final Color? textColor;
  final BoxBorder? border;

  @override
  State<CircularButton> createState() => _CircularButtonState();
}

class _CircularButtonState extends State<CircularButton> {

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

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
            child: Center(
              child: CircularProgressIndicator(color: white,)
            ),
          ),
        ),
      ),
    );
  }



}