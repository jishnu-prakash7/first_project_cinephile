// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget RatingAndGenereSection(String rating, IconData icon, Color iconcolor) {
  return Row(
    children: [
      Padding(
        padding: const EdgeInsets.only(right: 8),
        child: Icon(
          icon,
          color: iconcolor,
          size: 18,
        ),
      ),
      Text(
        rating,
        style: GoogleFonts.ubuntu(textStyle: TextStyle(
            fontSize: 15.8,
            color: Color.fromARGB(255, 176, 174, 174),
            fontWeight: FontWeight.w500)),
      ),
    ],
  );
}
