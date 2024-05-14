// ignore_for_file: depend_on_referenced_packages, unused_import, duplicate_ignore, duplicate_import, unnecessary_import, prefer_const_constructors, curly_braces_in_flow_control_structures, use_build_context_synchronously, library_private_types_in_public_api, prefer_const_constructors_in_immutables, unused_field, must_be_immutable, no_leading_underscores_for_local_identifiers, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, deprecated_member_use
// ignore: unused_import
import 'package:app_phone/call_page.dart';
import 'package:app_phone/phonenumber.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import 'package:app_phone/page_servar.dart';
import 'package:flutter/foundation.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:flutter/services.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:photo_manager/photo_manager.dart';
import 'package:flutter/widgets.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
// ignore: unused_import
import 'package:sentry/sentry.dart';

// See installation notes below regarding AndroidManifest.xml and Info.plist
import 'package:flutter_contacts/flutter_contacts.dart';

// Request contact permission
import 'package:image_picker/image_picker.dart';

import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

void main() => runApp(
      const FlutterContactsExample(),
    );

class FlutterContactsExample extends StatefulWidget {
  const FlutterContactsExample({super.key});

  @override
  _FlutterContactsExampleState createState() => _FlutterContactsExampleState();
}

class _FlutterContactsExampleState extends State<FlutterContactsExample> {
  List<Contact>? _contacts;
  bool _permissionDenied = false;

  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  Future _fetchContacts() async {
    if (!await FlutterContacts.requestPermission(readonly: true)) {
      setState(() => _permissionDenied = true);
    } else {
      final contacts = await FlutterContacts.getContacts();
      setState(() => _contacts = contacts);
    }
  }

  @override
  Widget build(BuildContext context) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
              title: const Text('contacts'),
              toolbarHeight: 33.0,
              titleTextStyle: TextStyle(
                  color: const Color.fromARGB(255, 9, 9, 9), fontSize: 22),
              centerTitle: true,
              backgroundColor: Colors.blue[100]),
          backgroundColor: Color.fromRGBO(222, 222, 222, 0.984),
          body: _body(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.off(PhoneNumberInputPage());
              // _launchURL();
            },
            backgroundColor: Color.fromARGB(220, 117, 178, 213),
            child: Icon(
              Icons.add,
              color: Colors.black,
              size: 33,
            ),
          ),
          /////////////////main.dart
          bottomNavigationBar: BottomAppBar(
              height: 70,
              color: Colors.blue[100],
              shape: CircularNotchedRectangle(),
              child: Container(
                  height: 30,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 23.0, vertical: 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Icon(
                          Icons.star_border_purple500,
                          size: 30.0,
                          color: const Color.fromARGB(255, 7, 7, 7),
                        ),
                        Icon(
                          Icons.add_call,
                          size: 30.0,
                          color: const Color.fromARGB(255, 1, 1, 1),
                        ),
                        Icon(
                          Icons.settings,
                          size: 30.0,
                          color: const Color.fromARGB(255, 5, 5, 5),
                        ),
                      ],
                    ),
                  ))),
        ),
      );

  Widget _body() {
    if (_permissionDenied)
      return const Center(
        child: Text('Permission denied'),
      );
    if (_contacts == null)
      return const Center(
        child: CircularProgressIndicator(),
      );

    return ListView.builder(
      itemCount: _contacts!.length,
      itemBuilder: (context, i) => ListTile(
          title: Text(_contacts![i].displayName),
          onTap: () async {
            final fullContact =
                await FlutterContacts.getContact(_contacts![i].id);
            await Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => ContactPage(fullContact!)));
          }),
    );
  }
}

class ContactPage extends StatelessWidget {
  final Contact contact;

  ContactPage(this.contact, {super.key});
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Color.fromARGB(172, 0, 0, 0),
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 2.0,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              contact;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => add_page(),
                  ));
            },
            icon: Icon(
              Icons.arrow_back,
              color: Color.fromARGB(255, 180, 180, 180),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.star),
              color: Color.fromARGB(255, 192, 190, 190),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_vert,
              ),
              color: Color.fromARGB(255, 171, 170, 170),
            ),
          ],
          title: Text(
            contact.displayName,
            style: TextStyle(color: const Color.fromARGB(255, 180, 180, 180)),
          ),
        ),

        body: Column(
          children: [
            SizedBox(
              height: 44.0,
            ),
            CircleAvatar(
              maxRadius: 60,
              backgroundColor: Colors.greenAccent,
              child: IconButton(
                  onPressed: () async {
                    final ImagePicker _picker = ImagePicker();
                    final XFile? image = await _picker.pickImage(
                      source: ImageSource.gallery,
                    );
                    if (image != null) {
                      // Use the selected image (XFile) as needed
                      if (kDebugMode) {
                        print('Image selected: ${image.path}');
                      }
                    }
                  },
                  icon: Icon(Icons.text_fields)),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Container(
                        height: 100.0,
                        width: 399.0,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(40.0),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 41, 42, 41)
                                  .withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 2,
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'Phone number: ${contact.phones.isNotEmpty ? contact.phones.first.number : '(none)'}',
                            style: TextStyle(
                              color: Color.fromARGB(255, 191, 191, 191),
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.blue[100],
                          radius: 28,
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.textsms,
                              size: 28,
                              color: Color.fromARGB(255, 27, 28, 29),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          //  height: 20,
                          width: 39,
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.blue[100],
                          radius: 28,
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.call,
                              size: 28,
                              color: Color.fromARGB(255, 27, 28, 29),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 42,
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.blue[100],
                          radius: 29,
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.videocam,
                              size: 28,
                              color: Color.fromARGB(255, 27, 28, 29),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],

              // // Padding(
              //   padding: const EdgeInsets.all(14.0),
              //   child: Container(
              //     height: 86.0,
              //     width: 399.0,
              //     decoration: BoxDecoration(
              //       color: Colors.black,

              //       borderRadius: BorderRadius.circular(
              //           10.0), // Optional: Apply border radius
              //       boxShadow: [
              //         BoxShadow(
              //           color: Colors.grey.withOpacity(0.5),

              //           spreadRadius: 3,
              //           blurRadius: 7,
              //           offset: Offset(0, 3), // changes position of shadow
              //         ),
              //       ],
              //     ),
              //     child: Center(

              //     ),
              //   ),
              // ),
            ),
            SizedBox(
              height: 49,
            ),
            Divider(
              thickness: 2.0,
            ),
          ],
        ),

        // Text('First name: ${contact.name.first}'),
        //   Text(
        // /      'Email address: ${contact.emails.isNotEmpty ? contact.emails.first.address : '(none)'}'),
      );
}

// Method to launch the URL for adding a phone number

// void _launchURL() async {
//   const url = 'tel:0'; // Replace with the desired phone number
//   if (await canLaunch(url)) {
//     await launch(url);
//   } else {
//     throw 'Could not launch $url';
//   }
//}
