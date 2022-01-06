import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../controller.dart';
import 'input.dart';

class LoginForm extends GetView<LoginController> {
  final Size size;
  const LoginForm({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  child: LoginInput(
                    size: size,
                    hint: 'nickname',
                    controller: controller.user,
                  ),
                ),
                Flexible(
                  child: LoginInput(
                    size: size,
                    ispassowrd: true,
                    hint: 'password',
                    controller: controller.pass,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: controller.obx(
              (state) => Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: ElevatedButton(
                    onPressed: controller.logIn,
                    child: const AutoSizeText(
                      'LOGIN',
                      maxLines: 1,
                    ),
                  ),
                ),
              ),
              onLoading: SpinKitFadingCircle(
                itemBuilder: (_, int index) {
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      color: index.isEven ? Colors.blue : Colors.blue.shade900,
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
