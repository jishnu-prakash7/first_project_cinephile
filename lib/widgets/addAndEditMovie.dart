// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//Title of fields

Widget addAndEditMovieTitile(String name) {
  return Padding(
    padding: const EdgeInsets.only(top: 8, bottom: 8),
    child: Text(
      name,
      style: GoogleFonts.ubuntu(
          textStyle: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500)),
    ),
  );
}

//Textformfield

Widget addAndEditMovieTextField(
  String hintText,
  TextEditingController controller,
  String errormessage,
  TextInputType keyboardtype

) {
  return Container(
    width: 170,
    decoration: BoxDecoration(),
    child: Column(
      children: [
        TextFormField(
          keyboardType: keyboardtype,
          validator: (value) {
            if (value!.isEmpty) {
              return errormessage;
            } else {
              return null;
            }
          },
          controller: controller,
          style: TextStyle(fontSize: 15, color: Colors.white),
          decoration: InputDecoration(
              fillColor: Color.fromARGB(255, 39, 38, 38),
              filled: true,
              contentPadding: EdgeInsets.only(left: 20),
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.white),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.grey, width: 2)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                    color: const Color.fromARGB(255, 247, 247, 247),
                    ),
              )),
        ),
      ],
    ),
  );
}
