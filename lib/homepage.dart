import 'package:covid_helpline_app/bottom_navigation.dart';
import 'package:covid_helpline_app/symptomps.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  final Destination destination;
  const HomePage({Key key, this.destination}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipPath(
                clipper: MyClipper(),
                child: Container(
                  height: 350,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color(0xFF3383CD),
                        Color(0xFF11249F),
                      ],
                    ),
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          padding: EdgeInsets.only(top: 50),
                          child: SvgPicture.asset(
                            'lib\\assets\\bacteria.svg',
                            alignment: Alignment.topRight,
                            fit: BoxFit.fitHeight,
                          ),
                          width: double.infinity,
                          height: 320,
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          padding: EdgeInsets.only(top: 50),
                          child: SvgPicture.asset(
                            'lib\\assets\\doctor.svg',
                            alignment: Alignment.topCenter,
                            fit: BoxFit.cover,
                          ),
                          width: 250,
                          height: 320,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Symptoms',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      size: 20,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: 200,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Symptomps(
                          image: 'lib\\assets\\cough.svg', title: 'Dry Cough'),
                      Symptomps(
                          image: 'lib\\assets\\fever.svg', title: 'Fever'),
                      Symptomps(
                          image: 'lib\\assets\\dizziness.svg',
                          title: 'Headache'),
                      Symptomps(
                          image: 'lib\\assets\\difficulty-breathing.svg',
                          title: 'Difficulty Breath'),
                      Symptomps(
                          image: 'lib\\assets\\loss-of-sense-of-taste.svg',
                          title: 'Loss of Taste'),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Precautions',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      size: 20,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: 200,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Symptomps(
                          image: 'lib\\assets\\hand-wash.svg',
                          title: 'Wash Your Hand'),
                      Symptomps(
                          image: 'lib\\assets\\wear_mask.svg',
                          title: 'Wear Mask'),
                      Symptomps(
                          image: 'lib\\assets\\do-not-go-out.svg',
                          title: 'Don\'t go out'),
                      Symptomps(
                          image: 'lib\\assets\\social-distancing.svg',
                          title: 'Social Distancing'),
                      Symptomps(
                          image: 'lib\\assets\\liquid-soap.svg',
                          title: 'Sanitize'),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 70,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
