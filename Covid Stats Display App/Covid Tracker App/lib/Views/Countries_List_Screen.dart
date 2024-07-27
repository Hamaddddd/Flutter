import 'package:flutter/material.dart';

class Countries_list_Screen extends StatefulWidget {
  const Countries_list_Screen({Key? key}) : super(key: key);

  @override
  State<Countries_list_Screen> createState() => _Countries_list_ScreenState();
}

class _Countries_list_ScreenState extends State<Countries_list_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 26, 25, 27),

      appBar: AppBar(
        //just for the back screen arrow, app bar is used
        backgroundColor: Color.fromARGB(255, 26, 25, 27),
      ),

      body: SafeArea(
        child: Column(
          children: [
            FutureBuilder(
                future: ,
                builder: (context, snapshot){

                })
          ],
        ),
      ),


    );
  }
}
