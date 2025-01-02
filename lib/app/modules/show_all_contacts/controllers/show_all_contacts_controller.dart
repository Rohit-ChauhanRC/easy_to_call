import 'dart:convert';
import 'dart:io';

import 'package:easy_to_call/app/data/models/contact.dart';
import 'package:get/get.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class ShowAllContactsController extends GetxController {
  //

  var contacts = <Contact>[].obs;

  final FlutterTts tts = FlutterTts();

  @override
  void onInit() async {
    checkPermissions();

    super.onInit();
    setLanguageToHindi();
    loadContacts();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> checkPermissions() async {
    // Check and request storage permission
    await Permission.manageExternalStorage.request();
    await Permission.phone.request();
    await Permission.storage.request();

    // if (await Permission.storage.isDenied) {
    // }

    // Check and request manage external storage permission (Android 11+)
    // if (await Permission.manageExternalStorage.isDenied) {
    //   if (await Permission.manageExternalStorage.request().isGranted) {
    //     print("Manage External Storage permission granted.");
    //   } else {
    //     print("Manage External Storage permission denied.");
    //   }
    // }

    // // Handle permanent denial for storage permission
    // if (await Permission.storage.isPermanentlyDenied) {
    //   print("Storage permission permanently denied. Redirecting to settings.");
    //   openAppSettings();
    // }

    // // Handle permanent denial for manage external storage permission
    // if (await Permission.manageExternalStorage.isPermanentlyDenied) {
    //   print(
    //       "Manage External Storage permission permanently denied. Redirecting to settings.");
    //   openAppSettings();
    // }
  }

  Future<void> setLanguageToHindi() async {
    // Check if Hindi language is available
    bool isAvailable = await tts.isLanguageAvailable("hi-IN");
    if (isAvailable) {
      // Set the language to Hindi
      await tts.setLanguage("hi-IN");
      print("Language set to Hindi.");
    } else {
      print("Hindi language is not available.");
    }
  }

  Future<void> loadContacts() async {
    final filePath = await getFilePath();
    final file = File(filePath);

    if (file.existsSync()) {
      final String jsonString = file.readAsStringSync();
      final List<dynamic> jsonData = json.decode(jsonString);
      contacts.value = jsonData.map((e) => Contact.fromJson(e)).toList();
    }
  }

  Future<void> saveContactsToFile() async {
    final filePath = await getFilePath();
    final file = File(filePath);
    final jsonString = json.encode(contacts.map((e) => e.toJson()).toList());
    await file.writeAsString(jsonString);
  }

  Future<String> getFilePath() async {
    final directory = Directory("/storage/emulated/0/Download");
    return '${directory.path}/contacts.json';
  }

  Future<void> updateContact(
      int index, String name, String phone, String profilePhoto) async {
    contacts[index] =
        Contact(name: name, phone: phone, profilePhoto: profilePhoto);
    await saveContactsToFile();
  }

  Future<void> deleteContact(int index) async {
    contacts.removeAt(index);
    await saveContactsToFile();
  }

  Future<void> addContact(
      String name, String phone, String profilePhoto) async {
    final newContact =
        Contact(name: name, phone: phone, profilePhoto: profilePhoto);
    contacts.add(newContact);
    await saveContactsToFile();
  }

  Future<void> speakAndCall(Contact contact) async {
    await tts.speak("Calling ${contact.name}");

    tts.setCompletionHandler(() async {
      if (await Permission.phone.request().isGranted) {
        final Uri phoneUri = Uri(scheme: 'tel', path: contact.phone);

        if (await canLaunchUrl(phoneUri)) {
          await launchUrl(phoneUri);
        } else {
          Get.snackbar("Error", "Could not launch phone call.");
        }
      } else {
        Get.snackbar("Permission Denied",
            "Please grant phone permissions to make a call.");
      }
    });
  }
}
