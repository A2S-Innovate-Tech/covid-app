import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddEmergencyContacts extends StatefulWidget {
  @override
  _AddEmergencyContactsState createState() => _AddEmergencyContactsState();
}

class _AddEmergencyContactsState extends State<AddEmergencyContacts> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add Emergency Contacts'),
          backgroundColor: Colors.indigoAccent,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Enter Person Name',
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      errorBorder: OutlineInputBorder(),
                    ),
                    validator: (String val) {
                      if (val.isEmpty) {
                        return "Please enter Person name";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _numberController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Enter Number',
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      errorBorder: OutlineInputBorder(),
                    ),
                    validator: (String val) {
                      if (val.isEmpty) {
                        return "Please enter Number";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  OutlinedButton(
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        await FirebaseFirestore.instance
                            .collection('contact')
                            .add({
                          'name': _nameController.text,
                          'phone': _numberController.text,
                        });
                        setState(() {
                          _nameController.clear();
                          _numberController.clear();
                          Fluttertoast.showToast(
                              msg: "Contact Added",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.TOP,
                              backgroundColor: Colors.indigoAccent,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        });
                      }
                    },
                    child: Text(
                      'Add',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
