import 'package:flutter/material.dart';

import '../../../biz/menuPage/menu/ssc_menu_item.dart';
import '../button/ssc_button_state_property.dart';
import '../button/ssc_button_style.dart';

class SSCColors extends ChangeNotifier {
  static final SSCColors _instance = SSCColors._internal();
  var theme = <String, SSCTheme>{};
  var themeKey = 'normal';

  factory SSCColors() {
    return _instance;
  }

  SSCColors._internal() {
    theme['normal'] = SSCTheme();
  }

  static SSCColors colors() {
    return SSCColors();
  }

  void changeTheme(String key) {
    themeKey = key;
    notifyListeners();
  }

  SSCTheme get() {
    return theme[themeKey]!;
  }

  static SSCTheme ofTheme() {
    return SSCColors().get();
  }
}

class SSCTheme {
  final NavMenuStyle navMenuStyle;
  final NavMenuItemStyle navMenuItemStyle;
  final NavMenuItemStyle navMenuItemStyle2;
  final NavMenuItemStyle navMenuItemStyle3;
  final SSCButtonStateProperty<SSCButtonStyle> buttonStyle;
  final MaterialStateProperty<MouseCursor> clickMouse;
  final Color backgroundColor;
  final Color primaryBackgroundColor;
  final Color secondaryColor;

  factory SSCTheme({
    NavMenuStyle? navMenuStyle,
    NavMenuItemStyle? navMenuItemStyle,
    NavMenuItemStyle? navMenuItemStyle2,
    NavMenuItemStyle? navMenuItemStyle3,
    SSCButtonStateProperty<SSCButtonStyle>? buttonStyle,
    MaterialStateProperty<MouseCursor>? clickMouse,
    Color? backgroundColor,
    Color? primaryBackgroundColor,
    Color? secondaryColor,
  }) {
    backgroundColor = backgroundColor ?? const Color(0xFFFFFFFF);
    primaryBackgroundColor = primaryBackgroundColor ?? const Color(0xFFFFFFFF);

    secondaryColor = secondaryColor ?? const Color(0xFF9D9FA5);
    Color primaryColor = const Color(0xFF1677FF);
    Color infoColor = const Color(0xFF919398);
    Color successColor = const Color(0xFF7EC050);
    Color errorColor = const Color(0xFFE47470);
    Color warningColor = const Color(0xFFDCA551);

    // Menu Style
    navMenuStyle ??= NavMenuStyle(background: primaryBackgroundColor);

    // Menu Item Style
    Color navMenuItemColor = primaryBackgroundColor;
    Color navMenuItemOpenColor = const Color(0xFFF2F3F5);
    Color navMenuItemHovered = const Color(0xFFF2F3F5);
    Color navMenuItemHovered2 = const Color(0xFFF2F3F5);
    Color navMenuItemTextColor = const Color(0xFF4E5969);
    Color navMenuItemSubtextNormalColor = const Color(0xFF1D2129);

    navMenuItemStyle ??= NavMenuItemStyle(
      iconColor: MaterialStateProperty.resolveWith(
        (states) {
          if (states.contains(MaterialState.selected)) {
            return primaryColor;
          }
          if (states.contains(MaterialState.focused)) {
            return primaryColor;
          }
          return navMenuItemTextColor;
        },
      ),
      backgroundColor: MaterialStateProperty.resolveWith(
        (states) {
          return Colors.white;
        },
      ),
      titleStyle: MaterialStateProperty.resolveWith(
        (states) {
          if (states.contains(MaterialState.selected)) {
            return TextStyle(
              fontSize: 16,
              color: primaryColor,
            );
          }

          if (states.contains(MaterialState.focused)) {
            return TextStyle(
              fontSize: 16,
              color: primaryColor,
            );
          }

          return TextStyle(
            fontSize: 16,
            color: navMenuItemTextColor,
          );
        },
      ),
    );

    navMenuItemStyle2 ??= NavMenuItemStyle(
      iconColor: MaterialStateProperty.resolveWith(
        (states) {
          if (states.contains(MaterialState.selected)) {
            return Colors.blue;
          }

          if (states.contains(MaterialState.focused)) {
            return Colors.white;
          }

          return Colors.white70;
        },
      ),
      backgroundColor: MaterialStateProperty.resolveWith(
        (states) {
          if (states.contains(MaterialState.selected)) {
            return navMenuItemOpenColor;
          }

          if (states.contains(MaterialState.focused)) {
            return navMenuItemOpenColor;
          }

          return Colors.white;
        },
      ),
      titleStyle: MaterialStateProperty.resolveWith(
        (states) {
          if (states.contains(MaterialState.selected)) {
            return TextStyle(fontSize: 13, color: primaryColor);
          }

          if (states.contains(MaterialState.focused)) {
            return TextStyle(fontSize: 13, color: primaryColor);
          }

          return TextStyle(fontSize: 13, color: navMenuItemSubtextNormalColor);
        },
      ),
    );

    navMenuItemStyle3 ??=
        NavMenuItemStyle(iconColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return Colors.blue;
      }
      if (states.contains(MaterialState.focused)) {
        return Colors.white;
      }
      return Colors.white70;
    }), backgroundColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.hovered)) {
        return navMenuItemHovered2;
      }
      if (states.contains(MaterialState.selected)) {
        return navMenuItemOpenColor.withOpacity(0.9);
      } else {
        return navMenuItemOpenColor;
      }
    }), titleStyle: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return const TextStyle(fontSize: 14, color: Colors.blue);
      }
      if (states.contains(MaterialState.focused)) {
        return const TextStyle(fontSize: 14, color: Colors.white);
      }
      return const TextStyle(fontSize: 14, color: Colors.white70);
    }));

    Color textColor = Colors.white;

    MaterialStateProperty<TextStyle> buttonText =
        MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.disabled)) {
        return TextStyle(fontSize: 14, color: textColor.withOpacity(0.5));
      } else {
        return TextStyle(fontSize: 14, color: textColor);
      }
    });

    SSCButtonStyle primaryStyle = SSCButtonStyle(
        textStyle: buttonText,
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return primaryColor.withOpacity(0.5);
          }
          if (states.contains(MaterialState.pressed)) {
            return primaryColor;
          }
          if (states.contains(MaterialState.focused) ||
              states.contains(MaterialState.hovered)) {
            return primaryColor.withOpacity(0.8);
          } else {
            return primaryColor.withOpacity(0.9);
          }
        }),
        borderColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return primaryColor.withOpacity(0.5);
          }
          if (states.contains(MaterialState.focused) ||
              states.contains(MaterialState.hovered) &&
                  !states.contains(MaterialState.pressed)) {
            return primaryColor.withOpacity(0.28);
          } else if (states.contains(MaterialState.pressed)) {
            return primaryColor;
          } else {
            return primaryColor.withOpacity(0.5);
          }
        }));

    SSCButtonStyle infoStyle = SSCButtonStyle(
        textStyle: buttonText,
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return infoColor.withOpacity(0.5);
          }
          if (states.contains(MaterialState.focused) ||
              states.contains(MaterialState.hovered) &&
                  !states.contains(MaterialState.pressed)) {
            return infoColor.withOpacity(0.28);
          } else if (states.contains(MaterialState.pressed)) {
            return infoColor;
          } else {
            return infoColor.withOpacity(0.5);
          }
        }),
        borderColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return infoColor.withOpacity(0.5);
          }
          if (states.contains(MaterialState.focused) ||
              states.contains(MaterialState.hovered) &&
                  !states.contains(MaterialState.pressed)) {
            return infoColor.withOpacity(0.28);
          } else if (states.contains(MaterialState.pressed)) {
            return infoColor;
          } else {
            return infoColor.withOpacity(0.5);
          }
        }));

    SSCButtonStyle successStyle = SSCButtonStyle(
        textStyle: buttonText,
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return successColor.withOpacity(0.5);
          }
          if (states.contains(MaterialState.focused) ||
              states.contains(MaterialState.hovered) &&
                  !states.contains(MaterialState.pressed)) {
            return successColor.withOpacity(0.28);
          } else if (states.contains(MaterialState.pressed)) {
            return successColor;
          } else {
            return successColor.withOpacity(0.5);
          }
        }),
        borderColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return successColor.withOpacity(0.5);
          }
          if (states.contains(MaterialState.focused) ||
              states.contains(MaterialState.hovered) &&
                  !states.contains(MaterialState.pressed)) {
            return successColor.withOpacity(0.28);
          } else if (states.contains(MaterialState.pressed)) {
            return successColor;
          } else {
            return successColor.withOpacity(0.5);
          }
        }));

    SSCButtonStyle textStyle = SSCButtonStyle(
        textStyle: buttonText,
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          return Colors.transparent;
        }),
        borderColor: MaterialStateProperty.resolveWith((states) {
          return Colors.transparent;
        }));

    SSCButtonStyle errorStyle = SSCButtonStyle(
        textStyle: buttonText,
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return errorColor.withOpacity(0.5);
          }
          if (states.contains(MaterialState.focused) ||
              states.contains(MaterialState.hovered) &&
                  !states.contains(MaterialState.pressed)) {
            return errorColor.withOpacity(0.28);
          } else if (states.contains(MaterialState.pressed)) {
            return errorColor;
          } else {
            return errorColor.withOpacity(0.5);
          }
        }),
        borderColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return errorColor.withOpacity(0.5);
          }
          if (states.contains(MaterialState.focused) ||
              states.contains(MaterialState.hovered) &&
                  !states.contains(MaterialState.pressed)) {
            return errorColor.withOpacity(0.28);
          } else if (states.contains(MaterialState.pressed)) {
            return errorColor;
          } else {
            return errorColor.withOpacity(0.5);
          }
        }));

    SSCButtonStyle warningStyle = SSCButtonStyle(
        textStyle: buttonText,
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return warningColor.withOpacity(0.5);
          }
          if (states.contains(MaterialState.focused) ||
              states.contains(MaterialState.hovered) &&
                  !states.contains(MaterialState.pressed)) {
            return warningColor.withOpacity(0.28);
          } else if (states.contains(MaterialState.pressed)) {
            return warningColor;
          } else {
            return warningColor.withOpacity(0.5);
          }
        }),
        borderColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return warningColor.withOpacity(0.5);
          }
          if (states.contains(MaterialState.focused) ||
              states.contains(MaterialState.hovered) &&
                  !states.contains(MaterialState.pressed)) {
            return warningColor.withOpacity(0.28);
          } else if (states.contains(MaterialState.pressed)) {
            return warningColor.withOpacity(0.9);
          } else {
            return warningColor.withOpacity(0.5);
          }
        }));

    buttonStyle ??= SSCButtonStateProperty.resolveWith((states) {
      if (states.contains(SSCButtonType.primary)) {
        return primaryStyle;
      } else if (states.contains(SSCButtonType.info)) {
        return infoStyle;
      } else if (states.contains(SSCButtonType.success)) {
        return successStyle;
      } else if (states.contains(SSCButtonType.text)) {
        return textStyle;
      } else if (states.contains(SSCButtonType.error)) {
        return errorStyle;
      } else if (states.contains(SSCButtonType.warning)) {
        return warningStyle;
      } else {
        return textStyle;
      }
    });
    clickMouse ??=
        MaterialStateProperty.resolveWith((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return SystemMouseCursors.forbidden;
      }
      return SystemMouseCursors.basic;
    });

    return SSCTheme.raw(
      navMenuStyle,
      navMenuItemStyle,
      navMenuItemStyle2,
      navMenuItemStyle3,
      buttonStyle,
      clickMouse,
      backgroundColor,
      primaryBackgroundColor,
      secondaryColor,
    );
  }

  const SSCTheme.raw(
    this.navMenuStyle,
    this.navMenuItemStyle,
    this.navMenuItemStyle2,
    this.navMenuItemStyle3,
    this.buttonStyle,
    this.clickMouse,
    this.backgroundColor,
    this.primaryBackgroundColor,
    this.secondaryColor,
  );
}
