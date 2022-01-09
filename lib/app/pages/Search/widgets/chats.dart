import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:ranked/api/domain/entities/chats/chat.dart';

class ChatInGameWidget extends StatelessWidget {
  final List<ChatinGame> chats;
  const ChatInGameWidget({Key? key, required this.chats}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 50, vertical: 10),
      child: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) => Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 3),
          margin: const EdgeInsets.symmetric(vertical: 3),
          child: getlineChat(
            chats[index],
          ),
        ),
      ),
    );
  }

  Container getlineChat(ChatinGame chat) {
    return Container(
      padding: EdgeInsets.zero,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
            flex: 1,
            child: SizedBox(
              width: double.infinity,
              child: AutoSizeText(
                chat.time,
                maxLines: 1,
                style: Get.theme.textTheme.subtitle1!.copyWith(fontSize: 10, color: Colors.white.withOpacity(0.8)),
              ),
            ),
          ),
          const SizedBox(width: 5),
          Flexible(
            flex: 1,
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: ischatStatus(chat.chatTipe)),
            ),
          ),
          const SizedBox(width: 5),
          Flexible(
            flex: 4,
            child: SizedBox(
              width: double.infinity,
              child: AutoSizeText(
                chat.nickname,
                style: Get.theme.textTheme.headline5!.copyWith(fontSize: 12),
                maxLines: 1,
              ),
            ),
          ),
          Flexible(
            flex: 6,
            child: SizedBox(
              width: double.infinity,
              child: AutoSizeText(
                chat.message,
                style: Get.theme.textTheme.subtitle1!.copyWith(fontSize: 10, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color ischatStatus(String text) {
    switch (text) {
      case 'SENTINEL':
        return Colors.green.withOpacity(0.4);
        ;
      case 'SCOURGE':
        return Colors.red.withOpacity(0.4);
      default:
        return Colors.blue.withOpacity(0.6);
        ;
    }
  }
}
