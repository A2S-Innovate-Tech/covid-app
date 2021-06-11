import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Message extends StatefulWidget {
  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Message'),
        backgroundColor: Colors.indigoAccent,
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 10,
                ),
                CreateTextField(
                  validator: true,
                  title: 'Name',
                  controller: _nameController,
                  type: TextInputType.text,
                ),
                SizedBox(
                  height: 10,
                ),
                CreateTextField(
                  validator: true,
                  title: 'Phone Number',
                  controller: _phoneController,
                  type: TextInputType.number,
                ),
                SizedBox(
                  height: 10,
                ),
                CreateTextField(
                  validator: false,
                  title: 'Message',
                  controller: _messageController,
                  type: TextInputType.text,
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      await FirebaseFirestore.instance
                          .collection('message')
                          .add({
                        'name': _nameController.text,
                        'phone': _phoneController.text,
                        'message': _messageController.text,
                      });
                      setState(() {
                        _nameController.clear();
                        _phoneController.clear();
                        _messageController.clear();

                        Fluttertoast.showToast(
                            msg: "Message sent",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.TOP,
                            backgroundColor: Colors.indigoAccent,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      });
                    }
                  },
                  child: Text(
                    'Send',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  // color: Colors.indigoAccent,
                )
              ],
            ),
          ),
        ),
      )),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _nameController.dispose();
    super.dispose();
  }
}

class CreateTextField extends StatelessWidget {
  final bool validator;
  final String title;
  final TextEditingController controller;
  final TextInputType type;
  CreateTextField({this.validator, this.title, this.controller, this.type});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator == true
          ? (String val) {
              if (val.isEmpty)
                return "Please Enter $title";
              else
                return null;
            }
          : null,
      controller: controller,
      keyboardType: type,
      decoration: InputDecoration(
        labelText: 'Enter $title',
        enabledBorder: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(),
      ),
    );
  }
}
