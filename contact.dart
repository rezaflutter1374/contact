// ignore_for_file: use_super_parameters, unnecessary_import, duplicate_import

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ContactPage extends GetView<ContactPageController> {
  final Contact contact;

  const ContactPage(this.contact, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(172, 0, 0, 0),
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 2.0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Color.fromARGB(255, 180, 180, 180),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Handle star button pressed
            },
            icon: const Icon(Icons.star),
            color: const Color.fromARGB(255, 192, 190, 190),
          ),
          IconButton(
            onPressed: () {
              // Handle more options button pressed
            },
            icon: const Icon(Icons.more_vert),
            color: const Color.fromARGB(255, 171, 170, 170),
          ),
        ],
        title: Text(
          contact.displayName,
          style: const TextStyle(color: Color.fromARGB(255, 180, 180, 180)),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 44.0),
          CircleAvatar(
            maxRadius: 60,
            backgroundColor: Colors.greenAccent,
            child: IconButton(
              onPressed: () async {
                final XFile? image = await controller.pickImage();
                if (image != null && Get.context != null) {
                  debugPrint('Image selected: ${image.path}');
                }
              },
              icon: const Icon(Icons.text_fields),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Container(
                  height: 100.0,
                  width: 399.0,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(40.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(255, 41, 42, 41),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Obx(() => Text(
                          'Phone number: ${controller.phoneNumber}',
                          style: const TextStyle(
                            color: Color.fromARGB(255, 191, 191, 191),
                            fontSize: 18.0,
                          ),
                        )),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 49),
          const Divider(thickness: 2.0),
        ],
      ),
    );
  }
}

class ContactPageController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  RxString phoneNumber = ''.obs;

  Future<XFile?> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    return image;
  }
}
