import 'dart:io';

import 'package:easy_to_call/app/data/models/contact.dart';
import 'package:easy_to_call/app/modules/show_all_contacts/controllers/show_all_contacts_controller.dart';
import 'package:easy_to_call/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ModifyContactController extends GetxController {
  //
  final ShowAllContactsController addContactController =
      Get.find<ShowAllContactsController>();
  final Rx<Contact> contact =
      Contact(name: '', phone: "", profilePhoto: "").obs;

  final RxString _profileName = ''.obs;
  String get profileName => _profileName.value;
  set profileName(String pr) => _profileName.value = pr;

  final Rx<File?> _image = Rx<File?>(null);
  File? get image => _image.value;
  set image(File? img) => _image.value = img;

  final RxString _mobileNumber = ''.obs;
  String get mobileNumber => _mobileNumber.value;
  set mobileNumber(String no) => _mobileNumber.value = no;

  final TextEditingController profileNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  String? profilePhotoPath;

  late int index;

  @override
  void onInit() {
    super.onInit();
    contact.value = Get.arguments[0];
    profileNameController.text = contact.value.name;
    phoneController.text = contact.value.phone;
    profilePhotoPath = contact.value.profilePhoto;
    index = Get.arguments[1];
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void selectImage() async {
    Utils.showImagePicker(onGetImage: (img) {
      if (img != null) {
        image = File(img.path);
        profilePhotoPath = img.path;
      }
    });
  }
}
