import 'package:easy_to_call/app/data/models/contact.dart';
import 'package:easy_to_call/app/modules/add_contact/controllers/add_contact_controller.dart';
import 'package:easy_to_call/app/modules/show_all_contacts/controllers/show_all_contacts_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeController extends GetxController {
  //
  final ShowAllContactsController addContactController =
      Get.find<ShowAllContactsController>();

  final FlutterTts tts = FlutterTts();

  @override
  void onInit() {
    super.onInit();
    setLanguageToHindi();
    addContactController.loadContacts();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> setLanguageToHindi() async {
    bool isAvailable = await tts.isLanguageAvailable("hi-IN");
    if (isAvailable) {
      await tts.setLanguage("hi-IN");
    } else {}
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
