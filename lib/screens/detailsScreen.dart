// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:firstprojectcinephile/models/movies.dart';
import 'package:firstprojectcinephile/widgets/homeAndDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DetailsScreen extends StatefulWidget {
  final movies movie;
  const DetailsScreen({Key? key, required this.movie}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.14),
        child: Container(
          padding: EdgeInsets.all(18),
          child: AppBar(
            primary: false,
            flexibleSpace: Padding(padding: EdgeInsets.all(20)),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            backgroundColor: Colors.black,
            elevation: 0,
            leading: IconButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        side: BorderSide(width: 2))),
                    ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.arrow_back_ios, color: Colors.white)),
            title: Text(
              'Details',
              style: GoogleFonts.ubuntu(
                  textStyle: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.bookmark, color: Colors.white))
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: MediaQuery.of(context).size.width,
              child: Image.file(
                File(widget.movie.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 8,
                right: 8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      '${widget.movie.title} (${DateFormat('yyyy').format(widget.movie.releaseyear)})',
                      style: GoogleFonts.ubuntu(
                          textStyle: TextStyle(
                              color: Color.fromARGB(255, 211, 210, 210),
                              fontSize: 20,
                              fontWeight: FontWeight.w500)),
                    ),
                  ),
                  Row(
                    children: [
                      RatingAndGenereSection(
                        DateFormat('dd-MMM-yyyy')
                            .format(widget.movie.releaseyear),
                        Icons.calendar_today,
                        Color.fromARGB(255, 234, 233, 233),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: SizedBox(
                            height: 15,
                            child: VerticalDivider(
                              width: 2,
                              thickness: 2,
                              color: Color.fromARGB(255, 106, 106, 106),
                            )),
                      ),
                      RatingAndGenereSection(
                        runtime(widget.movie.time),
                        FontAwesomeIcons.clock,
                        Color.fromARGB(255, 234, 233, 233),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: SizedBox(
                            height: 15,
                            child: VerticalDivider(
                              width: 2,
                              thickness: 2,
                              color: Color.fromARGB(255, 106, 106, 106),
                            )),
                      ),
                      RatingBar.builder(
                          ignoreGestures: true,
                          initialRating: widget.movie.movierating,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 17,
                          itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                          onRatingUpdate: (rating) {}),
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: SizedBox(
                            height: 15,
                            child: VerticalDivider(
                              width: 2,
                              thickness: 2,
                              color: Color.fromARGB(255, 106, 106, 106),
                            )),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: FaIcon(
                            FontAwesomeIcons.shareFromSquare,
                            color: Colors.grey,
                          ))
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
                    child: Divider(
                      thickness: 2,
                      color: Color.fromARGB(255, 90, 90, 90),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      'Director : ${widget.movie.moviedirector}',
                      style: GoogleFonts.ubuntu(
                        textStyle: TextStyle(
                            color: Color.fromARGB(255, 211, 210, 210),
                            fontWeight: FontWeight.w500,
                            fontSize: 17),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      'Language : ${widget.movie.movielanguage}',
                      style: GoogleFonts.ubuntu(
                        textStyle: TextStyle(
                            color: Color.fromARGB(255, 211, 210, 210),
                            fontWeight: FontWeight.w500,
                            fontSize: 17),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      'Genere : ${widget.movie.moviegenre}',
                      style: GoogleFonts.ubuntu(
                        textStyle: TextStyle(
                            color: Color.fromARGB(255, 211, 210, 210),
                            fontWeight: FontWeight.w500,
                            fontSize: 17),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: Divider(
                      thickness: 2,
                      color: Color.fromARGB(255, 90, 90, 90),
                    ),
                  ),
                  Text(
                    widget.movie.review,
                    style: GoogleFonts.ubuntu(
                        textStyle: TextStyle(
                            color: const Color.fromARGB(255, 236, 234, 234),
                            fontSize: 15)),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }

  String runtime(int time) {
    if (time <= 0) {
      return '0h 0m';
    }

    int hours = time ~/ 60;
    int minutes = time % 60;

    return '$hours h $minutes m';
  }
}
