import 'package:auto_route/auto_route.dart';
import 'package:test_1/pages/users/user_profile/page_post.dart';
import 'package:test_1/router/app_router.gr.dart';

@AutoRouterConfig(
  deferredLoading: false,
)
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType {
    return const RouteType.custom(
      transitionsBuilder: TransitionsBuilders.fadeIn,
    );
  }

  @override
  List<AutoRoute> get routes => [
        AutoRoute(path: '/', page: AllUsersRoute.page),
        AutoRoute(path: '/:id', page: UserProfileRoute.page),
        AutoRoute(path: '/post:id', page: UserPostRoute.page),
      ];
}
