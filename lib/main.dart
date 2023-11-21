import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'PageRouter/ssc_page_router.dart';

void main() {
  SSCRouter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = ThemeData(
      primarySwatch: Colors.blue,
      tabBarTheme: Theme.of(context).tabBarTheme.copyWith(
            labelColor: Colors.black26,
            labelStyle: const TextStyle(color: Colors.black26, fontSize: 14),
          ),
    );

    return MaterialApp.router(
      theme: themeData,
      title: 'SSC Design',
      routerConfig: SSCRouter().goRouter,
      builder: (routerContext, child) {
        return ResponsiveBreakpoints.builder(
          child: child!,
          breakpoints: [
            const Breakpoint(start: 0, end: 450, name: MOBILE),
            const Breakpoint(start: 451, end: 800, name: TABLET),
            const Breakpoint(start: 801, end: 1920, name: DESKTOP),
            const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
          ],
        );
      },
    );
  }
}
