import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ColorsTheme {
  static ColorScheme get ligth => const ColorScheme.light(
        primary: Color(0xFF314759), //** */
        background: Colors.white, //** */
        secondary: Color(0xFF72C1F2), //** */
        secondaryVariant: Color(0xFF2B96D9), //** */
        surface: Color(0xFFF2F2F2), //** */
      );
  static ColorScheme get dark => const ColorScheme.dark(
        primary: Color(0xFFF2F2F2), //** */
        primaryVariant: Color(0xFF1A1E26), //** */
        secondary: Color(0xFF08090D), //** */
        background: Color(0xFF343A40), //** */
        surface: Color(0xFFA1A69C), //** */
        // primary: Color(0xFF131929), //background
        // primaryVariant: Color(0xFF323746), // primary
        // secondary: Color(0xFFEFF1F8),
        // secondaryVariant: Color(0xFFA6A6A6),
        // surface: Color(0xFF595959),
        // background: Color(0xFF131929),
        // error: Color(0xFF131929),
        // onPrimary: Color(0xFF131929),
        // onSecondary: Color(0xFFA6A6A6),
        // onSurface: Color(0xFFD9D9D9),
        // onBackground: Color(0xFF131929),
        // onError: Color(0xFF131929),
        // brightness: Brightness.dark,
      );
}

class Themes {
  static final baseTheme = ThemeData(
    primaryTextTheme: TextTheme(
      headline1: GoogleFonts.poppins(
        letterSpacing: 1.3,
        fontWeight: FontWeight.w700,
      ),
    ),
    iconTheme: IconThemeData(color: ColorsTheme.dark.secondary),
    textTheme: TextTheme(
      headline1: GoogleFonts.nunito(
        // titulos
        letterSpacing: 1.0,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w700,
      ),
      subtitle1: GoogleFonts.podkova(
        letterSpacing: 1.3,
        fontWeight: FontWeight.w500,
      ),
      subtitle2: GoogleFonts.nunito(
        fontWeight: FontWeight.w400,
        letterSpacing: 1,
        decoration: TextDecoration.none,
      ),
      bodyText1: GoogleFonts.nunito(
        fontWeight: FontWeight.w400,
        letterSpacing: 1,
        decoration: TextDecoration.none,
      ),
      bodyText2: GoogleFonts.nunito(
        // theme of input
        fontWeight: FontWeight.w400,
        letterSpacing: 1,
        decoration: TextDecoration.none,
      ),
      headline2: GoogleFonts.podkova(
        fontSize: 20,
        letterSpacing: 1.3,
        fontWeight: FontWeight.w700,
      ),
      headline3: GoogleFonts.nunito(
        fontSize: 30,
        letterSpacing: 1.3,
        fontWeight: FontWeight.w700,
      ),
      headline4: GoogleFonts.podkova(fontSize: 18, fontWeight: FontWeight.w700, letterSpacing: 2),
      headline5: GoogleFonts.podkova(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 2,
        color: ColorsTheme.dark.secondaryVariant,
      ),
      headline6: GoogleFonts.podkova(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 2,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    ),
    appBarTheme: AppBarTheme(
      color: ColorsTheme.dark.primaryVariant,
      titleTextStyle: GoogleFonts.nunito(
        color: ColorsTheme.dark.secondary,
        fontSize: 22,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
  static final light = baseTheme.copyWith(
    colorScheme: ColorsTheme.ligth,
    scaffoldBackgroundColor: ColorsTheme.ligth.surface,
  );
  static final dark = baseTheme.copyWith(
    colorScheme: ColorsTheme.dark,
    scaffoldBackgroundColor: ColorsTheme.dark.primaryVariant,
  );
}
