import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        top: true,
        child: Center(
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 14,
            ),
            decoration: BoxDecoration(
              color: context.theme.colorScheme.background,
              borderRadius: BorderRadius.circular(50),
            ),
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 1.4,
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.only(top: size.height / 20),
                    child: AutoSizeText(
                      'Bienvenido !!',
                      maxLines: 2,
                      maxFontSize: 40,
                      minFontSize: 35,
                      style: context.theme.textTheme.headline1!
                          .copyWith(color: context.theme.colorScheme.primary),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: LoginForm(
                    size: size,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
