import 'package:easy_to_call/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.green.withOpacity(0.7),
      elevation: 10,
      child: Container(
        margin: const EdgeInsets.only(top: 50),
        child: ListTile(
          title: const Text(
            "Edit Contacts",
            style: TextStyle(
              color: Colors.white,
              fontSize: 26,
            ),
          ),
          leading: const Icon(
            Icons.notifications,
            color: Colors.white,
            size: 40,
          ),
          onTap: () {
            Get.toNamed(Routes.HOME);
          },
        ),
      ),
    );
  }
}
