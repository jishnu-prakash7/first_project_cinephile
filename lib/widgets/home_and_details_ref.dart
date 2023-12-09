// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//Details page Rating and genre

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

//Details screen divider

divider() {
  return const Padding(
    padding: EdgeInsets.only(left: 5, right: 5),
    child: Divider(
      thickness: 2,
      color: Color.fromARGB(255, 90, 90, 90),
    ),
  );
}

//runtime min to hours

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
  final word = username[0].toUpperCase() + username.substring(1);
  return Text(
    word,
    style: GoogleFonts.ubuntu(
        textStyle: TextStyle(color: color, fontSize: fontsize)),
  );
}

//categories button home screen

Widget catagoriesButton(String title, void Function() onPressed) {
  return GestureDetector(
    onTap: onPressed,
    child: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: Container(
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 71, 71, 71),
              borderRadius: BorderRadius.circular(5)),
          height: 30,
          width: 75,
          child: Center(
              child: Text(
            title,
            style: GoogleFonts.ubuntu(
                textStyle: const TextStyle(color: Colors.white)),
          )),
        )),
  );
}

//searchbar

Widget searchBar(
    Function(String value) onChanged, TextEditingController searchController) {
  return TextFormField(
    onChanged: onChanged,
    controller: searchController,
    style: const TextStyle(color: Colors.white),
    decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(30)),
        contentPadding: const EdgeInsets.all(0),
        enabledBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: Color.fromARGB(255, 41, 41, 41)),
            borderRadius: BorderRadius.circular(30)),
        fillColor: const Color.fromARGB(255, 41, 41, 41),
        filled: true,
        prefixIcon: const Icon(
          Icons.search,
          color: Color.fromARGB(255, 209, 207, 207),
        ),
        hintText: 'Search Movies',
        hintStyle: GoogleFonts.ubuntu(
            textStyle:
                const TextStyle(color: Color.fromARGB(255, 223, 222, 222))),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
  );
}
