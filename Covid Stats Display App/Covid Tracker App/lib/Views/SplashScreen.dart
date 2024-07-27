import 'dart:async';

import 'package:covid_app/Views/Overall_Stats_Screen.dart';
import 'package:flutter/material.dart';

import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {

  late final AnimationController _controller =
      AnimationController(vsync: this, duration: Duration(seconds: 3))..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(Duration(seconds: 3), () {
      Navigator.push(context,
        MaterialPageRoute(builder: (context) => Overall_Stats_Screen())
      );
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 26, 25, 27),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _controller,
              child: Center(
                child: Container(
                  height: 200,
                  width: 200,
                  child: Image(image: AssetImage("images/virus.png")),
                ),
              ),
              builder: (BuildContext context, Widget? child) {
                return Transform.rotate(
                  angle: _controller.value * 2.0 * math.pi,
                  child: child,
                );
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .2,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Track Covid\n\n Around the World",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,

                ),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
