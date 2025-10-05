import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SuperscriptText extends StatelessWidget {
  const SuperscriptText({
    super.key,
    required this.text,
    required this.color,
    required this.superScript,
    required this.superScriptColor,
  });
  final String text;
  final Color color;
  final String superScript;
  final Color superScriptColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: GoogleFonts.poppins(
            color: color,
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          superScript,
          style: TextStyle(
            color: superScriptColor,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

