import 'package:flutter/material.dart';

import '../../../PageRouter/ssc_page_router.dart';
import '../../../common/UI/button/ssc_button.dart';
import '../../../common/UI/button/ssc_button_style.dart';
import 'ssc_bread_crum.dart';

class TitleView extends StatelessWidget {
  const TitleView({super.key});

  @override
  Widget build(BuildContext context) {
    List<RouteInfo> titles = SSCRouter().parents;
    RouteInfo? currentRoute = SSCRouter().currentRoute;

    return LayoutBuilder(builder: (context, size) {
      return BreadCrumbView(
          separator: const Text(
            " / ",
            style: TextStyle(fontSize: 14, color: Colors.white),
          ),
          buttons: titles.map((e) {
            return SizedBox(
              height: 50,
              child: SSCButton(
                onTop: null,
                text: e.title,
                buttonType: SSCButtonType.text,
                textStyle: MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.disabled)) {
                    return const TextStyle(fontSize: 14, color: Colors.white);
                  }
                  if (states.contains(MaterialState.selected)) {
                    return const TextStyle(fontSize: 14, color: Colors.white);
                  }

                  if (currentRoute?.path == e.path) {
                    return const TextStyle(fontSize: 14, color: Colors.white);
                  } else {
                    if (states.contains(MaterialState.hovered)) {
                      return const TextStyle(fontSize: 14, color: Colors.white);
                    }
                    return const TextStyle(fontSize: 14, color: Colors.white);
                  }
                }),
              ),
            );
          }).toList());
    });
  }
}
