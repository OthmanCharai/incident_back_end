import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:incidence_front/shared/styles/theme.dart';

Widget _loginBtn() {
  return Container(
    width: double.infinity,
    height: 60,
    decoration: const BoxDecoration(
      color: primaryClr,
      borderRadius: BorderRadius.all(Radius.circular(14)),
    ),
    child: TextButton(
      onPressed: () => {},
      child: Text(
        "login_login_btn".tr(),
        style: GoogleFonts.gothicA1(
          textStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 24,
          ),
        ),
      ),
    ),
  );
}
