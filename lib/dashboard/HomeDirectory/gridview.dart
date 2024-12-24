import 'package:wts/constant/assetsConstant.dart';
import 'package:wts/constant/constantColor.dart';
import 'package:wts/constant/launcherMsg.dart';
import 'package:wts/dashboard/HomeDirectory/bonus.dart';
import 'package:wts/dashboard/HomeDirectory/myTeam.dart';
import 'package:wts/dashboard/HomeDirectory/weeklySalary.dart';
import 'package:wts/dashboard/MineDirectory/myProject.dart';
import 'package:wts/dashboard/ProductDirectory/refer_earn.dart';
import 'package:wts/recharge/rechargeAmount.dart';
import 'package:flutter/material.dart';
import 'package:wts/constant/textStyleConstant.dart';
import 'package:wts/dashboard/HomeDirectory/monthlySalary.dart';
import 'package:wts/dashboard/HomeDirectory/withdraw.dart';


class GridViewPage extends StatefulWidget {
  const GridViewPage({Key? key}) : super(key: key);

  @override
  State<GridViewPage> createState() => _GridViewPageState();
}

class _GridViewPageState extends State<GridViewPage> {
  @override
  Widget build(BuildContext context) {
    return GridView(
      shrinkWrap: true,
       physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 1.0,
      ),
      scrollDirection: Axis.vertical,
      children: [
        InkWell(
          onTap: (){
            Navigator.push(context,
                MaterialPageRoute(
                    builder: (context)=>const RechargeAmount()));
          },
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(elevation:6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80),
                    //set border radius more than 50% of height and width to make circle
                  )
                  ,
                  child: const CircleAvatar(
                    radius:22,
                    backgroundColor: blue,
                    child:
                    CircleAvatar(radius: 16,
                      backgroundImage: AssetImage(recharge),backgroundColor: blue, ),
                  ),
                ),
              ),
              const Center(
                child: Text('Recharge',style: gridText,),
              ),
              // title: name[index]
            ],
          ),
        ),

        InkWell(
          onTap: (){
             Navigator.push(context, MaterialPageRoute(builder: (context)=>const WithdrawPage()));
          },
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(elevation:6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80),
                    //set border radius more than 50% of height and width to make circle
                  )
                  ,
                  child: const CircleAvatar(
                    radius:22,
                    backgroundColor:blue,
                    child: CircleAvatar(radius: 16,

                      backgroundImage: AssetImage(withdraw),backgroundColor: Colors.white, ),
                  ),
                ),

              ),
              const Center(
                child: Text('Withdraw',style: gridText,),
              ),
              // title: name[index]
            ],
          ),
        ),

        InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const MyTeam(
            )));
          },
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(elevation:6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80),
                    //set border radius more than 50% of height and width to make circle
                  )
                  ,
                  child: const CircleAvatar(
                    radius:22,
                    backgroundColor: blue,
                    child: CircleAvatar(radius: 16,

                      backgroundImage: AssetImage(teams),backgroundColor: Colors.white, ),
                  ),
                ),

              ),
              const Center(
                child: Text('Teams',style: gridText,),
              ),
              // title: name[index]
            ],
          ),
        ),

        InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>ReferEarn()));
          },
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(elevation:6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80),
                    //set border radius more than 50% of height and width to make circle
                  )
                  ,
                  child: const CircleAvatar(
                    radius:22,
                    backgroundColor: blue,
                    child: CircleAvatar(radius: 16,

                      backgroundImage: AssetImage(invitation),backgroundColor: Colors.white, ),
                  ),
                ),

              ),
              const Center(
                child: Text('Invitation',style: gridText,),
              ),
              // title: name[index]
            ],
          ),
        ),

        InkWell(
          onTap: (){
             Navigator.push(context, MaterialPageRoute(builder: (context)=>const Bonus_Page()));

          },
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(elevation:6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80),
                    //set border radius more than 50% of height and width to make circle
                  )
                  ,
                  child: const CircleAvatar(
                    radius:22,
                    backgroundColor:blue,
                    child: CircleAvatar(radius: 16,

                      backgroundImage: AssetImage(bonus),backgroundColor: Colors.white, ),
                  ),
                ),

              ),
              const Center(
                child: Text('Bonus',style: gridText,),
              ),
              // title: name[index]
            ],
          ),
        ),
        InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const MyProjectPage()));

          },
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(elevation:6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80),
                    //set border radius more than 50% of height and width to make circle
                  )
                  ,
                  child: const CircleAvatar(
                    radius:22,
                    backgroundColor:blue,
                    child: CircleAvatar(radius: 16,

                      backgroundImage: AssetImage(project),backgroundColor: Colors.white, ),
                  ),
                ),

              ),
              const Center(
                child: Text('My Project',style: gridText,),
              ),
              // title: name[index]
            ],
          ),
        ),
        // InkWell(
        //   onTap: (){
        //      Navigator.push(context, MaterialPageRoute(builder: (context)=>const WEEKLYSALARY()));
        //   },
        //   child: Column(
        //     children: [
        //       Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: Card(elevation:6,
        //           shape: RoundedRectangleBorder(
        //             borderRadius: BorderRadius.circular(80),
        //             //set border radius more than 50% of height and width to make circle
        //           )
        //           ,
        //           child: const CircleAvatar(
        //             radius:22,
        //             backgroundColor: Colors.white,
        //             child: CircleAvatar(radius: 16,
        //               backgroundImage: AssetImage(weeklySalary),backgroundColor: Colors.white, ),
        //           ),
        //         ),
        //
        //       ),
        //       const Center(
        //         child: Text('Weekly Salary',style: gridText,),
        //       ),
        //       // title: name[index]
        //     ],
        //   ),
        // ),
        InkWell(
          onTap: (){
             Navigator.push(context, MaterialPageRoute(builder: (context)=>const Monthly_Salary(
            )));
            // Teligram();
          },
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(elevation:6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80),
                    //set border radius more than 50% of height and width to make circle
                  )
                  ,
                  child: const CircleAvatar(
                    radius:22,
                    backgroundColor: blue,
                    child: CircleAvatar(radius: 16,

                      backgroundImage: AssetImage(monthlySalary),backgroundColor: Colors.white, ),
                  ),
                ),

              ),
              const Center(
                child: Text('Monthly Salary',style: gridText,),
              ),
              // title: name[index]
            ],
          ),
        ),
        InkWell(
          onTap: (){
            //  Navigator.push(context, MaterialPageRoute(builder: (context)=>const Monthly_Salary(
            // )));
            Launcher.openteligram();
          },
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(elevation:6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80),
                    //set border radius more than 50% of height and width to make circle
                  )
                  ,
                  child: const CircleAvatar(
                    radius:22,
                    backgroundColor: blue,
                    child: CircleAvatar(radius: 16,

                      backgroundImage: AssetImage(telegram),backgroundColor: Colors.white, ),
                  ),
                ),

              ),
              const Center(
                child: Text('Telegram',style: gridText,),
              ),
              // title: name[index]
            ],
          ),
        ),
      ],
    );
  }
}
