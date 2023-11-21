import 'package:flutter/material.dart';

import '../../../biz/menuPage/menu/ssc_menu_item.dart';
import '../button/ssc_button_state_property.dart';
import '../button/ssc_button_style.dart';

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
    backgroundColor = backgroundColor ?? Color.fromARGB(255, 8, 8, 10);
    primaryBackgroundColor = primaryBackgroundColor ?? const Color(0xFF2B2D3D);

    secondaryColor = secondaryColor ?? const Color(0xFF9D9FA5);
    Color primaryColor = const Color(0xFF5A9CF8);
    Color infoColor = const Color(0xFF919398);
    Color successColor = const Color(0xFF7EC050);
    Color errorColor = const Color(0xFFE47470);
    Color warningColor = const Color(0xFFDCA551);
    // Menu Style
    navMenuStyle ??= NavMenuStyle(background: primaryBackgroundColor);

    // Menu Item Style
    Color navMenuItemColor = primaryBackgroundColor;
    Color navMenuItemOpenColor = const Color(0x99333545);
    Color navMenuItemHovered = const Color(0xFF333545);
    Color navMenuItemHovered2 = const Color(0xFF333545);
    navMenuItemStyle ??=
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
        return navMenuItemHovered;
      }
      if (states.contains(MaterialState.selected)) {
        return navMenuItemColor;
      } else {
        return navMenuItemColor;
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

    navMenuItemStyle2 ??=
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

    navMenuItemStyle3 ??= NavMenuItemStyle(
      iconColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return Colors.blue;
        }
        if (states.contains(MaterialState.focused)) {
          return Colors.white;
        }
        return Colors.white70;
      }),
      backgroundColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.hovered)) {
          return navMenuItemHovered2;
        }
        if (states.contains(MaterialState.selected)) {
          return navMenuItemOpenColor.withOpacity(0.9);
        } else {
          return navMenuItemOpenColor;
        }
      }),
      titleStyle: MaterialStateProperty.resolveWith(
        (states) {
          if (states.contains(MaterialState.selected)) {
            return const TextStyle(fontSize: 14, color: Colors.blue);
          }
          if (states.contains(MaterialState.focused)) {
            return const TextStyle(fontSize: 14, color: Colors.white);
          }
          return const TextStyle(fontSize: 14, color: Colors.white70);
        },
      ),
    );

    Color textColor = Colors.white;

    MaterialStateProperty<TextStyle> buttonText =
        MaterialStateProperty.resolveWith(
      (states) {
        if (states.contains(MaterialState.disabled)) {
          return TextStyle(fontSize: 14, color: textColor.withOpacity(0.5));
        } else {
          return TextStyle(fontSize: 14, color: textColor);
        }
      },
    );

    SSCButtonStyle primaryStyle = SSCButtonStyle(
      textStyle: buttonText,
      backgroundColor: MaterialStateProperty.resolveWith(
        (states) {
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
        },
      ),
      borderColor: MaterialStateProperty.resolveWith(
        (states) {
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
        },
      ),
    );

    SSCButtonStyle infoStyle = SSCButtonStyle(
      textStyle: buttonText,
      backgroundColor: MaterialStateProperty.resolveWith(
        (states) {
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
        },
      ),
      borderColor: MaterialStateProperty.resolveWith(
        (states) {
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
        },
      ),
    );

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
