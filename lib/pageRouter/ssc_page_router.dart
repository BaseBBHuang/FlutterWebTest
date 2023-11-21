import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../biz/mainPage/devGuide/page/ssc_dev_guide_page.dart';
import '../biz/mainPage/page/ssc_main_page.dart';
import '../biz/menuPage/ssc_main_route_page.dart';

typedef OnRouteView = Widget Function(
    BuildContext context, GoRouterState state);

class RouteInfo extends GoRoute {
  final String title;
  // 菜单Icon
  final IconData? icon;
  // 子菜单
  final List<RouteInfo> children;
  // 路由信息是否存在于菜单
  final bool menu;
  final bool view;
  // 标题是否固定在导航栏
  final bool affix;

  // 标题是否存在面包屑
  final bool breadcrumb;

  // 运行时动态参数，可存储
  final Map<String, dynamic> runtimePair = {};

  RouteInfo(
      {required String path,
      required String name,
      OnRouteView? onRouteView,
      required this.title,
      this.menu = true,
      this.affix = false,
      this.breadcrumb = true,
      this.view = true,
      this.children = const <RouteInfo>[],
      this.icon})
      : super(
          path: path,
          name: name,
          pageBuilder: (context, state) {
            late Widget child;
            if (onRouteView != null) {
              child = onRouteView(context, state);
            } else {
              child = _builder(context, state);
            }
            return NoTransitionPage(child: child);
          },
          routes: children,
        );

  bool isChildren() => routes.isNotEmpty;

  T? getPair<T>(String key) {
    if (!runtimePair.containsKey(key)) {
      return null;
    }
    try {
      return runtimePair[key];
    } catch (e) {
      return null;
    }
  }

  putPair(
    String key,
    dynamic data, {
    bool replace = false,
  }) {
    if (runtimePair.containsKey(key)) {
      if (!replace) {
        return;
      }
    }
    runtimePair[key] = data;
  }
}

Widget _builder(
  BuildContext context,
  GoRouterState state,
) {
  return const SizedBox();
}

// 路由
final menuRoute = [
  RouteInfo(
    path: '/index',
    name: 'index',
    title: '开发指南',
    onRouteView: (context, state) => SSCDevGuidePage(
      key: state.pageKey,
    ),
    children: [
      RouteInfo(
        path: 'list1',
        name: 'user_list1',
        title: '组件说明1',
        onRouteView: (context, state) => SSCMainPage(
          key: state.pageKey,
        ),
      ),
      RouteInfo(
        path: 'list2',
        name: 'user_list2',
        title: '组件说明2',
        onRouteView: (context, state) => SSCMainPage(
          key: state.pageKey,
        ),
      ),
    ],
  ),
  RouteInfo(
    path: '/subindex1',
    name: 'subindex1',
    title: '组件说明',
    children: [
      RouteInfo(
        path: 'sublist1',
        name: 'sublist1',
        title: '组件说明1',
        onRouteView: (context, state) => SSCMainPage(
          key: state.pageKey,
        ),
      ),
      RouteInfo(
        path: 'sublist2',
        name: 'sublist2',
        title: '组件说明2',
        onRouteView: (context, state) => SSCMainPage(
          key: state.pageKey,
        ),
      ),
    ],
  ),
];

class SSCRouter {
  static final SSCRouter _instance = SSCRouter._internal();
  RouteInfo? currentRoute;
  Map<String, RouteInfo> tips = {};
  List<RouteInfo> parents = [];
  late GoRouter goRouter;

  SSCRouter._internal() {
    goRouter = GoRouter(
      routes: [
        ShellRoute(
          routes: menuRoute,
          builder: (context, state, child) {
            return RouterView(
              child,
              key: state.pageKey,
            );
          },
        ),
      ],
      initialLocation: '/index',
      debugLogDiagnostics: true,
    );
  }

  void setNewNav(List<RouteInfo> names) {
    if (names.isEmpty) {
      return;
    }
    parents = names;
    currentRoute = parents.last;
    tips[currentRoute!.name!] = currentRoute!;
  }

  bool isChild(RouteInfo routeInfo) {
    for (var i = 0; i < parents.length; i++) {
      var value = parents[i];
      if (value.name == routeInfo.name) {
        return true;
      }
    }
    return false;
  }

  factory SSCRouter() {
    return _instance;
  }
}

extension SSCString on String {
  bool eq(dynamic d) {
    if (d == null) {
      return false;
    }
    return toString() == d.toString();
  }
}
