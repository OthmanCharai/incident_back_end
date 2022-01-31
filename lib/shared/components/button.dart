import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:incidence_front/shared/styles/theme.dart';


class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String label;

  MyButton({
    required this.onTap,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 150,
        decoration: BoxDecoration(
          color: primaryClr,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Center(
          child: Text(
            label,
            style: GoogleFonts.josefinSans(
            textStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 24,
            ),
          ),
          ),
        ),
      ),
    );
  }
}
