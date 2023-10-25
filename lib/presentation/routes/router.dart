import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'router.gr.dart';


@AutoRouterConfig(
  replaceInRouteName: 'Page,Route',
)
class AppRouter extends $AppRouter {

  @override
  List<AutoRoute> get routes => [
    AutoRoute(path: '/time_table', page: TimeTableRoute.page, initial: true),

  ];
}
