import 'package:flutter/material.dart';
import 'package:fluttericon/fontelico_icons.dart';

import '../colors/ssc_colors.dart';
import '../rotation/ssc_rotation.dart';
import 'ssc_button_style.dart';

class SSCButton extends StatefulWidget {
  final SSCButtonType? buttonStyle;
  final SSCButtonShape buttonShape;
  final SSCButtonSize buttonSize;
  final SSCButtonType buttonType;
  final Widget? child;
  final String? text;
  final bool? loading;
  final Widget? left;
  final Widget? right;
  final Function? onTop;
  final bool disabled;
  final double? height;
  final MaterialStateProperty<TextStyle>? textStyle;
  final MaterialStateProperty<MouseCursor>? mouseCursor;
  final BorderRadiusGeometry? borderRadius;

  SSCButton(
      {super.key,
      this.buttonStyle,
      this.buttonShape = SSCButtonShape.plain,
      this.buttonSize = SSCButtonSize.medium,
      this.disabled = false,
      this.child,
      this.loading = false,
      this.left,
      this.right,
      this.onTop,
      this.buttonType = SSCButtonType.primary,
      this.height,
      this.borderRadius,
      this.text,
      this.textStyle,
      this.mouseCursor})
      : assert(child != null || text != null, "child and text must choose one");

  @override
  State<StatefulWidget> createState() => _SSCButton();
}

class _SSCButton extends State<SSCButton> {
  late MaterialStatesController internalStatesController;
  late FocusScopeNode myFocus;

  void updateView() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    internalStatesController = MaterialStatesController();
    internalStatesController.update(
        MaterialState.disabled, widget.disabled || widget.onTop == null);
    if (widget.loading != null) {
      internalStatesController.update(MaterialState.disabled, widget.loading!);
    }
    internalStatesController.addListener(updateView);
    myFocus = FocusScopeNode();
    myFocus.addListener(updateView);
    super.initState();
  }

  @override
  void dispose() {
    internalStatesController.removeListener(updateView);
    internalStatesController.dispose();
    myFocus.removeListener(updateView);
    myFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SSCButtonType? buttonStyle = widget.buttonStyle;
    internalStatesController.update(
        MaterialState.focused, myFocus.hasPrimaryFocus);
    return LayoutBuilder(builder: (context, size) {
      double? width = size.maxWidth;
      double height = widget.height ?? size.maxHeight;
      switch (widget.buttonSize) {
        case SSCButtonSize.custom:
          if (height > size.maxHeight) {
            height = size.maxHeight;
          }
          break;
        case SSCButtonSize.medium:
          height = 40;
          break;
        case SSCButtonSize.small:
          height = 30;
          break;
        case SSCButtonSize.mini:
          height = 20;
          break;
      }

      Color borderColor = Colors.white;

      Color backgroundColor = Colors.white;

      BorderRadius? borderRadius;

      switch (widget.buttonShape) {
        case SSCButtonShape.plain:
          if (widget.buttonType != SSCButtonType.text) {
            backgroundColor = backgroundColor.withAlpha(100);
          }
          break;
        case SSCButtonShape.round:
          width = height;
          borderRadius = BorderRadius.all(Radius.circular(width / 2));
          break;
        case SSCButtonShape.circle:
          borderRadius = BorderRadius.all(Radius.circular(height / 2));
          break;
        case SSCButtonShape.custom:
          break;
      }

      switch (widget.buttonType) {
        case SSCButtonType.text:
          borderRadius = const BorderRadius.all(Radius.circular(0));
          break;
        case SSCButtonType.success:
          // TODO: Handle this case.
          break;
        case SSCButtonType.info:
          // TODO: Handle this case.
          break;
        case SSCButtonType.error:
          // TODO: Handle this case.
          break;
        case SSCButtonType.warning:
          // TODO: Handle this case.
          break;
        case SSCButtonType.primary:
          // TODO: Handle this case.
          break;
        case SSCButtonType.custom:
          // TODO: Handle this case.
          break;
      }
      if (width == double.infinity) {
        width = null;
      }
      late Widget child;
      if (widget.text != null) {
        child = Text(
          widget.text!,
          style: widget.textStyle?.resolve(internalStatesController.value),
        );
      } else {
        child = widget.child!;
      }

      Widget? progressWidget;
      bool progress = widget.loading ?? false;
      if (progress) {
        progressWidget = const RotationView(
          start: true,
          child: Icon(
            Fontelico.spin6,
            size: 16,
            color: Colors.white,
          ),
        );
      }
      return MouseRegion(
        onExit: (e) {
          internalStatesController.update(MaterialState.hovered, false);
        },
        onEnter: (e) {
          internalStatesController.update(MaterialState.hovered, true);
        },
        child: FocusScope(
          node: myFocus,
          child: InkWell(
            mouseCursor: (widget.mouseCursor ?? SSCColors().get().clickMouse)
                .resolve(internalStatesController.value),
            onTapDown: (details) {
              internalStatesController.update(MaterialState.pressed, true);
            },
            onTapCancel: () {
              internalStatesController.update(MaterialState.pressed, false);
            },
            onTapUp: (details) {
              internalStatesController.update(MaterialState.pressed, false);
            },
            onTap: () {
              if (widget.onTop != null) {
                widget.onTop!();
              }
            },
            child: AnimatedContainer(
              height: height,
              width: width,
              decoration: BoxDecoration(
                  borderRadius: widget.borderRadius ??
                      borderRadius ??
                      const BorderRadius.all(Radius.circular(5)),
                  border: Border.all(
                    color: borderColor,
                    width: 0.5,
                  ),
                  color: backgroundColor),
              duration: const Duration(milliseconds: 200),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  progressWidget != null
                      ? Container(
                          margin: const EdgeInsets.only(right: 5),
                          child: progressWidget,
                        )
                      : Container(),
                  child
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
