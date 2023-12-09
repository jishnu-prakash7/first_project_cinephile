import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget privacyandtermsHeading(String heading) {
  return Padding(
    padding: EdgeInsets.only(bottom: 6),
    child: Text(
      heading,
      style: GoogleFonts.ubuntu(
          textStyle: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
    ),
  );
}

//privacypolicy content text

Widget privacyandtermsContent(String content) {
  return Padding(
    padding: EdgeInsets.only(bottom: 6),
    child: Text(
      content,
      style: GoogleFonts.ubuntu(
          textStyle: TextStyle(color: Color.fromARGB(255, 244, 243, 243))),
    ),
  );
}

//sizedbox

Widget sizedboxPrivacyPolicy() {
  return const SizedBox(
    height: 8,
  );
}
