import 'dart:io';

import 'package:firstprojectcinephile/models/movie.dart';
import 'package:firstprojectcinephile/screens/movie/movie_details_screen/screen.dart';
import 'package:firstprojectcinephile/widgets/home_and_details_ref.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

//movie Section

Widget movieSection(BuildContext context, movies movieone, int index) {
  return Column(
    children: [
      GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return DetailsScreen(
              movie: movieone,
              movieindex: index,
            );
          }));
        },
        child: SizedBox(
          height: 200,
          width: MediaQuery.of(context).size.width,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.file(
                File(movieone.imageUrl),
                fit: BoxFit.cover,
              )),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 10),
        child: GestureDetector(
          onTap: () {
            // Navigator.push(
            //     context,
            //     PageTransition(
            //         type: PageTransitionType.fade,
            //         child: DetailsScreen(
            //           movie: movieone,
            //           movieindex: index,
            //         )));
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return DetailsScreen(
                movieindex: index,
                movie: movieone,
              );
            }));
          },
          child: Row(
            children: [
              detailsScectionText(
                  '${movieone.title} (${DateFormat('yyyy').format(movieone.releaseyear)})',
                  17,
                  Colors.white)
            ],
          ),
        ),
      ),
      RatingAndGenereSection(
          movieone.movierating.toString(), Icons.star, Colors.amber)
    ],
  );
}


