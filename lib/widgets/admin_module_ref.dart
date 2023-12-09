// ignore_for_file: use_build_context_synchronously

import 'package:firstprojectcinephile/models/movie.dart';
import 'package:firstprojectcinephile/screens/movie/movie_add_screen/screen.dart';
import 'package:firstprojectcinephile/widgets/main_refactoring.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//delete movie alertdialog

deletedialog(movies movie, BuildContext context, int index) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Delete Movie',
            style: GoogleFonts.ubuntu(
                textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
          ),
          content: Text('Are you sure want to Delete?',
              style: GoogleFonts.ubuntu(
                  textStyle: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.normal,
                      color: Colors.black))),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'No',
                  style: GoogleFonts.ubuntu(
                      textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black)),
                )),
            TextButton(
                onPressed: () async {
                  deleteMovie(movie, context);
                  Navigator.of(context).pop();
                },
                child: Text('yes',
                    style: GoogleFonts.ubuntu(
                        textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black))))
          ],
        );
      });
}

void deleteMovie(movies movie, BuildContext context) async {
  await movie.delete();
  showSnackBar(context, 'Movie Deleted Succesfully', Colors.red);
}

//admin panel addmovie button

adminPanelFloatingActionButton(context) {
  return FloatingActionButton.extended(
    splashColor: Colors.green,
    backgroundColor: Colors.white,
    onPressed: () {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return const addMovieScreen();
      }));
    },
    label: Text(
      'Movie',
      style: GoogleFonts.ubuntu(
          textStyle: const TextStyle(
              fontWeight: FontWeight.w500, color: Colors.black, fontSize: 19)),
    ),
    icon: const Icon(Icons.add, color: Colors.black, size: 30),
  );
}

//details text in adminpanel

adminpanelDetailsText(String text, double fontsize, FontWeight fontweight) {
  final word = text[0].toUpperCase() + text.substring(1);
  return Text(
    word,
    style: GoogleFonts.ubuntu(
        textStyle: TextStyle(
            color: Colors.black, fontSize: fontsize, fontWeight: fontweight)),
    softWrap: false,
    maxLines: 1,
    overflow: TextOverflow.fade,
  );
}
