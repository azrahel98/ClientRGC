import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:ranked/api/domain/entities/user.dart';

class HeaderWidget extends StatelessWidget {
  final User usuario;
  const HeaderWidget({Key? key, required this.usuario}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height / 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Flexible(
            flex: 4,
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: ClipOval(
                  child: Image.network(usuario.profileLink!),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: AutoSizeText(
              usuario.nickname!,
              style: context.theme.textTheme.headline2!.copyWith(color: context.theme.colorScheme.primary),
            ),
          ),
        ],
      ),
    );
  }
}
