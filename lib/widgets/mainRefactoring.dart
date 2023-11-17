// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Maintitle of App

Widget maintitle() {
  return RichText(
      text: TextSpan(children: [
    TextSpan(
        text: 'Cine',
        style: GoogleFonts.pacifico(
            textStyle: TextStyle(fontSize: 35, fontWeight: FontWeight.bold))),
    TextSpan(
        text: 'p',
        style: GoogleFonts.pacifico(
            textStyle: TextStyle(
                color: Colors.green,
                fontSize: 35,
                fontWeight: FontWeight.bold))),
    TextSpan(
        text: 'hile',
        style: GoogleFonts.pacifico(
            textStyle: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)))
  ]));
}

//Logout AlertDialog

Future<dynamic> logoutAlertDialog(BuildContext ctx1,Function signout){
  return showDialog(
                      context: ctx1,
                      builder: (ctx) {
                        return AlertDialog(
                          title: Text(
                            'Logout',
                            style: GoogleFonts.ubuntu(),
                          ),
                          content: Text(
                            'Areyou sure want to logout?',
                            style: GoogleFonts.ubuntu(),
                          ),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  signout(ctx1);
                                },
                                child: Text(
                                  'Yes',
                                  style: GoogleFonts.ubuntu(
                                      textStyle:
                                          TextStyle(color: Colors.black)),
                                )),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(ctx1).pop();
                                },
                                child: Text('No',
                                    style: GoogleFonts.ubuntu(
                                        textStyle:
                                            TextStyle(color: Colors.black))))
                          ],
                        );
                      });
}

//snackbar

// void showSnackBar(BuildContext context,String content,Color backgroundColor) {
//     final snackBar = SnackBar(
//       content: Text(content),
//       backgroundColor:backgroundColor,
//       behavior: SnackBarBehavior.floating,
//       margin: EdgeInsets.all(10),
//       elevation: 10,
//     );
//     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//   }