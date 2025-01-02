import 'dart:io';

import 'package:easy_to_call/app/data/models/contact.dart';
import 'package:easy_to_call/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Contacts"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Get.toNamed(Routes.ADD_CONTACT),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.addContactController.contacts.isEmpty) {
          return Center(child: Text("No contacts found. Add some!"));
        }
        return ListView.builder(
          itemCount: controller.addContactController.contacts.length,
          itemBuilder: (context, index) {
            final Contact contact =
                controller.addContactController.contacts[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: FileImage(File(contact.profilePhoto)),
              ),
              title: Text(contact.name),
              subtitle: Text(contact.phone),
              onTap: () async {
                controller.speakAndCall(contact);
              },
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Get.toNamed(Routes.MODIFY_CONTACT, arguments: [
                        contact,
                        index,
                      ]);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () async {
                      await controller.addContactController
                          .deleteContact(index);
                    },
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
