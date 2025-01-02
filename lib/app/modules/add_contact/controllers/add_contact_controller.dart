import 'dart:io';

import 'package:easy_to_call/app/modules/show_all_contacts/controllers/show_all_contacts_controller.dart';
import 'package:easy_to_call/app/utils/utils.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddContactController extends GetxController {
  //

  final ShowAllContactsController addContactController =
      Get.put(ShowAllContactsController());

  final ImagePicker picker = ImagePicker();

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

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    _profileName.close();
    _mobileNumber.close();
    _image.close();
    profileNameController.clear();
  }

  Future<String?> pickImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    return image?.path;
  }

  void selectImage() async {
    Utils.showImagePicker(onGetImage: (img) async {
      if (img != null) {
        // image = img;
        final String fileName = img.name;
        final File pickedImage = File(img.path);

        final directory = Directory("/storage/emulated/0/Download");

        image = await File('${directory.path}/$fileName')
            .writeAsBytes(await pickedImage.readAsBytes());
      }
    });
  }
}
