import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserDetails extends StatefulWidget {
  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  bool done = false;
  @override
  void initState() {
    done = false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('User\'s Details'),
          backgroundColor: Colors.indigoAccent,
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('message').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: const Text('loading'),
              );
            } else if (snapshot.hasData &&
                (snapshot.data.size == 0 || snapshot.data.size == null)) {
              return Center(
                child: Text("No User Details"),
              );
            } else {
              return ListView(
                children: snapshot.data.docs.map((document) {
                  return Card(
                    child: Container(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Name      : ',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Container(
                                    width: 180,
                                    child: Text(
                                      document['name'],
                                      style: TextStyle(fontSize: 18),
                                      maxLines: 10,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Phone      : ',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Container(
                                    width: 180,
                                    child: Text(
                                      document['phone'],
                                      style: TextStyle(fontSize: 20),
                                      maxLines: 10,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Message : ',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Container(
                                    width: 180,
                                    child: Text(
                                      document['message'],
                                      style: TextStyle(fontSize: 20),
                                      maxLines: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            }
          },
        ));
  }
}
