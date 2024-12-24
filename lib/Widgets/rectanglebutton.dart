import 'package:wts/constant/constantColor.dart';
import 'package:flutter/material.dart';



class CustomButton extends StatefulWidget {
  const CustomButton({
    Key? key,
    required this.onTap,
    required this.text,
    this.btnColor = lightBlue,
    this.textColor = white,
    this.border,
    this.width,
    this.height,
  }) : super(key: key);

  final Function() onTap;
  final String text;
  final Color? btnColor;
  final Color? textColor;
  final BoxBorder? border;
  final double? width;
  final double? height;


  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {

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
              10
            ),
          ),
          child: Container(

            width: widget.width??width*0.99,
            height: widget.height??height*0.05,
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