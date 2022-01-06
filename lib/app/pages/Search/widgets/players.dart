import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:ranked/api/domain/entities/global/users_in_game.dart';

class GamesCuadro extends StatelessWidget {
  final List<UserInGame> users;
  const GamesCuadro({Key? key, required this.users}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 21, vertical: 20),
      margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 15),
      decoration: BoxDecoration(
        color: context.theme.colorScheme.primaryVariant,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 1,
            child: SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  head('Nickname', 6),
                  head('Status', 3),
                  head('K', 1),
                  head('D', 1),
                  head('A', 1),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 10,
            child: Column(
              children: List.generate(
                users.length,
                (index) => Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: users[index].country.isEmpty
                            ? Container()
                            : Container(
                                alignment: Alignment.centerLeft,
                                child: Image.network(
                                  users[index].country,
                                  height: 10,
                                ),
                              ),
                      ),
                      Flexible(
                        flex: 5,
                        child: Container(
                          width: double.infinity,
                          alignment: Alignment.centerLeft,
                          child: AutoSizeText(
                            users[index].nickname.trim(),
                            style: context.theme.textTheme.headline5!.copyWith(fontSize: 15, letterSpacing: 1),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 3,
                        child: SizedBox(
                          width: double.infinity,
                          child: Center(
                            child: AutoSizeText(
                              users[index].status.trim(),
                              style: context.theme.textTheme.headline4!.copyWith(
                                fontSize: 14,
                                color: users[index].status == "WIN" ? const Color(0xFF65B037) : const Color(0xFFF89600),
                              ),
                            ),
                          ),
                        ),
                      ),
                      kda(users[index].k, context),
                      kda(users[index].d, context),
                      kda(users[index].a, context),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Flexible head(
    String value,
    int flex,
  ) {
    return Flexible(
      flex: flex,
      child: Container(
        alignment: Alignment.center,
        child: AutoSizeText(
          value,
          maxLines: 1,
          // style: context.theme.textTheme.bodyText1,
        ),
      ),
    );
  }

  Flexible kda(int value, BuildContext context) {
    return Flexible(
      flex: 1,
      child: Container(
        alignment: Alignment.center,
        child: AutoSizeText(
          value.toString(),
          style: context.theme.textTheme.headline6,
        ),
      ),
    );
  }
}
