import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';

import '../../../PageRouter/ssc_page_router.dart';
import '../../../common/UI/base/ssc_base_style.dart';
import '../../../common/UI/colors/ssc_colors.dart';

typedef IndexedBuilder = Widget Function(
  BuildContext context,
  dynamic data,
  int index,
  NavMenuItemStyle? style,
  MaterialStatesController materialStates,
  AnimationController animationController,
  bool open,
  int level,
);

typedef RootBuilder = RouteInfo Function(int index);
typedef MenuStateBuilder = bool Function(RouteInfo route);

typedef OnSelected = void Function(RouteInfo data);

class NavMenuItemStyle {
  final MaterialStateProperty<TextStyle> titleStyle;
  final MaterialStateProperty<Color> backgroundColor;
  final MaterialStateProperty<Color> iconColor;

  NavMenuItemStyle({
    required this.titleStyle,
    required this.backgroundColor,
    required this.iconColor,
  });
}

class NavMenuStyle extends BaseStyle {
  NavMenuStyle({
    super.background,
  });
}

// ignore: must_be_immutable
class NavMenuItem extends StatefulWidget {
  RouteInfo data;
  NavMenuItemStyle? itemStyle;
  MaterialStatesController materialState;
  Animation<double> animation;
  bool menuOpen;
  int level = 1;

  NavMenuItem({
    super.key,
    required this.data,
    required this.menuOpen,
    required this.materialState,
    this.itemStyle,
    required this.level,
    required this.animation,
  });

  @override
  State<StatefulWidget> createState() => _NavMenuItem();
}

class _NavMenuItem extends State<NavMenuItem>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // 获取层级
    debugPrint('获取层级:${widget.level}');
    switch (widget.level) {
      case 1:
        widget.itemStyle ??= SSCColors().get().navMenuItemStyle;
        break;
      case 2:
        widget.itemStyle ??= SSCColors().get().navMenuItemStyle2;
        break;
      default:
        widget.itemStyle ??= SSCColors().get().navMenuItemStyle3;
        break;
    }

    return LayoutBuilder(
      builder: (context, size) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: widget.itemStyle!.backgroundColor
                .resolve(widget.materialState.value),
            borderRadius: BorderRadius.circular(2),
          ),
          width: size.maxWidth,
          child: widget.menuOpen ? _itemWidget() : const SizedBox(),
        );
      },
    );
  }

  Widget _itemWidget() {
    double level = widget.level.toDouble();
    debugPrint('_itemWidget:$level');
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                color: Colors.transparent,
                alignment: Alignment.centerLeft,
                height: 40,
                padding:
                    EdgeInsets.only(left: 12 * level + (level > 1 ? 8 : 0)),
                child: AnimatedDefaultTextStyle(
                  style: widget.itemStyle!.titleStyle
                      .resolve(widget.materialState.value),
                  duration: const Duration(milliseconds: 100),
                  child: Text(
                    widget.data.title,
                  ),
                ),
              ),
            ),
            widget.data.isChildren()
                ? RotationTransition(
                    turns: widget.animation,
                    child: Icon(
                      Entypo.down_open_mini,
                      color: widget.itemStyle!.iconColor
                          .resolve(widget.materialState.value),
                    ),
                  )
                : const SizedBox()
          ],
        ),
        const SizedBox(height: 4),
      ],
    );
  }
}
