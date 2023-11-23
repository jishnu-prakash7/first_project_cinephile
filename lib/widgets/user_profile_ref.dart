// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

textformfieldUserEdit(String labelText, TextEditingController Controller,
    RegExp regex, String validationmessage, String regexmessage,
    {bool? obscuretext = false}) {
  return TextFormField(
    autovalidateMode: AutovalidateMode.onUserInteraction,
    obscureText: obscuretext!,
    controller: Controller,
    validator: (value) {
      if (!regex.hasMatch(value!)) {
        return regexmessage;
      } else if (value.isEmpty) {
        return validationmessage;
      }
      return null;
    },
    style: TextStyle(color: Colors.white),
    decoration: InputDecoration(
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.teal)),
        focusedBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: const Color.fromARGB(255, 1, 109, 98))),
        labelStyle: TextStyle(color: Colors.grey),
        labelText: labelText),
  );
}

//UserProfile listTile

listTile(String title, {Color? textcolor, IconButton? iconbutton}) {
  return ListTile(
    title: Row(
      children: [
        Text(
          title,
          style: GoogleFonts.ubuntu(
              textStyle:
                  TextStyle(color: textcolor ?? Colors.white, fontSize: 18)),
        ),
        if (iconbutton != null)
          Align(
            child: iconbutton,
          ),
      ],
    ),
  );
}
