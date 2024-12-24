import 'package:flutter/material.dart';
import 'package:wts/constant/assetsConstant.dart';
import 'package:wts/constant/constantColor.dart';
import 'package:wts/constant/textStyleConstant.dart';

class Unexpired_product extends StatefulWidget {
  const Unexpired_product({Key? key}) : super(key: key);

  @override
  State<Unexpired_product> createState() => _Unexpired_productState();
}

class _Unexpired_productState extends State<Unexpired_product> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return ListView.builder(itemCount: 2,
        itemBuilder: (BuildContext context,int index){
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(elevation: 3,
          child: Container(
            height: height*0.2,
            width: width*0.99,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: white),
            child: Row(
              children: [
                Container(
                  height: height*0.15,
                    width: width*0.25,

                    child: Image.asset(recharge)),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Tk-45800",style: f630,),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Price"),
                          SizedBox(width: width*0.15,),
                          Text("45800.00RS"),
                        ],
                      ),



                      Row(
                        children: [
                          Text("Term"),
                          SizedBox(width: width*0.16,),
                          Text("13/54 days"),
                        ],
                      ),
                      // Divider(),
                      Row(
                        children: [
                          Text("Total earnings"),
                           SizedBox(width: width*0.01,),
                          Text("42868.80RS"),
                        ],
                      ),
                      Divider(),
                    ],
                  ),
                ),
                Container(alignment: Alignment.center,
                  height: height*0.07,
                  width: width*0.15,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: lightBlue),
                  child: Text("Receive"),
                )
              ],
            ),
          ),
        ),
      );

    });
  }
}
