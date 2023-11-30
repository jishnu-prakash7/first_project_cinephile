// ignore_for_file: non_constant_identifier_names

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
        style: GoogleFonts.ubuntu(
            textStyle: const TextStyle(
                fontSize: 15.8,
                color: Color.fromARGB(255, 176, 174, 174),
                fontWeight: FontWeight.w500)),
      ),
    ],
  );
}

divider() {
  return const Padding(
    padding: EdgeInsets.only(left: 5, right: 5),
    child: Divider(
      thickness: 2,
      color: Color.fromARGB(255, 90, 90, 90),
    ),
  );
}

String runtime(int time) {
  if (time <= 0) {
    return '0h 0m';
  }
  int hours = time ~/ 60;
  int minutes = time % 60;

  return '$hours h $minutes m';
}

//Vertical divider

verticaldivider() {
  return const Padding(
    padding: EdgeInsets.only(left: 8, right: 8),
    child: SizedBox(
        height: 15,
        child: VerticalDivider(
          width: 2,
          thickness: 2,
          color: Color.fromARGB(255, 106, 106, 106),
        )),
  );
}

//director language genere section

detailsScectionText(String text, double size, Color textcolor) {
  return Padding(
    padding: const EdgeInsets.only(top: 10, bottom: 10),
    child: Text(
      text,
      style: GoogleFonts.ubuntu(
          textStyle: TextStyle(
              color: textcolor, fontSize: size, fontWeight: FontWeight.w500)),
    ),
  );
}

//Comment session text

commentSessionText(username, Color color, double fontsize) {
  return Text(
    username,
    style: GoogleFonts.ubuntu(
        textStyle: TextStyle(color: color, fontSize: fontsize)),
  );
}
