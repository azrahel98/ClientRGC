import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:ranked/api/domain/entities/global/games.dart';

class HeaderSearch extends StatelessWidget {
  final GamesLine game;
  const HeaderSearch({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.zero,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 1,
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: ClipOval(
                child: Image.network(
                  game.urlPath!,
                  height: MediaQuery.of(context).size.height / 10,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height / 30),
              child: Wrap(
                direction: Axis.horizontal,
                runSpacing: 10,
                spacing: 10,
                alignment: WrapAlignment.spaceAround,
                children: [
                  gameDetails(3, game.hero!, context),
                  gameDetails(4, game.gameId!, context),
                  gameDetails(2, game.gameHost!, context),
                  gameDetails(5, game.duracion!, context),
                  gameDetails(5, game.status!, context),
                  Container(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  //  gameDetails(3, game.hero!, context),
  //           gameDetails(4, game.fechaString(), context),
  //           gameDetails(2, game.duracion!, context),
  //           gameDetails(5, game.status!, context),
  Container gameDetails(int flex, String data, BuildContext context) {
    return Container(
      child: AutoSizeText(
        data,
        style: context.theme.textTheme.subtitle1!.copyWith(
          color: const Color(0xFF8c91A3),
        ),
      ),
    );
  }
}
