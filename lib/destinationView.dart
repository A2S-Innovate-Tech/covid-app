import 'package:covid_helpline_app/Admin.dart';
import 'package:covid_helpline_app/admin_panel/admin_page.dart';
import 'package:covid_helpline_app/bottom_navigation.dart';
import 'package:covid_helpline_app/emergency.dart';
import 'package:covid_helpline_app/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DestinationView extends StatefulWidget {
  @override
  _DestinationViewState createState() => _DestinationViewState();
}

class _DestinationViewState extends State<DestinationView>
    with SingleTickerProviderStateMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // int _currentIndex = 0;
  bool checkSignIn = false;
  final tabs = [
    HomePage(),
    Emergency(),
    Admin(),
  ];

  @override
  void initState() {
    if (_auth.currentUser != null)
      setState(() {
        checkSignIn = true;
      });
    else {
      setState(() {
        checkSignIn = false;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home)),
          BottomNavigationBarItem(icon: Icon(Icons.add_moderator)),
          BottomNavigationBarItem(icon: Icon(Icons.person)),
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return CupertinoTabView(
              builder: (context) {
                return CupertinoPageScaffold(child: HomePage());
              },
            );
          case 1:
            return CupertinoTabView(
              builder: (context) {
                return CupertinoPageScaffold(child: Emergency());
              },
            );
          case 2:
            return CupertinoTabView(
              builder: (context) {
                return index == 2 && checkSignIn
                    ? CupertinoPageScaffold(child: AdminPage())
                    : CupertinoPageScaffold(child: Admin());
              },
            );
          default:
            return CupertinoTabView(
              builder: (context) {
                return CupertinoPageScaffold(child: HomePage());
              },
            );
        }
      },
    );
    //   Scaffold(
    //   bottomNavigationBar: BottomNavigationBar(
    //     currentIndex: _currentIndex,
    //     onTap: (int index) {
    //       setState(() {
    //         _currentIndex = index;
    //       });
    //     },
    //     items: allDestinations.map((Destination destination) {
    //       return BottomNavigationBarItem(
    //         icon: Icon(destination.icon),
    //         backgroundColor: destination.color,
    //         label: destination.title,
    //       );
    //     }).toList(),
    //   ),
    //   body: SafeArea(
    //       child: _currentIndex == 2 && checkSignIn
    //           ? AdminPage()
    //           : tabs[_currentIndex]),
    // );
  }
}
