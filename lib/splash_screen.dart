import 'dart:async';

import 'package:covid_helpline_app/destinationView.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  final Color backgroundColor = Colors.white;
  final TextStyle styleTextUnderTheLoader = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final splashDelay = 5;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadWidget();
  }

  _loadWidget() async {
    var _duration = Duration(seconds: splashDelay);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => DestinationView()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    flex: 7,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'lib\\assets\\covidaid.png',
                            height: MediaQuery.of(context).size.width,
                            width: MediaQuery.of(context).size.width,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                          ),
                        ],
                      ),
                    )),
                Expanded(
                    child: Column(
                  children: [
                    Container(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Spacer(),
                        Column(
                          children: [
                            Text('Developed by',
                                style:
                                    TextStyle(fontSize: 20, letterSpacing: 2)),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'EduTekZila',
                              style: TextStyle(
                                  color: Color(0xffdf9855),
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Spacer(),
                      ],
                    )
                  ],
                )),
                SizedBox(
                  height: 20,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
