import 'package:get/get.dart';

import '../modules/add_contact/bindings/add_contact_binding.dart';
import '../modules/add_contact/views/add_contact_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/modify_contact/bindings/modify_contact_binding.dart';
import '../modules/modify_contact/views/modify_contact_view.dart';
import '../modules/show_all_contacts/bindings/show_all_contacts_binding.dart';
import '../modules/show_all_contacts/views/show_all_contacts_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SHOW_ALL_CONTACTS;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ADD_CONTACT,
      page: () => const AddContactView(),
      binding: AddContactBinding(),
    ),
    GetPage(
      name: _Paths.MODIFY_CONTACT,
      page: () => const ModifyContactView(),
      binding: ModifyContactBinding(),
    ),
    GetPage(
      name: _Paths.SHOW_ALL_CONTACTS,
      page: () => const ShowAllContactsView(),
      binding: ShowAllContactsBinding(),
    ),
  ];
}
