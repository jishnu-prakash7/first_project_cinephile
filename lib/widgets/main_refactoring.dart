// ignore_for_file: use_build_context_synchronously

import 'package:firstprojectcinephile/screens/user/user_login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Maintitle of App

Widget maintitle() {
  return RichText(
      text: TextSpan(children: [
    TextSpan(
        text: 'Cine',
        style: GoogleFonts.pacifico(
            textStyle:
                const TextStyle(fontSize: 35, fontWeight: FontWeight.bold))),
    TextSpan(
        text: 'p',
        style: GoogleFonts.pacifico(
            textStyle: const TextStyle(
                color: Colors.teal,
                fontSize: 35,
                fontWeight: FontWeight.bold))),
    TextSpan(
        text: 'hile',
        style: GoogleFonts.pacifico(
            textStyle:
                const TextStyle(fontSize: 35, fontWeight: FontWeight.bold)))
  ]));
}

//Logout AlertDialog

Future<dynamic> logoutAlertDialog(BuildContext ctx1, Function signout) {
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
                      textStyle: const TextStyle(color: Colors.black)),
                )),
            TextButton(
                onPressed: () {
                  Navigator.of(ctx1).pop();
                },
                child: Text('No',
                    style: GoogleFonts.ubuntu(
                        textStyle: const TextStyle(color: Colors.black))))
          ],
        );
      });
}

//logout route

void signout(BuildContext ctx) async {
  final sharedpref = await SharedPreferences.getInstance();
  await sharedpref.clear();
  Navigator.of(ctx).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx) {
    return const UserLogin();
  }), (route) => false);
}

//snackbar

void showSnackBar(BuildContext context, String content, Color backgroundColor) {
  final snackBar = SnackBar(
    content: Text(content),
    backgroundColor: backgroundColor,
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.all(10),
    elevation: 10,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

//Heading on appbar

appbarHeading(String heading, double size) {
  return Text(
    heading,
    style: GoogleFonts.ubuntu(
        textStyle: TextStyle(
            fontSize: size, fontWeight: FontWeight.w400, color: Colors.teal)),
  );
}

//Image picker

Future<XFile?> pickImageFormgallery() async {
  final pickedImage =
      await ImagePicker().pickImage(source: ImageSource.gallery);
  if (pickedImage != null) {
    return XFile(pickedImage.path);
  }
  return null;
}

//Rating Bar

ratingbar(movierating) {
  return RatingBar.builder(
      ignoreGestures: true,
      initialRating: movierating,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemSize: 17,
      itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
      onRatingUpdate: (rating) {});
}
