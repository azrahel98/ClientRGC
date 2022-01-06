import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginInput extends StatelessWidget {
  final Size size;
  final String? hint;
  final IconData? icon;
  final bool? ispassowrd;
  final bool? showpassword;
  final TextEditingController? controller;

  final Function()? onpress;

  const LoginInput({
    Key? key,
    this.hint = 'Hint Text',
    this.showpassword = false,
    this.icon = Icons.dangerous,
    this.controller,
    this.ispassowrd = false,
    this.onpress,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.width / 15),
      decoration: BoxDecoration(
        color: context.theme.colorScheme.surface,
        border: Border.all(color: Colors.transparent),
        borderRadius: BorderRadius.circular(50),
      ),
      child: TextFormField(
        controller: controller,
        style: context.theme.textTheme.bodyText2!
            .copyWith(color: context.theme.colorScheme.primary),
        obscureText: ispassowrd!,
        keyboardType: ispassowrd == false
            ? TextInputType.emailAddress
            : TextInputType.name,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: context.theme.textTheme.bodyText2!
              .copyWith(color: context.theme.colorScheme.primary),
          contentPadding: EdgeInsets.symmetric(horizontal: size.width / 20),
          fillColor: Colors.transparent,
        ),
      ),
    );
  }
}
