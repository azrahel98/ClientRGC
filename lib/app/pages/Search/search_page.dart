import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:ranked/app/pages/Search/controller.dart';
import 'package:ranked/app/pages/Search/widgets/chats.dart';
import 'package:ranked/app/pages/Search/widgets/header.dart';
import 'package:ranked/app/pages/Search/widgets/players.dart';
import 'package:ranked/app/widgets/loading.dart';

class SearchPage extends GetView<SearchController> {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 20),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: HeaderSearch(
                game: controller.gameSelect!,
              ),
            ),
            Expanded(
              flex: 10,
              child: controller.obx(
                  (state) => Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Flexible(
                                  child: GamesCuadro(
                                    users: state!.sublist(0, 5),
                                  ),
                                ),
                                const SizedBox(height: 15),
                                Flexible(
                                  child: GamesCuadro(
                                    users: state.sublist(5, 10),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Obx(
                              () => !controller.showChat.value
                                  ? Container(
                                      alignment: Alignment.center,
                                      child: ElevatedButton(
                                        child: const Text('Ver Chat'),
                                        onPressed: () {
                                          controller.getChats();
                                        },
                                      ),
                                    )
                                  : ChatInGameWidget(chats: controller.chats),
                            ),
                          ),
                        ],
                      ),
                  onLoading: const LoadingWidget()),
            ),
          ],
        ),
      ),
    );
  }
}
