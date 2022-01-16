import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ranked/api/domain/entities/global/games.dart';
import 'package:ranked/app/settings/pages.dart';

class GamesList extends StatelessWidget {
  final List<GamesLine> games;
  final bool? isDynamic;
  final Function close;

  const GamesList({Key? key, required this.games, this.isDynamic = false, required this.close}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
      ),
      child: ScrollConfiguration(
        behavior: const ScrollBehavior(androidOverscrollIndicator: AndroidOverscrollIndicator.stretch),
        child: GlowingOverscrollIndicator(
          showLeading: true,
          showTrailing: true,
          axisDirection: AxisDirection.down,
          color: const Color(0xFF8C91A3),
          child: ListView.builder(
            addAutomaticKeepAlives: true,
            shrinkWrap: true,
            itemCount: games.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () async {
                  close();
                  await Get.toNamed(Routes.SEARCH, arguments: [games[index], isDynamic!]);
                },
                child: _cargGames(context, index),
              );
            },
          ),
        ),
      ),
    );
  }

  _cargGames(BuildContext context, int index) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height / 100, horizontal: 5),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 15,
      decoration: BoxDecoration(
        color: context.theme.colorScheme.background,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Flexible(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.only(right: 10),
              child: ClipOval(
                child: Image(
                  image: CachedNetworkImageProvider(
                    games[index].urlPath!,
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 6,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        flex: 3,
                        child: SizedBox(
                          width: double.infinity,
                          child: Text(
                            games[index].status!,
                            style: Get.theme.textTheme.headline4!.copyWith(
                              color: games[index].status == "WINNER" ? const Color(0xFF65B037) : const Color(0xFFF89600),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 5,
                        child: Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          child: FittedBox(
                            alignment: Alignment.center,
                            fit: BoxFit.contain,
                            child: Text(
                              games[index].gameHost!,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.clip,
                              style: GoogleFonts.podkova(
                                fontSize: 15,
                                fontWeight: FontWeight.w200,
                                color: const Color(0xFF8c91A3),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    games[index].hero!,
                    style: Get.theme.textTheme.headline5,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Icon(
                            FeatherIcons.clock,
                            color: const Color(0xFFA7ADAA),
                            size: MediaQuery.of(context).size.height / 60,
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Text(
                            games[index].duracion!,
                            style: const TextStyle(color: Color(0xFFA7ADAA)),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 5,
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            games[index].fecha!,
                            style: const TextStyle(color: Color(0xFFA7ADAA), fontSize: 11, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Text(
                      "K",
                      style: TextStyle(color: Color(0xFFA7ADAA), fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "A",
                      style: TextStyle(color: Color(0xFFA7ADAA), fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "D",
                      style: TextStyle(color: Color(0xFFA7ADAA), fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(games[index].k!, style: context.theme.textTheme.headline5!.copyWith(color: context.theme.colorScheme.primary)),
                    Text(games[index].d!, style: context.theme.textTheme.headline5!.copyWith(color: context.theme.colorScheme.primary)),
                    Text(games[index].a!, style: context.theme.textTheme.headline5!.copyWith(color: context.theme.colorScheme.primary)),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
