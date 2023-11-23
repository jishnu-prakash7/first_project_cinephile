
// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Textformfield in login and signup page

Widget LoginTextformField(
    String hintText,
    String validatormessage,
    TextEditingController controllers,
    TextInputType textType,
    bool value,
    IconData preIcon,
    String validationmessage,
    RegExp regex) {
  return Container(
    width: 230,
    child: TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: value,
      keyboardType: textType,
      controller: controllers,
      validator: (value) {
        if (!regex.hasMatch(value!)) {
          return validationmessage;
        } else if (value.isEmpty) {
          return validatormessage;
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
          hintText: hintText,
          labelStyle: TextStyle(color: Colors.black),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  color: const Color.fromARGB(255, 9, 8, 8), width: 1.5)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.black, width: 1)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.black, width: 1),
          )),
    ),
  );
}

//text on the top of textformfield in login and signup page

Widget textabovetextfield(String text) {
  return Padding(
    padding: const EdgeInsets.only(top: 10, bottom: 10),
    child: Text(
      text,
      style: GoogleFonts.ubuntu(
          textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
    ),
  );
}

//elevated button in login and signup

Widget Elevatedbutton(String text, bool validator) {
  return Padding(
    padding: const EdgeInsets.only(top: 30),
    child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 21, 21, 21),
            fixedSize: Size(200, 40),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
        onPressed: () {
          validator;
        },
        child: Text(
          text,
          style: GoogleFonts.ubuntu(
              textStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: Colors.white)),
        )),
  );
}
