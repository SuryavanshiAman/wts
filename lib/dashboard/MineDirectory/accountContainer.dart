import 'package:wts/constant/constantColor.dart';
import 'package:wts/constant/textStyleConstant.dart';
import 'package:flutter/material.dart';
import 'package:wts/support_api.dart';

class Account_Cont extends StatefulWidget {
  final earns;
   Account_Cont({required this.earns}) ;

  @override
  State<Account_Cont> createState() => _Account_ContState();
}

class _Account_ContState extends State<Account_Cont> {
  @override
  void initState() {

    print(double.parse(widget.earns["totalearning"]).toStringAsFixed(2),);
    print("hello");
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
          Radius.circular(20),
        )),
        child: Container(
          height: height * 0.3,

          padding: const EdgeInsets.all(12.0),
          width: width * 0.77,
          decoration: BoxDecoration(
            border: Border.all(color: lightBlue),
            borderRadius: BorderRadius.all(
              Radius.circular(18),
            ),
            color: white,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Total earning : ", style: TextStyle(color: black,fontWeight: FontWeight.w600,fontSize: 18)),
                  Text("Team income : ", style: TextStyle(color: black,fontWeight: FontWeight.w600,fontSize: 18)),
                  Text('Income today : ', style: TextStyle(color: black,fontWeight: FontWeight.w600,fontSize: 18)),
                  Text("Project : ",  style: TextStyle(color: black,fontWeight: FontWeight.w600,fontSize: 18)),
                  Text("Recharge : ", style: TextStyle(color: black,fontWeight: FontWeight.w600,fontSize: 18)),
                  Text('Withdraws : ', style: TextStyle(color: black,fontWeight: FontWeight.w600,fontSize: 18)),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
             widget.earns["totalearning"]
                      ==null?"0.0":"₹${double.parse(widget.earns["totalearning"
                      ]).toStringAsFixed(2)}",
                      // widget.earns["totalearning"].toString(),
                      style: rs0,
                    ),
                     Text(widget.earns["teamEarning"]==null?"0.0":
                     "₹${double.parse(widget.earns["teamEarning"
                         ]).toStringAsFixed(2)}", style: rs0),
                     Text(widget.earns["todayEarning"]==null?"0.0":
                     "₹${double.parse(widget.earns["todayEarning"
                         ]).toStringAsFixed(2)}", style: rs0),
                    Text(widget.earns["project"]==null?"0.0":
                    "₹${double.parse(widget.earns["project"]).toStringAsFixed(2)}", style: rs0),
                    Text(widget.earns["recharge"]==null?"0.0":
                    "₹${double.parse(widget.earns["recharge"]).toStringAsFixed(2)}", style: rs0),
                    Text(widget.earns["withdraw"]== null?"0.0":
                   "₹${double.parse(widget.earns["withdraw"]).toStringAsFixed(2)}", style: rs0),
                  ],
                ),
              ),
              // SizedBox(
              //   height: height * 0.03,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: [
              //
              //   ],
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: [
              //
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
