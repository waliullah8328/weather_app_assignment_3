import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../screens/privacy_policy.dart';


class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.blueGrey,
      child: ListView(
        children: [
          DrawerHeader(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: SizedBox(
                      height: 100,
                      child: Lottie.asset(
                        "assets/animations/weather.json",
                      ))),
              const SizedBox(height: 10),
            ],
          )),
          customListtile(
            Icons.home,
            "H O M E",
            () {
              Navigator.pop(context);
            },
          ),
          customListtile(Icons.privacy_tip, "P O L I C Y ", () {
            Get.to(const PrivacyScreen());
          }),
        ],
      ),
    );
  }
}

Widget customListtile(icon, text, ontap) {
  return InkWell(
    onTap: ontap,
    child: ListTile(
      leading: IconButton(
          onPressed: () {},
          icon: Icon(
            icon,
            color: Colors.white,
          )),
      title: Text(
        text,
        style:
            const TextStyle(fontWeight: FontWeight.w500, color: Colors.white70),
      ),
    ),
  );
}
