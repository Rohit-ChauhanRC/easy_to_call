import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/modify_contact_controller.dart';

class ModifyContactView extends GetView<ModifyContactController> {
  const ModifyContactView({super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Scaffold(
        appBar: AppBar(title: Text("Add Contact")),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Obx(() => GestureDetector(
                    onTap: () async {
                      controller.selectImage();
                    },
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: controller.image?.path != null
                          ? FileImage(File(controller.image!.path))
                          : controller.profilePhotoPath!.isNotEmpty
                              ? FileImage(File(controller.profilePhotoPath!))
                              : null,
                      child: controller.image?.path == null &&
                              controller.profilePhotoPath!.isEmpty
                          ? Icon(Icons.add_a_photo, size: 50)
                          : null,
                    ),
                  )),
              SizedBox(height: 16),
              TextFormField(
                controller: controller.profileNameController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: (v) => controller.profileName = v,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  hintText: 'Name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                ),
                cursorColor: Colors.grey,
                validator: (value) =>
                    value!.isEmpty ? "Please enter name!" : null,
                keyboardType: TextInputType.name,
              ),
              TextFormField(
                controller: controller.phoneController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: (v) => controller.mobileNumber = v,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.contacts),
                  hintText: 'Phone',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                ),
                cursorColor: Colors.grey,
                validator: (value) =>
                    value!.isEmpty ? "Please enter mobile no.!" : null,
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (controller.profilePhotoPath != null &&
                      controller.profileNameController.text.isNotEmpty &&
                      controller.phoneController.text.isNotEmpty) {
                    controller.addContactController.updateContact(
                      controller.index,
                      controller.profileNameController.text,
                      controller.phoneController.text,
                      controller.profilePhotoPath!,
                    );
                    Get.back();
                  } else {
                    Get.snackbar(
                        "Error", "Please fill all fields and select a photo.");
                  }
                },
                child: Text("Save Contact"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
