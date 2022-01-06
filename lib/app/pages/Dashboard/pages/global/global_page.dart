import 'package:flutter/material.dart';

import 'package:ranked/api/domain/entities/global/games.dart';
import 'package:ranked/api/domain/entities/user.dart';

import 'package:ranked/app/pages/Dashboard/pages/widgets/gamelist.dart';
import 'package:ranked/app/pages/Dashboard/pages/widgets/header.dart';

class GlobalPage extends StatelessWidget {
  final User usuario;
  final bool? isGlobal;
  final List<GamesLine> games;
  const GlobalPage({Key? key, required this.usuario, this.isGlobal = true, required this.games}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                alignment: Alignment.center,
                child: HeaderWidget(usuario: usuario),
              ),
            ),
            Expanded(
              flex: 6,
              child: GamesList(games: games),
            ),
          ],
        ),
      ),
    );
  }
}
