// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i5;
import 'package:test_1/pages/users/page.dart' as _i1;
import 'package:test_1/pages/users/user_profile/page.dart' as _i2;
import 'package:test_1/pages/users/user_profile/page_post.dart' as _i3;

abstract class $AppRouter extends _i4.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    AllUsersRoute.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AllUsersPage(),
      );
    },
    UserProfileRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<UserProfileRouteArgs>(
          orElse: () => UserProfileRouteArgs(id: pathParams.getString('id')));
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.UserProfilePage(
          key: args.key,
          id: args.id,
        ),
      );
    },
    UserPostRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<UserPostRouteArgs>(
          orElse: () => UserPostRouteArgs(id: pathParams.getString('id')));
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.UserPostPage(
          key: args.key,
          id: args.id,
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.AllUsersPage]
class AllUsersRoute extends _i4.PageRouteInfo<void> {
  const AllUsersRoute({List<_i4.PageRouteInfo>? children})
      : super(
          AllUsersRoute.name,
          initialChildren: children,
        );

  static const String name = 'AllUsersRoute';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}

/// generated route for
/// [_i2.UserProfilePage]
class UserProfileRoute extends _i4.PageRouteInfo<UserProfileRouteArgs> {
  UserProfileRoute({
    _i5.Key? key,
    required String id,
    List<_i4.PageRouteInfo>? children,
  }) : super(
          UserProfileRoute.name,
          args: UserProfileRouteArgs(
            key: key,
            id: id,
          ),
          rawPathParams: {'id': id},
          initialChildren: children,
        );

  static const String name = 'UserProfileRoute';

  static const _i4.PageInfo<UserProfileRouteArgs> page =
      _i4.PageInfo<UserProfileRouteArgs>(name);
}

class UserProfileRouteArgs {
  const UserProfileRouteArgs({
    this.key,
    required this.id,
  });

  final _i5.Key? key;

  final String id;

  @override
  String toString() {
    return 'UserProfileRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i3.UserPostPage]
class UserPostRoute extends _i4.PageRouteInfo<UserPostRouteArgs> {
  UserPostRoute({
    _i5.Key? key,
    required String id,
    List<_i4.PageRouteInfo>? children,
  }) : super(
          UserPostRoute.name,
          args: UserPostRouteArgs(
            key: key,
            id: id,
          ),
          rawPathParams: {'id': id},
          initialChildren: children,
        );

  static const String name = 'UserPostRoute';

  static const _i4.PageInfo<UserPostRouteArgs> page =
      _i4.PageInfo<UserPostRouteArgs>(name);
}

class UserPostRouteArgs {
  const UserPostRouteArgs({
    this.key,
    required this.id,
  });

  final _i5.Key? key;

  final String id;

  @override
  String toString() {
    return 'UserPostRouteArgs{key: $key, id: $id}';
  }
}
