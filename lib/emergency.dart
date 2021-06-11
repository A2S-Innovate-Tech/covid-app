import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_helpline_app/Message.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class Emergency extends StatefulWidget {
  @override
  _EmergencyState createState() => _EmergencyState();
}

class _EmergencyState extends State<Emergency> {
  void customLaunch(command) async {
    if (await UrlLauncher.canLaunch(command))
      await UrlLauncher.launch(command);
    else
      print('Can\'t launch command');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Emergency Contacts',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                // decoration: TextDecoration.underline,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.indigoAccent,
            elevation: 0.0,
          ),
          body: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('contact').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: const Text('loading'),
                );
              } else if (snapshot.hasData &&
                  (snapshot.data.size == 0 || snapshot.data.size == null)) {
                return Center(
                  child: Text("No event live now."),
                );
              } else {
                return ListView(
                  children: snapshot.data.docs.map((document) {
                    return Card(
                      child: Container(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 180,
                              child: Text(
                                document['name'],
                                style: TextStyle(fontSize: 20),
                                maxLines: 10,
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                customLaunch('tel:+91${document["phone"]}');
                              },
                              icon: Icon(
                                Icons.call,
                                color: Colors.teal,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => Message()));
                              },
                              icon: Icon(
                                Icons.message,
                                color: Colors.teal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
              }
            },
          )),
    );
  }
}
