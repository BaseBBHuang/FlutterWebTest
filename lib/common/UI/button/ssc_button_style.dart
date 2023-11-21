import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter/material.dart';

enum SSCButtonType { success, info, error, warning, primary, text, custom }

enum SSCButtonShape { plain, round, circle, custom }

enum SSCButtonSize { medium, small, mini, custom }

@CopyWith()
class SSCButtonStyle {
  final MaterialStateProperty<Color> backgroundColor;
  final MaterialStateProperty<Color> borderColor;
  final MaterialStateProperty<TextStyle> textStyle;

  SSCButtonStyle({
    required this.textStyle,
    required this.backgroundColor,
    required this.borderColor,
  });
}
