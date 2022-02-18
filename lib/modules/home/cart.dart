import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:incidence_front/shared/networks/remote/constante.dart';

Widget cart({
  required String name,
  required String cin,
  required String incident,
  required String incident_date,
  required String note,
  required String path,
  required Function()? onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        color: kSecondaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Expanded(
        child: Row(
          children: [
            Container(
              child: Image(
                  width: 150,
                  height: 145,
                  fit: BoxFit.cover,
                  image: NetworkImage(path)),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsetsDirectional.only(start: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      name,
                      maxLines: 1,
                      style: GoogleFonts.gothicA1(
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 25.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      cin,
                      maxLines: 1,
                      style: GoogleFonts.gothicA1(
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      incident+":"+incident_date,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.gothicA1(
                        textStyle: TextStyle(
                          color: Colors.black.withOpacity(0.7),
                          fontWeight: FontWeight.w500,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      note,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                
                      style: GoogleFonts.gothicA1(
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}
