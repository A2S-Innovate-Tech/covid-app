import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DeleteUser extends StatefulWidget {
  @override
  _DeleteUserState createState() => _DeleteUserState();
}

class _DeleteUserState extends State<DeleteUser> {
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
          title: Text('Delete User\'s Details'),
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
                  return GestureDetector(
                    onLongPress: () async {
                      showAlertDialog(context, document);
                    },
                    child: Card(
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
                    ),
                  );
                }).toList(),
              );
            }
          },
        ));
  }

  showAlertDialog(BuildContext context, QueryDocumentSnapshot document) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Do you want to delete?"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Cancel")),
              TextButton(
                  onPressed: () async {
                    await FirebaseFirestore.instance
                        .collection('message')
                        .doc(document.id)
                        .delete();
                    Navigator.of(context).pop();
                    showAlertDialog1(context);
                  },
                  child: Text("Delete"))
            ],
          );
        });
  }

  showAlertDialog1(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('User Deleted'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK")),
            ],
          );
        });
  }
}
