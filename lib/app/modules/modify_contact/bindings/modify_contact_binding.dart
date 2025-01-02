import 'package:get/get.dart';

import '../controllers/modify_contact_controller.dart';

class ModifyContactBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ModifyContactController>(
      () => ModifyContactController(),
    );
  }
}
