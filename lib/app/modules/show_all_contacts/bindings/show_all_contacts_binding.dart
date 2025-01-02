import 'package:get/get.dart';

import '../controllers/show_all_contacts_controller.dart';

class ShowAllContactsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ShowAllContactsController>(
      ShowAllContactsController(),
    );
  }
}
