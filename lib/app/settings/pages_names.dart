import 'package:get/route_manager.dart';
import 'package:ranked/app/bindings/dashboard.dart';
import 'package:ranked/app/bindings/login.dart';
import 'package:ranked/app/bindings/search.dart';
import 'package:ranked/app/bindings/splash.dart';
import 'package:ranked/app/pages/Dashboard/dashboard_page.dart';
import 'package:ranked/app/pages/Login/login_page.dart';
import 'package:ranked/app/pages/Search/search_page.dart';
import 'package:ranked/app/pages/Splash/splash_page.dart';
import 'package:ranked/app/settings/pages.dart';

class Pages {
  static final pages = [
    GetPage(
      name: Routes.SPLASH,
      page: () => SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.DASHBOARD,
      page: () => DashBoardPage(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: Routes.SEARCH,
      page: () => SearchPage(),
      binding: SearchBinding(),
    )
  ];
}
