import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:incidence_front/modules/incident/add_client.dart';
import 'package:incidence_front/shared/networks/remote/constante.dart';
import 'package:incidence_front/shared/styles/theme.dart';

Widget categories({
  required String text,
  required Function()? onTap,
  required bool isSelected,
}) {
  return Container(
    width: 72.0,
    decoration: BoxDecoration(
      border: Border.all(color: Colors.black),
      borderRadius: BorderRadius.circular(5.0),
      color: isSelected
          ? primaryClr.withOpacity(0.4)
          : kSecondaryColor.withOpacity(0.1),
    ),
    child: GestureDetector(
      onTap: onTap,
      child: Center(
          child: Text(
        text,
        textAlign: TextAlign.center,
        style: GoogleFonts.josefinSans(
          textStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w300,
            fontSize: 15.0,
          ),
        ),
      )),
    ),
  );
}

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
Widget search({
  required void Function(String)? onChanged,
  required TextEditingController? textEditingController,
  required String label,
}) {
  return Container(
    width: 282,
    decoration: BoxDecoration(
      color: kSecondaryColor.withOpacity(0.1),
      borderRadius: BorderRadius.circular(15),
    ),
    child: TextField(
      onChanged: onChanged,
      controller: textEditingController,
      
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          hintText:label,
          prefixIcon: Icon(Icons.search)),
    ),
  );
}
