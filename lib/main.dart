import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ranked/app/bindings/main.dart';
import 'package:ranked/app/settings/pages.dart';
import 'package:ranked/app/settings/pages_names.dart';
import 'package:ranked/app/theme/theme_controller.dart';

import 'app/theme/theme.dart';

void main() async {
  settings();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themex = Get.put(ThemeController());
    return GetMaterialApp(
      title: 'rankedapp',
      debugShowCheckedModeBanner: false,
      theme: Themes.light,
      getPages: Pages.pages,
      initialRoute: Routes.SPLASH,
      themeMode: ThemeMode.system,
      darkTheme: Themes.dark,
      enableLog: true,
      initialBinding: MainBinding(),
      smartManagement: SmartManagement.full,
    );
  }
}

void settings() {
  SystemChrome.setSystemUIOverlayStyle(
    // ignore: prefer_const_constructors
    SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.black),
  );
}
