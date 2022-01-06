import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:ranked/api/repositories/login.dart';
import 'package:ranked/app/settings/pages.dart';

class LoginController extends GetxController with StateMixin {
  LoginRepository login;
  LoginController({required this.login});
  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();

  @override
  void onInit() async {
    change(null, status: RxStatus.success());
    super.onInit();
  }

  void logIn() async {
    try {
      change(null, status: RxStatus.loading());

      await login.login(user.text.toString(), pass.text.toString());
      Get.offAndToNamed(Routes.DASHBOARD);
    } catch (e) {
      log(e.toString());
      change(null, status: RxStatus.success());
    }
  }
}
