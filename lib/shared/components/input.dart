import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:incidence_front/shared/styles/theme.dart';
import 'package:intl/intl.dart';

class InputField extends StatelessWidget {
  final String title;
  final String hint;
  bool isPassword;

  final IconData? suffixIcon;
  final Function()? onPressed;
  final String? Function(String?)? validator;
  final TextEditingController textController;

  InputField({
    required this.title,
    required this.hint,
    this.suffixIcon,
    this.onPressed,
    this.isPassword = false,
    required this.validator,
    required this.textController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.josefinSans(
            textStyle: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w800,
              fontSize: 24,
            ),
          ),
        ),
        SizedBox(
          height: 8.0,
        ),
        Container(
          height: 60,
          child: TextFormField(
            obscureText: isPassword,
            validator: validator,
            controller: textController,
            decoration: InputDecoration(
              errorStyle: const TextStyle(fontSize: 0.01),
              hintText: hint,
              hintStyle: subTitleTextStle,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              suffix: IconButton(
                icon: Icon(suffixIcon),
                onPressed: onPressed,
              ),
            ),
          ),
        )
      ],
    );
  }
}
