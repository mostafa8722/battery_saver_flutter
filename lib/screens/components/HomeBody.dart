


import 'dart:async';

import 'package:battery/battery.dart';
import 'package:flutter/material.dart';

class HomeBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StateHomeBody();

}
class StateHomeBody extends State<HomeBody>{

  String status_label = "Full";
  String percentage_label = "30";
  String image_src = "assets/images/b25.png";


 final Battery battery = Battery();
  BatteryState? _batteryState;
  late StreamSubscription<BatteryState> _batteryStateSubscription;
 int batteryLevel = 100;
 late Timer timer ;

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listenBatteryLevel();
  }

  @override
  void dispose() {
    timer.cancel();
    if (_batteryStateSubscription != null) {
      _batteryStateSubscription.cancel();
    }
    super.dispose();
  }
  void listenBatteryLevel(){
   updateBatteryLevel();
   timer  = Timer.periodic(
   Duration(seconds: 10)
   , (_)async {updateBatteryLevel(); });
  }

  Future  updateBatteryLevel() async{
   final batteryLevel = await battery.batteryLevel;

   setState(() {
     percentage_label = batteryLevel.toString();
     this.batteryLevel = batteryLevel;

     if (batteryLevel < 5)
       image_src ="assets/images/b0.png";
     else if (batteryLevel < 18)
       image_src ="assets/images/b25.png";
      else if (batteryLevel < 55)
     image_src ="assets/images/b50.png";
     else if (batteryLevel < 80)
     image_src ="assets/images/b75.png";
       else
     image_src ="assets/images/b100.png";

   });

   _batteryStateSubscription =
       battery.onBatteryStateChanged.listen((BatteryState state) {
     setState(() {
       _batteryState = state;
       if(state== BatteryState.full)
       status_label =  "Full" ;
       else if(state== BatteryState.charging)
         status_label =  "Charging" ;
       else if(state== BatteryState.discharging)
         status_label =  "discharging" ;
     });
   });

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Center(
      child:
      new Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          new Container(
            margin: const EdgeInsets.only(top: 40),
            child:  new Text(status_label,style: TextStyle(fontSize: 30),),
          ),
          new Container(
            child: Image.asset(image_src),
          ),

          new Container(
          margin: const EdgeInsets.only(bottom: 40),
          child:  new Text("$percentage_label %",style: TextStyle(fontSize: 30),),
          ),
        ],
      )
      ,
    );
  }
}