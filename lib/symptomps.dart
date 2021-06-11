import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget makeItem(image, title) {
  return AspectRatio(
    aspectRatio: 1 / 1,
    child: Container(
        margin: EdgeInsets.only(right: 15),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                      begin: Alignment.bottomRight,
                      colors: [
                        Colors.indigo.withOpacity(.8),
                        Colors.black.withOpacity(.2)
                      ])),
              child: SvgPicture.asset(
                image,
                fit: BoxFit.fitWidth,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                title,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        )),
  );
}

class Symptomps extends StatelessWidget {
  final String image;
  final String title;
  Symptomps({this.image, this.title});
  @override
  Widget build(BuildContext context) {
    return makeItem(image, title);
  }
}
