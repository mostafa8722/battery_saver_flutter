
  import 'package:flutter/material.dart';

import 'components/HomeBody.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Battery Saver By Flutter",style: TextStyle(color: Colors.white),),

      ),
      body: HomeBody(),
    );
  }

}