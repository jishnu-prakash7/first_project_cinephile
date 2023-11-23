import 'package:firstprojectcinephile/models/movies.dart';
import 'package:firstprojectcinephile/widgets/main_refactoring.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

deletedialog(movies movie, BuildContext context) {
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
          content: Text('Are you sure want to delete?',
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
                onPressed: () {
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
