// ignore_for_file: prefer_final_fields, library_private_types_in_public_api, unused_import, duplicate_import, unnecessary_import, prefer_const_constructors, avoid_print, unused_element

import 'package:app_phone/main.dart';
import 'package:app_phone/phonenumber.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class PhoneNumberInputPage extends StatefulWidget {
  const PhoneNumberInputPage({super.key});

  @override
  _PhoneNumberInputPageState createState() => _PhoneNumberInputPageState();
}

class NameInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String filteredValue = newValue.text.replaceAll(RegExp(r'[^a-zA-Z\s]'), '');

    return TextEditingValue(
      text: filteredValue,
      selection: TextSelection.collapsed(offset: filteredValue.length),
    );
  }
}

final TextEditingController _nameController = TextEditingController();
final TextEditingController _phoneNumberController = TextEditingController();
bool _canSave = false;

class _PhoneNumberInputPageState extends State<PhoneNumberInputPage> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _canSave = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 34, 32, 32),
      appBar: AppBar(
        toolbarHeight: 60,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => add_page()));
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white60,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text(
          'New Contact ',
          style: TextStyle(color: Colors.white60, fontSize: 16),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(36.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 30,
            ),
            TextFormField(
              style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              cursorColor: Color.fromARGB(255, 247, 247, 247),
              decoration: InputDecoration(
                filled: true,
                fillColor: Color.fromARGB(212, 62, 69, 77),
                labelText: 'Name',
                prefixIcon: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                labelStyle: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255), fontSize: 15.0),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintStyle: TextStyle(
                  color: Color.fromARGB(255, 248, 244, 244),
                ),
              ),
              keyboardType: TextInputType.text,
              inputFormatters: [
                LengthLimitingTextInputFormatter(17),
                NameInputFormatter(),
              ],
              onChanged: (value) {
                setState(() {
                  _canSave = value.isNotEmpty &&
                      _phoneNumberController.text.isNotEmpty;
                });
              },
            ),
            SizedBox(
              height: 40.0,
            ),
            TextFormField(
              style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
              cursorColor: Color.fromARGB(255, 247, 247, 247),
              controller: _phoneNumberController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Color.fromARGB(212, 62, 69, 77),
                labelText: ' mobile number',
                prefixIcon: Icon(
                  Icons.phone,
                  color: Colors.white,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                labelStyle: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255), fontSize: 15.0),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintStyle: TextStyle(
                  color: Color.fromARGB(255, 248, 244, 244),
                ),
              ),
              keyboardType: TextInputType.phone,
              onChanged: (value) {
                setState(() {
                  _canSave =
                      value.isNotEmpty && _nameController.text.isNotEmpty;
                });
              },
              inputFormatters: [
                LengthLimitingTextInputFormatter(11),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            TextFormField(
              style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
              cursorColor: Color.fromARGB(255, 247, 247, 247),
              decoration: InputDecoration(
                filled: true,
                fillColor: Color.fromARGB(212, 62, 69, 77),
                labelText: 'Email',
                prefixIcon: Icon(
                  Icons.email,
                  color: Colors.white,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                labelStyle: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 15.0,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintStyle: TextStyle(
                  color: Color.fromARGB(255, 248, 244, 244),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
              onChanged: (value) {
                setState(() {
                  _canSave = _isValidEmail(value);
                });
              },
            ),
            SizedBox(height: 65),
            ElevatedButton(
              onPressed: () {
                if (_canSave) {
                  print('Entered Email: ${_emailController.text}');
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                          'Invalid Email , Name',
                          style: TextStyle(color: Colors.black),
                        ),
                        content: Text(
                          '''Please enter  Valid email address  Number!!!''',
                          style: TextStyle(color: Colors.black),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      FlutterContactsExample(),
                                ),
                              );

                              // Navigator.of(context).pop());
                            },
                            child: Text(
                              'OK',
                              style: TextStyle(
                                  color: Colors.black,

                                  //  backgroundColor: Colors.wh,
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Text(
                'Save',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

bool _isValidEmail(String email) {
  String emailRegex = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  RegExp regex = RegExp(emailRegex);
  return regex.hasMatch(email);
}
