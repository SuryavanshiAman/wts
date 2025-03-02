import 'package:wts/constant/constantColor.dart';
import 'package:wts/constant/textStyleConstant.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';


class Animated_Text extends StatefulWidget {
  const Animated_Text({Key? key}) : super(key: key);

  @override
  State<Animated_Text> createState() => _Animated_TextState();
}

class _Animated_TextState extends State<Animated_Text> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: height*0.06,
        width: width*1,
        decoration: BoxDecoration( borderRadius: BorderRadius.all(Radius.circular(10)),
            color: white),
        child: Row(
          children: [
            Icon(Icons.celebration_outlined,color:lightRed,),
            SizedBox(width: width*0.02,),
            AnimatedTextKit(
              animatedTexts: [
                RotateAnimatedText('Aman Kumar chauhan'),

              ],
              onTap: () {
                print("Tap Event");
              },
            ),
          ],
        ),
      ),
    );
  }
}
