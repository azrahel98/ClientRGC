import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  final _box = GetStorage();
  final key = 'isday';
  bool? isdark;

  ThemeMode get themeMode =>
      isdark == null || false ? ThemeMode.light : ThemeMode.dark;

  @override
  void onInit() async {
    await _box.writeIfNull('isday', 0);
    if (_box.read(key) == 1) Get.changeThemeMode(ThemeMode.dark);
    if (_box.read(key) != 1) Get.changeThemeMode(ThemeMode.light);
    Get.changeThemeMode(ThemeMode.system);
    super.onInit();
  }

  void changeTheme() async {
    Get.changeThemeMode(
        themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark);
  }
}
