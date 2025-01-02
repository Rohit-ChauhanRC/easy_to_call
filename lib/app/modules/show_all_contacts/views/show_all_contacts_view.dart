import 'dart:io';

import 'package:easy_to_call/app/data/models/contact.dart';
import 'package:easy_to_call/app/routes/app_pages.dart';
import 'package:easy_to_call/app/utils/app_drawer.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/show_all_contacts_controller.dart';

class ShowAllContactsView extends GetView<ShowAllContactsController> {
  const ShowAllContactsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text("Contacts"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Get.toNamed(Routes.ADD_CONTACT),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.contacts.isEmpty) {
          return Center(child: Text("No contacts found. Add some!"));
        }
        return ListView.builder(
          itemCount: controller.contacts.length,
          itemBuilder: (context, index) {
            final Contact contact = controller.contacts[index];
            return InkWell(
              onTap: () {
                controller.speakAndCall(contact);
              },
              child: Card(
                elevation: 10,
                shadowColor: Colors.green,
                margin: const EdgeInsets.all(20),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: FileImage(File(contact.profilePhoto)),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        Text(contact.name),
                        Text(contact.phone),
                      ],
                    ),
                  ],
                ),
                // subtitle:
              ),
            );
          },
        );
      }),
    );
  }
}
