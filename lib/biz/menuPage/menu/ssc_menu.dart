import 'dart:math';

import 'package:flutter/material.dart';

import '../../../PageRouter/ssc_page_router.dart';

import '../../../common/UI/colors/ssc_colors.dart';
import '../../../common/UI/expand/ssc_expand.dart';
import 'ssc_menu_item.dart';

// ignore: must_be_immutable
class NavMenu extends StatefulWidget {
  final IndexedBuilder indexedBuilder;
  final RootBuilder rootBuilder;
  final MenuStateBuilder menuStateBuilder;
  final int rootCount;
  NavMenuItemStyle? itemStyle1;
  NavMenuItemStyle? itemStyle2;
  NavMenuItemStyle? itemStyle3;
  OnSelected? onSelected;
  final MenuStateBuilder onChild;
  final Axis axis;

  // 宽度
  final double width;

  NavMenuStyle? style;

  bool open;

  NavMenu({
    super.key,
    required this.indexedBuilder,
    required this.axis,
    this.style,
    required this.open,
    required this.width,
    this.itemStyle1,
    this.itemStyle2,
    this.itemStyle3,
    this.onSelected,
    required this.rootBuilder,
    required this.rootCount,
    required this.menuStateBuilder,
    required this.onChild,
  });

  @override
  State<StatefulWidget> createState() => _NavMenu();
}

class _NavMenu extends State<NavMenu> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> childs = [];

    var subMenu = getChildren(widget.open);

    childs.add(const SizedBox(height: 40));
    childs.addAll(subMenu);

    return LayoutBuilder(
      builder: (context, size) {
        widget.style ??= SSCColors().get().navMenuStyle;

        return Container(
          width: widget.width,
          color: widget.style?.background,
          child: Column(
            children: childs,
          ),
        );
      },
    );
  }

  Widget? children(
    int level,
    int index,
    bool menuOpen, {
    List<RouteInfo>? parentList,
  }) {
    if (index != -1) {
      var data = parentList?[index] ?? widget.rootBuilder(index);
      if (data.menu == false) {
        return null;
      }

      late NavMenuItemStyle? itemStyle;

      switch (level) {
        case 1:
          itemStyle = widget.itemStyle1;
          break;
        case 2:
          itemStyle = widget.itemStyle2;
          break;
        case 3:
          itemStyle = widget.itemStyle3;
          break;
        default:
          itemStyle = widget.itemStyle1;
          break;
      }

      data.putPair(
        'animation',
        AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 200),
        ),
        replace: false,
      );

      data.putPair(
        'materialState',
        MaterialStatesController(),
      );

      MaterialStatesController materialStatesController =
          data.getPair('materialState');

      materialStatesController.update(
        MaterialState.selected,
        widget.menuStateBuilder(data),
      );

      materialStatesController.update(
        MaterialState.focused,
        widget.onChild(data),
      );

      AnimationController animationController = data.getPair('animation');
      bool isChildren = data.isChildren();

      if (isChildren) {
        Widget? subMenu = children(
          level + 1,
          -1,
          menuOpen,
          parentList: data.children,
        );

        return SSCExpand(
          expand: widget.onChild(data),
          animationController: animationController,
          content: MouseRegion(
            // onEnter: (e) {
            //   (data.getPair('materialState') as MaterialStatesController)
            //       .update(
            //     MaterialState.hovered,
            //     true,
            //   );
            // },
            // onExit: (e) {
            //   (data.getPair('materialState') as MaterialStatesController)
            //       .update(
            //     MaterialState.hovered,
            //     false,
            //   );
            // },
            child: widget.indexedBuilder(
              context,
              data,
              index,
              itemStyle,
              data.getPair('materialState'),
              animationController,
              menuOpen,
              level,
            ),
          ),
          child: subMenu ?? const SizedBox(),
        );
      } else {
        return InkWell(
          onTap: () {
            if (widget.onSelected != null) {
              widget.onSelected!(data);
            }
          },
          child: MouseRegion(
            // onEnter: (e) {
            //   (data.getPair('materialState') as MaterialStatesController)
            //       .update(
            //     MaterialState.hovered,
            //     true,
            //   );
            // },
            // onExit: (e) {
            //   (data.getPair('materialState') as MaterialStatesController)
            //       .update(
            //     MaterialState.hovered,
            //     false,
            //   );
            // },
            child: widget.indexedBuilder(
              context,
              data,
              index,
              itemStyle,
              data.getPair('materialState'),
              animationController,
              menuOpen,
              level,
            ),
          ),
        );
      }
    } else {
      var data = <Widget>[];
      for (var i = 0; i < parentList!.length; i++) {
        Widget? menu = children(level, i, menuOpen, parentList: parentList);
        if (menu == null) {
          continue;
        }
        data.add(menu);
      }
      return Column(
        children: data,
      );
    }
  }

  List<Widget> getChildren(bool menuOpen) {
    List<Widget> data = [];
    for (int i = 0; i < widget.rootCount; i++) {
      Widget? rootMenu = children(1, i, menuOpen);
      if (rootMenu == null) {
        continue;
      }
      data.add(rootMenu);
    }
    return data;
  }

  void updateView() {
    if (mounted) {
      setState(() {});
    }
  }
}
