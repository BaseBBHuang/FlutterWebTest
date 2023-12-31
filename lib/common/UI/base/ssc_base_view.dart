import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'package:responsive_framework/responsive_framework.dart';

abstract class BaseView extends StatefulWidget {
  const BaseView({
    super.key,
  });
}

class SSCStateView<T extends BaseView> extends State<T> {
  final logger = Logger();

  @override
  void initState() {
    super.initState();
  }

  // 大屏幕
  Widget? buildForLarge(BuildContext context) => null;

  // 中等
  Widget? buildForMedium(BuildContext context) => null;

  // 小屏幕
  Widget? buildForSmall(BuildContext context) => null;

  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < 768;
  }

  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > 768;
  }

  static bool isMediumScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > 425 &&
        MediaQuery.of(context).size.width < 1200;
  }

  @override
  Widget build(BuildContext context) {
    String? name = ResponsiveBreakpoints.of(context).breakpoint.name;
    debugPrint('breakpoint:$name');
    return LayoutBuilder(
      builder: (context, constraints) {
        if (name == null) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: buildForLarge(context),
          );
        }
        switch (name) {
          case MOBILE:
            return Scaffold(
              backgroundColor: Colors.white,
              body: buildForSmall(context) ??
                  buildForMedium(context) ??
                  buildForLarge(context),
            );
          case TABLET:
            return Scaffold(
              backgroundColor: Colors.white,
              body: buildForMedium(context) ??
                  buildForLarge(context) ??
                  buildForSmall(context),
            );
          case DESKTOP:
            return Scaffold(
              backgroundColor: Colors.white,
              body: buildForLarge(context),
            );
          default:
            return Scaffold(
              backgroundColor: Colors.white,
              body: buildForSmall(context) ??
                  buildForMedium(context) ??
                  buildForLarge(context),
            );
        }
      },
    );
  }
}
