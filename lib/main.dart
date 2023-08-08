import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import 'core/network_controller.dart';
import 'ui/user_list/user_list_page.dart';
import 'core/blinding.dart';

void main() {
  runApp(const MyApp());
  Get.put<NetworkController>(NetworkController(),permanent:true);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: const UserListPage(),
      getPages: [
        GetPage(
            name: '/user_list_page',
            page: () =>  const UserListPage(),
            binding: DependenciesBinding()
        ),
      ],
    );
  }
}