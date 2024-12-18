import 'package:flutter/material.dart';
import 'package:flutter_machine_test/constants/text_styles.dart';
import 'colors.dart';

class UiStyles {
  static customisedButton(String title, Color color, Function function) {
    return GestureDetector(
      onTap: (){
        function;
      },
      child: Container(
        height: 50,
        width: 350,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: color,
        ),
        child: Center(
          child: Text(title,
              style: TextStyleClass.poppins600TextStyle(14, ColorClass.white)),
        ),
      ),
    );
  }

  static customisedGreenButton(String title, Color color, Function function) {
    return Container(
      height: 50,
      width: 350,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: color,
      ),
      child: Center(
        child: Text(title,
            style: TextStyleClass.poppins600TextStyle(14, ColorClass.black)),
      ),
    );
  }

  static customisedSmallButton(String title, Color color, Function function) {
    return Container(
      height: 45,
      width: 85,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: color,
      ),
      child: Center(
        child: Text(title,
            style: TextStyleClass.poppins600TextStyle(14, ColorClass.white)),
      ),
    );
  }
}
