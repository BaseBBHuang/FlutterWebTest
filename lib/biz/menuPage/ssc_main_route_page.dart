import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../PageRouter/ssc_page_router.dart';
import '../../common/UI/base/ssc_base_view.dart';
import '../../common/UI/colors/ssc_colors.dart';
import 'menu/ssc_menu.dart';
import 'menu/ssc_menu_item.dart';

class RouterView extends BaseView {
  final Widget child;

  const RouterView(
    this.child, {
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _RouterView();
}

class _RouterView extends SSCStateView<RouterView> {
  final double _menuOpenRate = 0.125;
  final double _menuCloseRate = 0.032;
  bool menuOpen = true;
  bool loadding = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void setupRouterPage(BuildContext context) {
    GoRouter route = GoRouter.of(context);
    var routeMatchList = route.routerDelegate.currentConfiguration;
    if (routeMatchList.isNotEmpty) {
      List<RouteInfo> currentRouters = [];
      for (int i = 0; i < routeMatchList.matches.length; i++) {
        var routeMatch = routeMatchList.matches[i];
        if (routeMatch.route is RouteInfo) {
          currentRouters.add(routeMatch.route as RouteInfo);
        }
      }
      SSCRouter().setNewNav(currentRouters);
    }
  }

  @override
  Widget build(BuildContext context) {
    setupRouterPage(context);
    return super.build(context);
  }

  @override
  Widget? buildForLarge(BuildContext context) {
    return LayoutBuilder(
      builder: (context, size) {
        List<Widget> widgets = [];

        /// 侧边栏菜单
        Drawer menu = getMenu(size);
        if (!ResponsiveBreakpoints.of(context).isMobile) {
          widgets.add(
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              child: menu,
            ),
          );
        }

        /// 右侧内容信息
        widgets.add(Expanded(child: _mainWidget(size)));

        return Scaffold(
          key: _scaffoldKey,
          drawer: ResponsiveBreakpoints.of(context).isMobile ? menu : null,
          body: SizedBox(
            height: size.maxHeight,
            width: size.maxWidth,
            child: Row(
              children: widgets,
            ),
          ),
        );
      },
    );
  }

  Widget _mainWidget(BoxConstraints size) {
    return SizedBox(
      height: size.maxHeight,
      child: widget.child,
    );
  }

  Drawer getMenu(BoxConstraints constraints) {
    double desktopWidth =
        (menuOpen ? _menuOpenRate : _menuCloseRate) * constraints.maxWidth;
    double mobileWidth = constraints.maxWidth / 2;
    double width =
        ResponsiveBreakpoints.of(context).isMobile ? mobileWidth : desktopWidth;

    return Drawer(
      width: width,
      child: Container(
        width: width,
        color: SSCColors().get().backgroundColor,
        height: constraints.maxHeight,
        child: SingleChildScrollView(
          child: NavMenu(
            width: width,
            axis: Axis.vertical,
            open: menuOpen,
            rootCount: menuRoute.length,
            indexedBuilder: (
              context,
              data,
              index,
              style,
              states,
              animationController,
              menuOpen,
              level,
            ) {
              return NavMenuItem(
                level: level,
                data: data,
                menuOpen: menuOpen,
                materialState: states,
                itemStyle: style,
                animation: animationController.drive(Tween(begin: 0, end: 0.5)),
              );
            },
            onSelected: (routeInfo) {
              context.goNamed(routeInfo.name!);
            },
            rootBuilder: (int index) {
              return menuRoute[index];
            },
            menuStateBuilder: (RouteInfo route) {
              return SSCRouter().currentRoute?.name == route.name;
            },
            onChild: (RouteInfo route) {
              return SSCRouter().isChild(route);
            },
          ),
        ),
      ),
    );
  }
}
