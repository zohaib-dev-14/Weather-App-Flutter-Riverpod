import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStyles {
  static TextStyle h1(Color color) => GoogleFonts.lato(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: color,
      );

  static TextStyle h2(Color color) => GoogleFonts.lato(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: color,
      );

  static TextStyle h3(Color color) => GoogleFonts.lato(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: color,
      );

  static TextStyle subtitleText(Color color) => GoogleFonts.lato(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: color,
      );

  static TextStyle largeSubtitle(Color color) => GoogleFonts.lato(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: color,
      );
}
