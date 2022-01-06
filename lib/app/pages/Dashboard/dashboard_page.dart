import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:ranked/app/pages/Dashboard/controller.dart';
import 'package:ranked/app/pages/Dashboard/pages/global/global_page.dart';
import 'package:ranked/app/widgets/loading.dart';

class DashBoardPage extends GetWidget<DashboardController> {
  DashBoardPage({Key? key}) : super(key: key);
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: controller.obx(
        (state) => SafeArea(
          top: true,
          bottom: true,
          left: true,
          right: true,
          child: GestureDetector(
            onTap: () {
              fabKey.currentState!.close();
            },
            child: PageView(
              controller: controller.pageController,
              allowImplicitScrolling: false,
              physics: const NeverScrollableScrollPhysics(),
              pageSnapping: false,
              children: [
                GlobalPage(
                  usuario: controller.usuario!,
                  games: controller.gamesglobal!,
                ),
                GlobalPage(
                  usuario: controller.usuario!,
                  games: controller.gamesDynamic!,
                ),
              ],
            ),
          ),
        ),
        onLoading: const LoadingWidget(),
      ),
      floatingActionButton: GetBuilder<DashboardController>(
        id: 'menu',
        builder: (_) {
          return FabCircularMenu(
            key: fabKey,
            fabSize: MediaQuery.of(context).size.height / 14,
            fabOpenIcon: Icon(FeatherIcons.user),
            ringDiameter: MediaQuery.of(context).size.width * 0.9,
            ringWidth: MediaQuery.of(context).size.width * 0.25,
            children: [
              IconButton(
                  icon: Icon(Icons.home),
                  onPressed: () {
                    controller.changeIndex(0);
                    fabKey.currentState!.close();
                  }),
              IconButton(
                  icon: const Icon(Icons.favorite),
                  onPressed: () async {
                    controller.changeIndex(1);
                    fabKey.currentState!.close();
                    if (controller.gamesDynamic!.isEmpty) {
                      controller.gamesDynamic = await controller.dash.gamesinLineDynamic();
                      controller.update();
                    }
                  }),
              IconButton(
                onPressed: controller.changeThema,
                icon: Get.isDarkMode ? Icon(Icons.wb_sunny_sharp) : Icon(Icons.nights_stay_sharp),
              )
            ],
          );
        },
      ),
    );
  }
}
