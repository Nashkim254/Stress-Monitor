part of '../helpers.dart';

/// Light Mode
ThemeData themeDataLight(BuildContext context) {
  return ThemeData(
    appBarTheme: const AppBarTheme(color: Colors.transparent, elevation: 0),
    primaryColor: primaryColor,
    errorColor: errorLight,
    primarySwatch: Colors.blue,
    hintColor: accentLight,
    cardColor: cardLightColor,
    brightness: Brightness.light,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: primaryLight,
    ),
    fontFamily: 'Inter',
    unselectedWidgetColor: unSelectedLight,
    scaffoldBackgroundColor: backgroundLight,
    backgroundColor: backgroundLight,
    iconTheme: IconThemeData(color: backgroundDark),
    primaryIconTheme: IconThemeData(color: backgroundDark),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    indicatorColor: primaryLight,
    buttonTheme: ButtonThemeData(
      minWidth: 120.0,
      height: 45.0,
      buttonColor: primaryLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: selectedLight,
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: primaryLight,
        ),
      ),
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
        color: whiteShadeColor,
        fontSize: 96,
        fontWeight: FontWeight.w500,
      ),
      headline2: TextStyle(
        color: primaryLight,
        fontSize: 60,
        fontWeight: FontWeight.w700,
      ),
      headline3: TextStyle(
        color: primaryLight,
        fontSize: 48,
        fontWeight: FontWeight.w700,
      ),
      headline4: TextStyle(
        color: primaryLight,
        fontSize: 34,
        fontWeight: FontWeight.bold,
      ),
      headline5: TextStyle(
        color: backgroundLight,
        fontSize: 24,
        fontWeight: FontWeight.w500,
      ),
      headline6: TextStyle(
        color: backgroundLight,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
      bodyText1: TextStyle(
          color: cardLightColor,
          fontSize: 20.0,
          fontFamily:  "Inter-Regular"
      ),
      bodyText2: TextStyle(
        color: blackColor,
        fontSize: 14.0,
        fontWeight: FontWeight.w600,
      ),
      subtitle1: TextStyle(
        color: whiteShadeColor,
        fontSize: 16.0,
      ),
      subtitle2: TextStyle(
        color: accentLight,
        fontSize: 14.0,
      ),
      button: TextStyle(
        color: backgroundLight,
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
      ),
      caption: TextStyle(
        color: backgroundLight,
        fontSize: 12.0,
        fontWeight: FontWeight.w400,
      ),
      overline: TextStyle(
        color: homeWidgetColor,
        fontSize: 10.0,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

/// Dark Mode
ThemeData themeDataDark(BuildContext context) {
  return ThemeData(
    appBarTheme: const AppBarTheme(color: Colors.transparent, elevation: 0),
    primaryColor: primaryColor,
    errorColor: errorLight,
    primarySwatch: Colors.blue,
    hintColor: accentLight,
    cardColor: cardLightColor,
    brightness: Brightness.light,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: primaryLight,
    ),
    fontFamily: 'Inter',
    unselectedWidgetColor: unSelectedLight,
    scaffoldBackgroundColor: backgroundLight,
    backgroundColor: backgroundLight,
    iconTheme: IconThemeData(color: backgroundDark),
    primaryIconTheme: IconThemeData(color: backgroundDark),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    indicatorColor: primaryLight,
    buttonTheme: ButtonThemeData(
      minWidth: 120.0,
      height: 45.0,
      buttonColor: primaryLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: selectedLight,
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: primaryLight,
        ),
      ),
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
        color: whiteShadeColor,
        fontSize: 96,
        fontWeight: FontWeight.w500,
      ),
      headline2: TextStyle(
        color: primaryLight,
        fontSize: 60,
        fontWeight: FontWeight.w700,
      ),
      headline3: TextStyle(
        color: primaryLight,
        fontSize: 48,
        fontWeight: FontWeight.w700,
      ),
      headline4: TextStyle(
        color: primaryLight,
        fontSize: 34,
        fontWeight: FontWeight.bold,
      ),
      headline5: TextStyle(
        color: backgroundLight,
        fontSize: 24,
        fontWeight: FontWeight.w500,
      ),
      headline6: TextStyle(
        color: backgroundLight,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
      bodyText1: TextStyle(
          color: accentDark,
          fontSize: 16.0,
          fontWeight: FontWeight.w400
      ),
      bodyText2: TextStyle(
        color: primaryLight,
        fontSize: 14.0,
      ),
      subtitle1: TextStyle(
        color: whiteShadeColor,
        fontSize: 16.0,
      ),
      subtitle2: TextStyle(
        color: accentLight,
        fontSize: 14.0,
      ),
      button: TextStyle(
        color: backgroundLight,
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
      ),
      caption: TextStyle(
        color: backgroundLight,
        fontSize: 12.0,
        fontWeight: FontWeight.w400,
      ),
      overline: TextStyle(
        color: homeWidgetColor,
        fontSize: 10.0,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
