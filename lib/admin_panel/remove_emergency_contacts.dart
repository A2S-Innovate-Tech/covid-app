import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RemoveEmergencyContacts extends StatefulWidget {
  @override
  _RemoveEmergencyContactsState createState() =>
      _RemoveEmergencyContactsState();
}

class _RemoveEmergencyContactsState extends State<RemoveEmergencyContacts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Remove Emergency Contacts'),
        backgroundColor: Colors.indigoAccent,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('contact').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: const Text('loading'),
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
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                document['name'],
                                style: TextStyle(fontSize: 20),
                                maxLines: 10,
                              ),
                            ),
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
      ),
    );
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
                        .collection('contact')
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
            title: Text('Contact Deleted'),
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
