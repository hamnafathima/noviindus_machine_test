import 'package:flutter/material.dart';

const String primaryFontName = 'Poppins';

class TextStyleClass {
  static const double textHeight = 1.4;

  //  POPPINS  //

  static TextStyle poppins300TextStyle(double fontsize, Color color) {
    return TextStyle(
        fontFamily: primaryFontName,
        color: color,
        fontWeight: FontWeight.w400,
        height: textHeight,
        fontSize: fontsize);
  }

  static TextStyle poppins400TextStyle(double fontsize, Color color) {
    return TextStyle(
        fontFamily: primaryFontName,
        color: color,
        fontWeight: FontWeight.w400,
        height: textHeight,
        fontSize: fontsize);
  }

  static TextStyle poppins500TextStyle(double fontsize, Color color) {
    return TextStyle(
        fontFamily: primaryFontName,
        color: color,
        fontWeight: FontWeight.w500,
        height: textHeight,
        fontSize: fontsize);
  }

  static TextStyle poppins600TextStyle(double fontsize, Color color) {
    return TextStyle(
        fontFamily: primaryFontName,
        color: color,
        fontWeight: FontWeight.w600,
        height: textHeight,
        fontSize: fontsize);
  }

  static TextStyle poppins700TextStyle(double fontsize, Color color) {
    return TextStyle(
        fontFamily: primaryFontName,
        color: color,
        fontWeight: FontWeight.w700,
        height: textHeight,
        fontSize: fontsize);
  }
}
