import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final ThemeData blueTheme = ThemeData.light(
  useMaterial3: true,
).copyWith(
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xff404C6E),
    onPrimary: Color(0xff404C6E),
    secondary: Color(0xffffffff),
    onSecondary: Color(0xffCDAD80),
    error: Color(0xffE0E1E0),
    onError: Color(0xffE0E1E0),
    surface: Color(0xffCDAD80),
    onSurface: Color(0xffE0E1E0),
    inversePrimary: Color(0xff000000),
    inverseSurface: Color(0xffCD9974),
    primaryContainer: Color(0xffFFFFFF),
    onPrimaryContainer: Color(0xfff3efdf),
    onInverseSurface: Color(0xff000000),
  ),
  primaryColor: const Color(0xff404C6E),
  primaryColorLight: const Color(0xff53618c),
  primaryColorDark: const Color(0xff404C6E),
  dialogBackgroundColor: const Color(0xffFFFFFF),
  dividerColor: const Color(0xffCDAD80),
  highlightColor: const Color(0xffCDAD80).withOpacity(0.25),
  indicatorColor: const Color(0xffCDAD80),
  scaffoldBackgroundColor: const Color(0xff404C6E),
  canvasColor: const Color(0xffFFFFFF),
  hoverColor: const Color(0xffFFFFFF).withOpacity(0.3),
  disabledColor: const Color(0Xff000000),
  hintColor: const Color(0xff404C6E),
  focusColor: const Color(0xffE0E1E0),
  secondaryHeaderColor: const Color(0xff53618c),
  cardColor: const Color(0xff404C6E),
  dividerTheme: const DividerThemeData(
    color: Color(0xffCDAD80),
  ),
  textSelectionTheme: TextSelectionThemeData(
      selectionColor: const Color(0xffE0E1E0).withOpacity(0.3),
      selectionHandleColor: const Color(0xffE0E1E0)),
  cupertinoOverrideTheme: const CupertinoThemeData(
    primaryColor: Color(0xff53618c),
  ),
);

final ThemeData brownTheme = ThemeData(
  useMaterial3: true,
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xff77554B),
    onPrimary: Color(0xff77554B),
    secondary: Color(0xffffffff),
    onSecondary: Color(0xffFFEEDC),
    error: Color(0xffCD9974),
    onError: Color(0xffCD9974),
    surface: Color(0xffCD9974),
    onSurface: Color(0xffCD9974),
    inversePrimary: Color(0xff000000),
    inverseSurface: Color(0xffCD9974),
    primaryContainer: Color(0xffFFFBF8),
    onPrimaryContainer: Color(0xffFFFBF8),
    onInverseSurface: Color(0xff000000),
  ),
  primaryColor: const Color(0xff77554B),
  primaryColorLight: const Color(0xffFFEEDC),
  primaryColorDark: const Color(0xff77554B),
  dialogBackgroundColor: const Color(0xffFFFBF8),
  dividerColor: const Color(0xffFFEEDC),
  highlightColor: const Color(0xffCD9974).withOpacity(0.25),
  indicatorColor: const Color(0xffFFEEDC),
  scaffoldBackgroundColor: const Color(0xff77554B),
  canvasColor: const Color(0xffF2E5D5),
  hoverColor: const Color(0xffF2E5D5).withOpacity(0.3),
  disabledColor: const Color(0xff000000),
  hintColor: const Color(0xff000000),
  focusColor: const Color(0xff77554B),
  secondaryHeaderColor: const Color(0xff77554B),
  cardColor: const Color(0xff77554B),
  textSelectionTheme: TextSelectionThemeData(
      selectionColor: const Color(0xffCD9974).withOpacity(0.3),
      selectionHandleColor: const Color(0xffCD9974)),
  cupertinoOverrideTheme: const CupertinoThemeData(
    primaryColor: Color(0xffCD9974),
  ),
);

final ThemeData oldTheme = ThemeData.light(
  useMaterial3: true,
).copyWith(
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xff232c13),
    onPrimary: Color(0xff161f07),
    secondary: Color(0xfff3efdf),
    onSecondary: Color(0xff91a57d),
    error: Color(0xffE0E1E0),
    onError: Color(0xffE0E1E0),
    surface: Color(0xff91a57d),
    onSurface: Color(0xffE0E1E0),
    inversePrimary: Color(0xff000000),
    inverseSurface: Color(0xffCD9974),
    primaryContainer: Color(0xfff3efdf),
    onPrimaryContainer: Color(0xfff3efdf),
    onInverseSurface: Color(0xff000000),
  ),
  primaryColor: const Color(0xff232c13),
  primaryColorLight: const Color(0xff53618c),
  primaryColorDark: const Color(0xff161f07),
  dialogBackgroundColor: const Color(0xfff3efdf),
  dividerColor: const Color(0xff91a57d),
  highlightColor: const Color(0xff91a57d).withOpacity(0.25),
  indicatorColor: const Color(0xff91a57d),
  scaffoldBackgroundColor: const Color(0xff232c13),
  canvasColor: const Color(0xfff3efdf),
  hoverColor: const Color(0xfff3efdf).withOpacity(0.3),
  disabledColor: const Color(0xff000000),
  hintColor: const Color(0xff232c13),
  focusColor: const Color(0xffE0E1E0),
  secondaryHeaderColor: const Color(0xff53618c),
  cardColor: const Color(0xff232c13),
  dividerTheme: const DividerThemeData(
    color: Color(0xff91a57d),
  ),
  textSelectionTheme: TextSelectionThemeData(
      selectionColor: const Color(0xffE0E1E0).withOpacity(0.3),
      selectionHandleColor: const Color(0xffE0E1E0)),
  cupertinoOverrideTheme: const CupertinoThemeData(
    primaryColor: Color(0xff53618c),
  ),
);

final ThemeData darkTheme = ThemeData.dark(
  useMaterial3: true,
).copyWith(
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xff404C6E),
    onPrimary: Color(0xff000000),
    secondary: Color(0xffffffff),
    onSecondary: Color(0xff373737),
    error: Color(0xff404C6E),
    onError: Color(0xff404C6E),
    surface: Color(0xffCDAD80),
    onSurface: Color(0xff404C6E),
    inversePrimary: Color(0xffffffff),
    inverseSurface: Color(0xffCD9974),
    primaryContainer: Color(0xff1E1E1E),
    onPrimaryContainer: Color(0xff1E1E1E),
    onInverseSurface: Color(0xff000000),
  ),
  primaryColor: const Color(0xff1E1E1E),
  primaryColorLight: const Color(0xff373737),
  primaryColorDark: const Color(0xff010101),
  dialogBackgroundColor: const Color(0xff1E1E1E),
  dividerColor: const Color(0xff404C6E),
  highlightColor: const Color(0xff404C6E).withOpacity(0.25),
  indicatorColor: const Color(0xff404C6E),
  scaffoldBackgroundColor: const Color(0xff000000),
  canvasColor: const Color(0xffF6F6EE),
  hoverColor: const Color(0xffF6F6EE).withOpacity(0.3),
  disabledColor: const Color(0xff000000),
  hintColor: const Color(0xffffffff),
  focusColor: const Color(0xff404C6E),
  secondaryHeaderColor: const Color(0xff404C6E),
  cardColor: const Color(0xffF6F6EE),
  textSelectionTheme: TextSelectionThemeData(
      selectionColor: const Color(0xff404C6E).withOpacity(0.3),
      selectionHandleColor: const Color(0xff404C6E)),
  cupertinoOverrideTheme: const CupertinoThemeData(
    primaryColor: Color(0xff404C6E),
  ),
);
